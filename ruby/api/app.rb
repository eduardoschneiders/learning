require 'json'
require './auth_user'
require './beer'

class MyApp < Sinatra::Base
  include AuthUser

  before do
    auth
  end

  get '/foo' do
    "Access granted to foo"
  end

  get '/beers' do
    beers = Beer.all
    { resuts: beers }.to_json
  end

  post '/beer' do
    beer = Beer.create(params)
  end

  put '/beer' do
    require 'pry'; binding.pry
    beer = Beer.create(params)
  end
end

