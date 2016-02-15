# thin -R config.ru -p 4567 start

require 'sinatra'

require './app.rb' # which contains the above MyApp

run MyApp
