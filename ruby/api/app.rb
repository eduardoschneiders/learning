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

  post '/beers' do
    request.body.rewind
    attributes = JSON.parse request.body.read
    beer = Beer.create(attributes)
  end

  put '/beer/:id' do
    beer = Beer.find(params[:id])
    request.body.rewind
    attributes = JSON.parse request.body.read
    beer.update_attributes(attributes)

    if beer.save
      response.status = 204
    else
      response.status = 500
      response.headers['Content-Type'] = 'text/json'
    end

  end
end

