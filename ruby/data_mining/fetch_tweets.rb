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
      hashtags: t.hashtags.map(&:text),
      links: t.uris.map { |u| u.url.to_s },
      retweet_count: t.retweet_count,
      user_mentions: t.user_mentions.map(&:screen_name),
      favorite_count: t.favorite_count
    }
  end

  e[:tweets] = all_tweets
  puts "Name: #{e[:name]}"
  puts "Tweets:"
  tweets.each do |t|
    puts "      #{t.text}"
  end

  update_db(the_master, following)
end
