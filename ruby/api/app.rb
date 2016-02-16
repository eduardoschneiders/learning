class MyApp < Sinatra::Base
  before do
    auth_header = env['HTTP_AUTHORIZATION'].split(':')

    halt 401 unless auth_header.size == 2

    public_key = auth_header[0]
    signature = auth_header[1]

    user = User.first({ public_api_key: public_key })
    require 'pry'; binding.pry
    halt 403 unless user

    body = request.body.read
    uri = env['REQUEST_URI']

    computed_signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('md5'), user.token, uri + body)
    halt 403 unless computed_signature == signature
  end

  get '/foo' do
    "Access granted to foo"
  end
end

