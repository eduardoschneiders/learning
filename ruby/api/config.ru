# thin -R config.ru -p 4567 start

require 'sinatra'
require 'hashie/mash'
require 'pry'

require './app.rb'

run MyApp
