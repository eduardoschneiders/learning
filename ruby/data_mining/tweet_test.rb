#!/usr/bin/env ruby

require 'rubygems'
require 'twitter'
require 'google_chart'
require 'dotenv'
require 'pry'

Dotenv.load

client = Twitter::REST::Client.new do |config|
  config.consumer_key    = ENV['DM_TWITTER_CONSUMER_KEY']
  config.consumer_secret = ENV['DM_TWITTER_CONSUMER_SECRET']
  config.access_token        = ENV['DM_TWITTER_ACCESS_TOKEN']
  config.access_token_secret = ENV['DM_TWITTER_ACCESS_TOKEN_SECRET']
end
username = 'eduschneiders'
# username = 'twitterdev'

# file = File.new('data.json', 'r')
file = File.new('results.json', 'r')
result = ""
while line = file.gets
  result += line
end

tree = JSON.parse(result)['followers_tree']
text = ""

graph = File.new('Graph.dot', 'w')
graph.puts "graph followers {"
graph.puts "  node [ fontname=Arial, fontsize=6 ];"
tree.each do |f|
  f['followers'].each do |f2|
    graph.puts "  \"#{f['name']}\" -- \"#{f2['name']}\""
    if f2['followers'].any?
      f2['followers'].each do |f3|
        graph.puts "    \"#{f2['name']}\" -- \"#{f3['name']}\""
      end
    end
  end
end
graph.puts "}"


exit



cursor = cursor2 = -1
results = []
file = File.new('results.json', 'w')

loop do
  begin
    cf = client.followers(username, { cursor: cursor })
    cf.each do |e|
      puts e.screen_name

      person =  { 
        name: e.screen_name,
        followers: []
      }

      if e.followers_count < 100
        begin
          cf2 = client.followers(e.screen_name, { cursor: cursor2 })
          cf2.each do |e2|
            person[:followers] << { name: e2.screen_name }
            puts "#{e.screen_name}---- #{e2.screen_name}"
          end
        rescue Twitter::Error::TooManyRequests => error
          if cf2
            cursor2  = cf2.attrs[:next_cursor]
          end
          time = error.rate_limit.reset_in
          puts "------Sleep for #{time} ---------------------"
          sleep time
          puts 'restarting ------------'
          retry
        end
      end
      results << person
    end
  rescue Twitter::Error::TooManyRequests => error
    if cf
      cursor  = cf.attrs[:next_cursor]
    end
    time = error.rate_limit.reset_in
    puts "Sleep for #{time} ---------------------"
    sleep time
    puts 'restarting ------------'
    retry
  end
  break if cursor <= 0
end


binding.pry
file.puts results.to_json
binding.pry
exit
user = client.user(username)

unless user.protected?
  puts "Username   : " + user.screen_name.to_s
  puts "Name       : " + user.name
  puts "Id         : #{user.id} "
  puts "Location   : " + user.location
  puts "User since : " + user.created_at.to_s
  puts "Bio        : " + user.description.to_s
  puts "Followers  : " + user.followers_count.to_s
  puts "Friends    : " + user.friends_count.to_s
  puts "Listed Cnt : " + user.listed_count.to_s
  puts "Tweet Cnt  : " + user.statuses_count.to_s
  puts "Geocoded   : " + user.geo_enabled?.to_s
  puts "Language   : " + user.lang
  puts "URL        : " + user.url.to_s
  puts "Time Zone  : " + user.time_zone
  puts "Verified   : " + user.verified?.to_s

  tweet = client.user_timeline(username).first

  puts "Tweet time : #{tweet.created_at}"
  puts "Tweet ID   : " + tweet.id.to_s
  puts "Tweet text : " + tweet.text
end

puts '------------------'

followers = client.followers(username)

ordered_followers = followers.sort_by { |f| f.followers_count }.reverse

ordered_followers.each do |f|
  puts "#{f.followers_count} -> #{f.name}"
end


puts '--------------'

locations = Hash.new
timezones = 0.0

followers.each do |f|
  location = f.time_zone.to_s

  if location != ''
    if locations.has_key? location
      locations[location] += 1
    else
      locations[location] = 1
    end
    
    timezones += 1
  end
end


GoogleChart::PieChart.new('650x350', "Time Zones", false ) do |pc|
  locations.each do |loc, count|
    pc.data loc.to_s.delete("&"), (count/timezones*100).round
  end

  puts pc.to_url
  system("xdg-open", pc.to_url)
end

user_tweets = client.user_timeline(username)
weekdays = Hash.new

user_tweets.each do |t|
  weekday = t.created_at.strftime('%A')

  if weekdays.has_key? weekday
    weekdays[weekday] += 1
  else
    weekdays[weekday] = 1
  end
end

GoogleChart::BarChart.new('300x200', username, :vertical, false) do |bc|
  weekdays.each do |day, count|
    bc.data day, [count], '00000f'
  end

  puts bc.to_url
  system("xdg-open", bc.to_url)
end
