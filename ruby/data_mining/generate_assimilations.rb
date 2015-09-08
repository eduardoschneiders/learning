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

def update_db(the_master, rank_following)
  the_master.update_one(
    { "$set" => { rank_following: rank_following }}
  )
end

def percentage(done, total)
  percent = (done.to_f/total*100).round(0)
  a = percent.to_i.times.map { '=' }.join
  b = (100 - percent.to_i).times.map { ' ' }.join
  print "Percentage: #{percent}% -> #{done} of #{total}"
  print "     [#{a}#{b}] \r"
end

rank_following_db = client_db[:rank_following]
the_master = rank_following_db.find(name: username)
rank_following = the_master.first[:rank_following]

i = 0
total = rank_following.count
rank_following.each do |rf|
  names = rf[:followers] << rf[:name]

  all_hashtags = names.map do |name|
    resource = client_db[:resources].find(name: name).first
    resource[:all_hashtags]
  end.flatten

  commons = all_hashtags.group_by do |e|
    e
  end.select do |e, b|
    b.count > 1
  end.sort_by do |e, b|
    b.count
  end.reverse.map do |e, b|
    { hashtag: e, count: b.count }
  end

  rf[:commons] = commons

  update_db(the_master, rank_following)

  i += 1
  percentage(i, total)


    
    
   
end





# names = ['JeremyClarkson', 'nateberkopec', 'dhh']

# all_hashtags = names.map do |name|
#   resource = client_db[:resources].find(name: name).first
#   resource[:all_hashtags]
# end.flatten

# common = all_hashtags.group_by do |e|
#   e
# end.select do |e, b|
#   b.count > 1
# end.keys

# binding.pry

