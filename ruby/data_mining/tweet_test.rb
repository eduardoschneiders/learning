#!/usr/bin/env ruby

require_relative 'config'

client = Twitter::REST::Client.new do |config|
  config.consumer_key    = ENV['DM_TWITTER_CONSUMER_KEY']
  config.consumer_secret = ENV['DM_TWITTER_CONSUMER_SECRET']
  config.access_token        = ENV['DM_TWITTER_ACCESS_TOKEN']
  config.access_token_secret = ENV['DM_TWITTER_ACCESS_TOKEN_SECRET']
end
username = 'eduschneiders'

binding.pry



def collect_with_max_id(collection=[], max_id=nil, &block)
  response = yield(max_id)
  collection += response
  response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
end

def client.get_all_tweets(user)
  collect_with_max_id do |max_id|
    begin
      options = { count: 200, include_rts: true }
      options[:max_id] = max_id unless max_id.nil?
      user_timeline(user, options)
    rescue Twitter::Error::TooManyRequests => error
      binding.pry
      time = error.rate_limit.reset_in
      puts "Sleep for #{time} ---------------------"
      sleep time
      puts 'restarting ------------'
      retry
    end
  end
end


all_twitts = client.get_all_tweets(username)
file = File.new('tw.txt', 'w')
all_twitts.each do |t|
  file.puts t.text
end
binding.pry
exit

cursor = cursor2 = -1
results = []
file = File.new('results_one_level.json', 'w')

loop do
  begin
    cf = client.followers(username, { cursor: cursor })
    cf.each do |e|
      puts e.screen_name

      person =  { 
        name: e.screen_name,
        followers: [],
        twitter_counts: 0
      }
      cursor2 = 0
      total = 0

      begin
        client.get_all_tweets(e.screen_name, cursor2)
      rescue
      end
      puts total
      person[:twitter_counts] = total
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

file.puts results.to_json
exit





# file = File.new('data.json', 'r')
file = File.new('results.json', 'r')
result = ""
while line = file.gets
  result += line
end

tree = JSON.parse(result)['followers_tree']
all_followers = []


tree.each do |main|
  puts main['name']
  main['followers'].each do |followers1|
    followers1['followers'].each do |followers2|
      all_followers << followers2['name']
    end
  end
end

rank_following = all_followers.select do |e| 
  all_followers.count(e) > 1 
end.group_by do |e| 
  e 
end.map do |e|
  { name: e.first, count: e[1].count }
end.sort_by do |e|
  e[:count]
end.reverse


rank_following.each do |f|
  puts "#{f[:name]} -> followers: #{f[:count]}"
end
 
exit





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
        followers: [],
        twitter_counts: client.user_timeline(e.screen_name).count,
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
