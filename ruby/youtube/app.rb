require 'json'
require 'cgi'
require 'net/http'
require 'uri'
require './requests'
require './subscriptions'
require './videos'

class MyApp < Sinatra::Base
  CLIENT_ID = ''
  CLIENT_SECRET = ''
  get '/' do
 <<-eos
  <a href="auth">Get authentication</a>
  <a href="generate_subscriptions">Generate subscriptions</a>
  <a href="select_videos">Select subscriptions</a>
eos
  end

  get '/auth' do
    url='https://accounts.google.com/o/oauth2/auth'

    pa = {}

    pa[:client_id]      = CLIENT_ID
    pa[:redirect_uri]   = CGI.escape('http://localhost:4567/oauth2callback')
    pa[:scope]          = 'https://www.googleapis.com/auth/youtube'
    pa[:response_type]  = 'code'
    pa[:access_type]    = 'offline'


    query_string = pa.map do |key, value|
      "#{key}=#{value}"
    end.join('&')
<<-eos
  Get permissions: <br />
  <a href=#{url}?#{query_string}>
    #{url}?#{query_string}
  </a>
eos
  end

  get '/oauth2callback' do
    url = 'https://accounts.google.com/o/oauth2/token'
    a = params[:code]
    token = params[:token]
    params = {}
    params[:code]       = a
    params[:client_id]    = CLIENT_ID
    params[:client_secret]  = CLIENT_SECRET

    if token
      params[:grant_type]   = 'refresh_token'
      params[:refresh_token] = token
    else
      params[:redirect_uri]   = 'http://localhost:4567/oauth2callback'
      params[:grant_type]   = 'authorization_code'
    end

    response = JSON.parse(Request.post(url, params))
    File.open('token', 'w') { |file| file.write(response['access_token']) }
    response['access_token']
  end

  get '/generate_subscriptions' do
    Subscriptions.generate
  end

  post '/generate_videos' do
    File.open('videos_to_download', 'a') { |file| file.write("\n" + params['videos'].join("\n")) }
  end

  get '/select_videos' do
    subscriptions = Subscriptions.load_subscriptions['subscriptions']
    result = '<form action="generate_videos" method="post">'
    subscriptions.each do |channel_id|
      videos = Videos.get_videos(channel_id)['items']
      # videos = [
      #   {
      #     'id' => {
      #       'videoId'=> 'asdferweesg'
      #     },
      #     'snippet' => {
      #       'title' => 'the second title',
      #       'thumbnails' => {
      #         'default' => {
      #           'url' => 'https://i.ytimg.com/vi/CHN0hscu9aQ/default.jpg'
      #         }
      #       }
      #     }
      #   },
      #   {
      #     'id' => {
      #       'videoId'=> 'asdf'
      #     },
      #     'snippet' => {
      #       'title' => 'the title',
      #       'thumbnails' => {
      #         'default' => {
      #           'url' => 'https://i.ytimg.com/vi/-onQcF95pfs/default.jpg'
      #         }
      #       }
      #     }
      #   }
      # ]

      videos_metadata = videos.map do |video|
        video_metadata(video)
      end
      puts "#{channel_id}"

      result += "channel: #{channel_id}<br />#{videos_html(videos_metadata)}<br />"
    end

    result += "<input type='submit' value='send'></form>"
    result
  end

  private

  def video_metadata(video)
    {
      video_id: video['id']['videoId'],
      title: video['snippet']['title'],
      url: video['snippet']['thumbnails']['default']['url']
    }
  end

  def videos_html(videos_metadata)
    html = ''

    videos_metadata.each do |video|
      html += "<label><input name='videos[]' type='checkbox' value='#{video[:video_id]}'> <img src='#{video[:url]}'>#{video[:title]}</label>"
    end

    html
  end
end

