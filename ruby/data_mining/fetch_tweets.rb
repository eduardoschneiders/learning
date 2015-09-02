#!/usr/bin/env ruby

require_relative 'config'

username = 'eduschneiders'


client_db = Mongo::Client.new(['localhost:27017'], database: 'data_mining_test')

following_tree = client_db[:following_tree]
the_master = following_tree.find({ name: username })
following = the_master.first[:following]
following.each do |e|
  e[:name] = 'testing'
  e[:following].each do |e2|
    e2[:name] = 'testing2'
  end
end
  
the_master.update_one(
  { "$set" => { following: following }}
)




exit
