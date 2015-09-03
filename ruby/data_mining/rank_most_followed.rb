#!/usr/bin/env ruby

require_relative 'config'

username = 'eduschneiders'
client_db = Mongo::Client.new(['localhost:27017'], database: 'data_mining_test')

def percentage(done, total)
  percent = (done.to_f/total*100).round(2)
  "Percentage: #{percent}% -> #{done} of #{total} \r"
end

following_tree = client_db[:following_tree]
the_master = following_tree.find({ name: username })
following = the_master.first[:following]


followers = following.map { |e| e[:following].map { |e2| e2[:name] } }.flatten
total = followers.count



i = 0
rank_following_results = followers.select do |e| 
  i += 1
  print percentage(i, total)
  followers.count(e) > 1 
end.group_by do |e| 
  e 
end.map do |e|
  { name: e.first, count: e[1].count }
end.sort_by do |e|
  e[:count]
end.reverse

the_master_obj = { 
  name: username,
  rank_following: []
}
puts 'Done'

rank_following = client_db[:rank_following]
the_master = rank_following.find({ name: username })

if the_master.count == 0
  rank_following.insert_one(the_master_obj)
  the_master = rank_following.find({ name: username })
end


the_master.update_one(
  { "$set" => { rank_following: rank_following_results }}
)
