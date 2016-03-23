require 'json'
require 'cgi'
require 'net/http'
require 'uri'

class MyApp < Sinatra::Base
  CLIENT_ID = ''
  CLIENT_SECRET = ''

  get '/begin' do
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
  Get code: <br />
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

    response = JSON.parse(post(url, params))
    File.open('token', 'w') { |file| file.write(response['access_token']) }
    response['access_token']
  end

  private

  def post(url, params)
    uri = URI.parse(url)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(params)

    response = http.request(request)
    response.body
  end
end

