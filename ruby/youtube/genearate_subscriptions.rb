#!/usr/bin/env ruby
require 'uri'
require 'net/http'
require 'json'
require 'openssl'
require 'pry'

def get_subscriptions(next_page_token = nil)
  url = "https://www.googleapis.com/youtube/v3/subscriptions?part=id,snippet&mine=true&pageToken=#{next_page_token}"
  headers = {
    'authorization' => "Bearer #{get_token}",
    'cache-control' => 'no-cache'
  }

  puts response = JSON.parse(get_request(url, headers))
  store_subscriptions(response['items'].map { |item| item['snippet']['resourceId']['channelId'] })
  next_page_token = response['nextPageToken']
  get_subscriptions(next_page_token) if next_page_token
end

def get_request(url, headers)
  url = URI(url)

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Get.new(url)

  headers.each do |key, value|
    request[key] = value
  end
  # request.body = body

  response = http.request(request)
  response.read_body
end

def get_token
  File.read('token')
end

def store_subscriptions(data)
  subscriptions = File.read('subscriptions.metadata')

  unless subscriptions.empty?
    actual_data = JSON.parse(subscriptions)['subscriptions']
  else
    actual_data = []
  end

  merged_data = JSON.dump({ subscriptions: actual_data.concat(data) })
  File.open('subscriptions.metadata', 'w') { |file| file.write(merged_data) }
end


File.open("subscriptions.metadata", "w") {|file| file.write('')}
get_subscriptions()
