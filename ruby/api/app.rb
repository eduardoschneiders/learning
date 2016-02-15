DB_CLIENT_PUBLIC_KEY = 'public-api-key'
DB_CLIENT_TOKEN = 'secret-token'

class MyApp < Sinatra::Base
  get '/foo' do
    auth_header = env['HTTP_AUTHORIZATION'].split(':')

    halt 401 unless auth_header.size == 2

    public_key = auth_header[0]
    signature = auth_header[1]

    halt 403 unless DB_CLIENT_PUBLIC_KEY == public_key

    body = request.body.read
    uri = env['REQUEST_URI']

    computed_signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('md5'), DB_CLIENT_TOKEN, uri + body)
    halt 403 unless computed_signature == signature

    "Access granted"
  end
end

