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
    if wild_card_rules = user.rules.select { |rule| (rule.path =~ /\/\*/) != nil }
      rule = wild_card_rules.detect do |rule|
        url_part = rule.path.split('/*')
        http_uri.include? url_part[0]
      end
    else
      rule = user.rules.find { |rule| rule.path == http_uri }
    end

    halt 403 unless rule or !rule.actions.include? http_method.downcase
  end
end
