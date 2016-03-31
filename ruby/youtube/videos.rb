#!/usr/bin/env ruby
require 'uri'
require 'net/http'
require 'json'
require 'openssl'
require 'pry'

class Videos
  class << self
    def get_videos(channel_id, page_token)
      headers = {
        'authorization' => "Bearer #{get_token}",
        'cache-control' => 'no-cache'
      }

      if page_token
        page_token_str = "&pageToken=#{page_token}"
      else
        page_token_str = ''
      end

      url = "https://www.googleapis.com/youtube/v3/search?part=id%2Csnippet&channelId=#{channel_id}&type=video&maxResults=50#{page_token_str}"
      JSON.parse(Request.get(url, headers))
    end

    def get_token
      File.read('token')
    end

    # def store_videos(data)
    #   File.open('videos.metadata', 'a') { |file| file.write("\n" + data.join("\n")) }
    # end


    # subscriptions_file = File.read('subscriptions.metadata')
    # subscriptions = JSON.parse(subscriptions_file)['subscriptions']
    # File.open("videos.metadata", "w") {|file| file.write('')}

    # get_videos(subscriptions)
  end
end
