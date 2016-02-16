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
    http_uri = env['REQUEST_URI']
    http_method = env['REQUEST_METHOD']

    computed_signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('md5'), user.token, http_uri + body)
    halt 403 unless computed_signature == signature

    can_access_uri(user, http_uri, http_method)
  end

  private

  def can_access_uri(user, http_uri, http_method)
    halt 403 unless rule = user.rules.find { |rule| rule.path == http_uri }
    halt 403 unless rule.actions.include? http_method.downcase
  end
end
