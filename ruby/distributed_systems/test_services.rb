#!/usr/bin/env ruby
require 'net/http'
require 'json'

def wait_until_get_pid(port)
  pid_command = "ps aux | grep '#{port}' | grep puma | grep -v grep | awk '{print $2}' "

  begin
    pid = `#{pid_command}`
  end while pid == ''

  pid
end

def create_server(port, number, is_first_server = true, existing_port = '3000')
  system("sh create_server.sh #{number}")

  thr = Thread.new do
    if is_first_server
      system("cd distributed_system_#{number};  FIRST_SERVER=true rails s -p #{port} &")
    else
      system("cd distributed_system_#{number};  HOST_SERVER=http://localhost:#{existing_port} rails s -p #{port} &")
    end
  end
end

def kill_server(pid, number)
  system("kill -9 #{pid}")
  system("rm -rf distributed_system_#{number}")
end

def expect!(received, expected)
  if received == expected
    puts "\e[#{32}m--- TEST OK ---\e[0m"
  else
    puts "\e[#{31}m--------- NOT EQUAL. Expected #{expected}; Received #{received}\e[0m"
  end
end

def wait_for(time)
  done = 0
  time.to_i.times.each do
    print("Waiting for #{time.to_i - done} ...\r")
    done += 1
    sleep(1)
  end
end

def get(url)
  Net::HTTP.get(URI(url))
end

begin
  create_server('3000', 1)
  pid1 = wait_until_get_pid('3000')

  create_server('3001', 2, false, '3000')
  pid2 = wait_until_get_pid('3001')

  hosts = File.open('distributed_system_1/hosts.csv', 'r') { |f| f.read }.split("\n")
  expect!(hosts, ["http://localhost:3001"])

  hosts = File.open('distributed_system_2/hosts.csv', 'r') { |f| f.read }.split("\n")
  expect!(hosts, ["http://localhost:3000"])

  get('http://localhost:3000/planes/-KzcocrWhEx8Fw2oivI0/try_to_reserve/6')
  reserved_resources = JSON.parse(File.open('distributed_system_1/reserved_resources.csv', 'r') { |f| f.read })
  expect!(reserved_resources['resource'], {"plane_id"=>"-KzcocrWhEx8Fw2oivI0", "plane_name"=>"Plane 04", "seat_number"=>"6"})


  get('http://localhost:3001/planes/-KzcocrWhEx8Fw2oivI0/try_to_reserve/7')
  reserved_resources = JSON.parse(File.open('distributed_system_2/reserved_resources.csv', 'r') { |f| f.read })
  expect!(reserved_resources['resource'], {"plane_id"=>"-KzcocrWhEx8Fw2oivI0", "plane_name"=>"Plane 04", "seat_number"=>"7"})

  wait_for(65)

  reserved_resources = File.open('distributed_system_2/reserved_resources.csv', 'r') { |f| f.read }
  expect!(reserved_resources, '')

  reserved_resources = File.open('distributed_system_1/reserved_resources.csv', 'r') { |f| f.read }
  expect!(reserved_resources, '')
ensure
  kill_server(pid1, 1)
  kill_server(pid2, 2)
  exit
end

