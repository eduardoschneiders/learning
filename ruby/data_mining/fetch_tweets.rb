#!/usr/bin/env ruby

require_relative 'config'

client = Twitter::REST::Client.new do |config|
  config.consumer_key    = ENV['DM_TWITTER_CONSUMER_KEY']
  config.consumer_secret = ENV['DM_TWITTER_CONSUMER_SECRET']
  config.access_token        = ENV['DM_TWITTER_ACCESS_TOKEN']
  config.access_token_secret = ENV['DM_TWITTER_ACCESS_TOKEN_SECRET']
end

username = 'eduschneiders'
todo = 'fetch_tw'


client_db = Mongo::Client.new(['localhost:27017'], database: 'data_mining_test')

def update_db(the_master, following)
  the_master.update_one(
    { "$set" => { resources: following }}
  )
end

def collect_with_max_id(collection=[], max_id=nil, max, &block)
  response = yield(max_id)
  collection += response

  if response.empty? || max <= 0
    collection.flatten 
  else
    collect_with_max_id(collection, response.last.id - 1, max - 1,  &block)
  end
end

def client.get_all_tweets(user)
  collect_with_max_id do |max_id|
    begin
      options = { max: 3, count: 200, include_rts: true }
      options[:max_id] = max_id unless max_id.nil?

      user_timeline(user, options)
    rescue Twitter::Error::TooManyRequests => error
      time = error.rate_limit.reset_in
      breaking(time)
      retry
    end
  end
end

def build_tweet(t)
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

def breaking(time)
  puts "\n"
  while time > 0
    print "Sleeping for #{time} seconds ---------------------\r"
    sleep 1
    time -= 1
  end
  puts '\nrestarting ------------'
end

def percentage(done, total)
  percent = (done.to_f/total*100).round(0)
  a = percent.to_i.times.map { '=' }.join
  b = (100 - percent.to_i).times.map { ' ' }.join
  print "Percentage: #{percent}% -> #{done} of #{total}"
  print "     [#{a}#{b}] \r"
end



resources = client_db[:resources].find



total = resources.count
i = 0

resources.each do |r|
  i += 1
  percentage(i, total)
  unless r[:tweets]
    begin
      # tweets = client.user_timeline(r[:name])
      tweets = client.get_all_tweets(r[:name])

      #tweet.attrs can be used insted of this object
      #But it weights much more
      all_tweets = tweets.map { |t| build_tweet(t) }

      r[:tweets] = all_tweets
      puts "Name1: #{r[:name]}"

      client_db[:resources].find(name: r[:name]).update_one({ "$set" => { tweets: all_tweets } })
    rescue Twitter::Error::TooManyRequests => error
      time = error.rate_limit.reset_in
      breaking(time)
      retry
    rescue Twitter::Error::Unauthorized, Twitter::Error::NotFound
      next
    rescue Twitter::Error::RequestTimeout
      puts '\n-------------- time out'
      sleep 10
      retry
    end
  end
end

exit

following_tree = client_db[:following_tree]
the_master = following_tree.find({ name: username })
following = the_master.first[:following]

following.each do |e|
  if todo == 'fetch_tw'
    #todo pull all tweets of acount, not only the firsts
    unless e[:tweets]
      tweets = client.user_timeline(e[:name])

      #tweet.attrs can be used insted of this object
      #But it weights much more
      all_tweets = tweets.map { |t| build_tweet(t) }

      e[:tweets] = all_tweets
      puts "Name: #{e[:name]}"
      puts "Tweets:"
      tweets.each do |t|
        puts "      #{t.text}"
      end
    end

    e[:following].each do |e2|
      unless e2[:tweets]
        begin
          tweets = client.user_timeline(e2[:name])
          
          #tweet.attrs can be used insted of this object
          #But it weights much more
          all_tweets = tweets.map { |t| build_tweet(t) }

          e2[:tweets] = all_tweets
          puts "Name1: #{e[:name]} -> Name2: #{e2[:name]}"

          update_db(the_master, following)
        rescue Twitter::Error::TooManyRequests => error
          time = error.rate_limit.reset_in
          breaking(time)
          retry
        rescue Twitter::Error::Unauthorized
          next
        rescue Twitter::Error::RequestTimeout
          puts '-------------- time out'
          sleep 10
          retry
        end
      end
    end
  elsif todo == 'count_tw'
    unless e[:tweets_count]
      begin
        puts "--#{e[:name]}"
        e[:tweets_count] = client.user(e[:name]).tweets_count
        update_db(the_master, following)
      rescue Twitter::Error::TooManyRequests => error
        time = error.rate_limit.reset_in
        breaking(time)
      rescue Twitter::Error::Forbidden, Twitter::Error::NotFound
        next
      end
    end

    e[:following].each do |e2|
      unless e2[:tweets_count]
        begin
          puts "--#{e[:name]} #{e2[:name]}"
          e2[:tweets_count] = client.user(e2[:name]).tweets_count
          update_db(the_master, following)
        rescue Twitter::Error::TooManyRequests => error
          time = error.rate_limit.reset_in
          breaking(time)
        rescue Twitter::Error::Forbidden, Twitter::Error::NotFound
          next
        end
      end
    end
  end

  update_db(the_master, following)
end
