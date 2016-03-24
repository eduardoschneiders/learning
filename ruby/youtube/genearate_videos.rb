#!/usr/bin/env ruby
require 'uri'
require 'net/http'
require 'json'
require 'openssl'
require 'pry'

def get_videos(subscriptions)
  headers = {
    'authorization' => "Bearer #{get_token}",
    'cache-control' => 'no-cache'
  }

  subscriptions.each do |channel_id|
    url = "https://www.googleapis.com/youtube/v3/search?part=id%2Csnippet&channelId=#{channel_id}&type=video&maxResults=3"
    puts response = JSON.parse(get_request(url, headers))
    store_videos(response['items'].map { |item| item['id']['videoId'] })
  end
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

def store_videos(data)
    File.open('videos.metadata', 'a') { |file| file.write("\n" + data.join("\n")) }
end


subscriptions_file = File.read('subscriptions.metadata')
subscriptions = JSON.parse(subscriptions_file)['subscriptions']
File.open("videos.metadata", "w") {|file| file.write('')}

get_videos(subscriptions)
