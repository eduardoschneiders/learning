#!/usr/bin/env ruby

require_relative 'config'

client = Twitter::REST::Client.new do |config|
  config.consumer_key    = ENV['DM_TWITTER_CONSUMER_KEY']
  config.consumer_secret = ENV['DM_TWITTER_CONSUMER_SECRET']
  config.access_token        = ENV['DM_TWITTER_ACCESS_TOKEN']
  config.access_token_secret = ENV['DM_TWITTER_ACCESS_TOKEN_SECRET']
end

username = 'eduschneiders'

client_db = Mongo::Client.new(['localhost:27017'], database: 'data_mining_test')

def update_db(record, following)
  the_master.update_one(
    { "$set" => { resources: following }}
  )
end


resources = client_db[:resources]
resources.find.each do |resource|
  unless resource[:all_hashtags]
    if resource[:tweets]
      puts "\n\n\n name: #{resource[:name]} --------------------------------- "
      all_hashtags = resource[:tweets].map {|t| t[:hashtags] }.flatten.uniq
      puts "tweets: #{all_hashtags} "

      unless all_hashtags.empty?
        resources.find(
          { name: resource[:name]}
        ).update_one(
          { "$set" => { all_hashtags: all_hashtags }}
        )
      end
    end
  end
end
