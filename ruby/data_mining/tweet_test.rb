#!/usr/bin/env ruby

require 'rubygems'
require 'twitter'
require 'google_chart'
require 'dotenv'

Dotenv.load

client = Twitter::REST::Client.new do |config|
    config.consumer_key    = ENV['DM_TWITTER_CONSUMER_KEY']
    config.consumer_secret = ENV['DM_TWITTER_CONSUMER_SECRET']
end
username = 'eduschneiders'
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

require 'pry'; binding.pry
