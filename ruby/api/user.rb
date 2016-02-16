class User
  def self::first(queries)
    all_users.detect do |user|
      queries.all? { |query| user.send(query.first) == query.last }
    end
  end

  private

  def self::all_users
    [
      Hashie::Mash.new({
        name: 'Eduardo',
        public_api_key: 'public-api-key',
        token: 'client-secret',
        rules: [
          Hashie::Mash.new({ path: '/foo', actions: ['post', 'get', 'put'] }),
          Hashie::Mash.new({ path: '/beer/*', actions: ['get', 'post'] }),
          Hashie::Mash.new({ path: '/beers', actions: ['get'] })
        ]
      }),
      Hashie::Mash.new({ name: 'Test', public_api_key: 'test-public-api', token: 'test-token' }),
    ]
  end
end
