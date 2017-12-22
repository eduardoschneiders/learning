#!/usr/bin/env ruby

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
    puts "--- TEST OK ---"
  else
    puts "NOT EQUAL. Expected #{expected}; Received #{received}"
  end
end

create_server('3000', 1)
pid1 = wait_until_get_pid('3000')

create_server('3001', 2, false, '3000')
pid2 = wait_until_get_pid('3001')

p "Server started #{pid1}"
p "Server started #{pid2}"

hosts = File.open('distributed_system_1/hosts.csv', 'r') { |f| f.read }.split("\n")
expect!(hosts, ["http://localhost:3001"])

hosts = File.open('distributed_system_2/hosts.csv', 'r') { |f| f.read }.split("\n")
expect!(hosts, ["http://localhost:3000"])

# sleep(30)
kill_server(pid1, 1)
kill_server(pid2, 2)

