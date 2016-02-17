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

  put '/beer/:id' do
    beer = Beer.find(params[:id])
    attributes = env['rack.request.form_hash']
    beer.update_attributes(attributes)

    if beer.save
      response.status = 204
    else
      response.status = 500
      response.headers['Content-Type'] = 'text/json'
    end

  end
end

