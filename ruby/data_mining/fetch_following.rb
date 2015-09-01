#!/usr/bin/env ruby

require_relative 'config'

client = Twitter::REST::Client.new do |config|
  config.consumer_key    = ENV['DM_TWITTER_CONSUMER_KEY']
  config.consumer_secret = ENV['DM_TWITTER_CONSUMER_SECRET']
  config.access_token        = ENV['DM_TWITTER_ACCESS_TOKEN']
  config.access_token_secret = ENV['DM_TWITTER_ACCESS_TOKEN_SECRET']
end

username = 'eduschneiders'


cursor = cursor2 = -1
results = []
file = File.new('results/results.json', 'w')

def breaking(time)
  while time > 0
    print "--- Sleeping for #{time} seconds ---------------------\r"
    sleep 1
    time -= 1
  end
  puts '--- restarting ------------'
end

def following(username, client)
  following = []
  cursor = -1

  loop do
    begin
      cfollowing = client.following(username, { cursor: cursor })
      cfollowing.each do |e|
        following << { name: e.screen_name }
        puts "#{username}---- #{e.screen_name}"
      end
    rescue Twitter::Error::TooManyRequests => error
      if cfollowing
        cursor  = cfollowing.attrs[:next_cursor]
      end
      time = error.rate_limit.reset_in
      breaking(time)
      retry
    end
    break if cursor <= 0 || cfollowing.attrs[:next_cursor] <= 0
  end 

  following
end

loop do
  begin
    cf = client.friends(username, { cursor: cursor })
    cf.each do |e|
      puts e.screen_name

      person =  { 
        name: e.screen_name,
        following: []
      }

      if e.friends_count < 100
        person[:following] = following(e.screen_name, client)
      end
      results << person
    end
  rescue Twitter::Error::TooManyRequests => error
    if cf
      cursor  = cf.attrs[:next_cursor]
    end
    time = error.rate_limit.reset_in

		while time > 0
			print "Sleeping for #{time} seconds ---------------------\r"
			sleep 1
			time -= 1
		end
    puts 'restarting ------------'
    retry
  end
  break if cursor <= 0 || cf.attrs[:next_cursor] <= 0
end

file.puts results.to_json
