require './user'

module AuthUser
  def auth
    auth_header = env['HTTP_AUTHORIZATION'].split(':')

    halt 401 unless auth_header.size == 2

    public_key = auth_header[0]
    signature = auth_header[1]

    user = User.first({ public_api_key: public_key })
    halt 403 unless user

    body = request.body.read
    uri = env['REQUEST_URI']
    method = env['REQUEST_METHOD']

    computed_signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('md5'), user.token, uri + body)
    halt 403 unless computed_signature == signature

    rule = user.rules.first { |rule| rule.path == uri }
    halt 403 unless rule.actions.include? method.downcase
  end
end
