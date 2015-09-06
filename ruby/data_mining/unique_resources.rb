#!/usr/bin/env ruby

require_relative 'config'


username = 'eduschneiders'
client_db = Mongo::Client.new(['localhost:27017'], database: 'data_mining_test')


rank_following = client_db[:rank_following]

the_master = rank_following.find({ name: username })
following = the_master.first[:rank_following]

names = following.map { |f| [f[:name]] + f[:followers]}.flatten.uniq
resources_obj = { name: username,  resources: names.map { |n| { name: n } } }


resources = client_db[:resources]
the_master = resources.find({ name: username })

if the_master.count == 0
  binding.pry
  resources.insert_one(resources_obj)
end



