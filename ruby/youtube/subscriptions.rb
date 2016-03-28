#!/usr/bin/env ruby
require 'uri'
require 'net/http'
require 'json'
require 'openssl'
require 'pry'

class Subscriptions
  class << self
    def get_subscriptions(next_page_token = nil)
      url = "https://www.googleapis.com/youtube/v3/subscriptions?part=id,snippet&mine=true&pageToken=#{next_page_token}"
      headers = {
        'authorization' => "Bearer #{get_token}",
        'cache-control' => 'no-cache'
      }

      puts response = JSON.parse(Request.get(url, headers))
      store_subscriptions(response['items'].map { |item| item['snippet']['resourceId']['channelId'] })
      next_page_token = response['nextPageToken']
      get_subscriptions(next_page_token) if next_page_token
    end

    def get_token
      File.read('token')
    end

    def load_subscriptions
      JSON.parse(File.read('subscriptions.metadata'))
    end

    def store_subscriptions(data)
      subscriptions = load_subscriptions

      unless subscriptions.empty?
        actual_data = subscriptions['subscriptions']
      else
        actual_data = []
      end

      merged_data = JSON.dump({ subscriptions: actual_data.concat(data) })
      File.open('subscriptions.metadata', 'w') { |file| file.write(merged_data) }
    end

    def generate
      File.open("subscriptions.metadata", "w") {|file| file.write('')}
      get_subscriptions
    end
  end
end
