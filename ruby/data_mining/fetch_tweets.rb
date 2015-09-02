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

def update_db(the_master, following)
  the_master.update_one(
    { "$set" => { following: following }}
  )
end



following_tree = client_db[:following_tree]
the_master = following_tree.find({ name: username })
following = the_master.first[:following]
following.each do |e|
  #todo pull all tweets of acount, not only the firsts
  tweets = client.user_timeline(e[:name])

  #tweet.attrs can be used insted of this object
  #But it weights much more
  all_tweets = tweets.map do |t|
    { 
      text: t.text, 
      tweet_id: t.id,
      created_at: t.created_at, 
      hashtags: t.hashtags,
      links: t.uris.map { |u| u.url.to_s },
      retweet_count: t.retweet_count,
      user_mentions: t.user_mentions.map(&:screen_name),
      favorite_count: t.favorite_count
    }
  end

  binding.pry
  e[:tweets] = all_tweets
  puts "Name: #{e[:name]}"
  puts "Tweets:"
  tweets.each do |t|
    puts "      #{t}"
  end

  update_db(the_master, following)
  binding.pry
end
  


exit
