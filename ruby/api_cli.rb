root_response = {
  '_links': {
    'orders': { 'href': 'http://localhost:3000/orders', 'method': 'get' },
    'search_orders': { 'href': 'http://localhost:3000/orders/search?{query}', 'method': 'get' },
    'test': { 'href': 'http://localhost:3000/orders/search?{teste}', 'method': 'get' },
    'create_order': { 'href': 'http://localhost:3000/orders/', 'method': 'post' }
  }
}

orders_response = {
  '_resource': {
    'total': 10,
    'last_created': 15,
  },
  '_links': {
    'create': { 'href': 'http://localhost:3000/orders/create', 'method': 'post' },
    'list': { 'href': 'http://localhost:3000/orders/list', 'method': 'get' }
  }
}

response = root_response
# response = orders_response

class ApiCli
  def initialize(response)
    @response = response
  end

  def method_missing(method_name, *args)
    if @response[:_resource] && @response[:_resource].keys.include?(method_name)
      @response[:_resource][method_name]
    elsif @response[:_links] && @response[:_links].keys.include?(method_name)
      href = @response[:_links][method_name][:href]
      method = @response[:_links][method_name][:method]
      url = URL.new(href, args)

      HttpClient.new(url.href_with_params, method).run
    else
      super
    end
  end

  def resource
    @response[:_resource]
  end
end

class URL
  def initialize(href, args)
    @href = href
    @args = args
  end

  def href_with_params
    new_href = nil
    if match = @href.match(/{(.*)}/)
      if query = match.captures.first
        if query_params = @args.find { |e| e[query.to_sym] }
          values = query_params[query.to_sym]

          if values.respond_to?(:map)
            params = values.map { |i,v| "#{i}=#{v}"}.join('&')
          else
            params = values
          end

          new_href = @href.gsub(/{#{query.to_s}}/, params)
        end
      end
    end

    new_href || @href
  end
end

class HttpClient
  def initialize(href, method)
    @href = href
    @method = method || :get
  end

  def run
    "body #{@href} #{@method}"
  end
end

c = ApiCli.new(response)

require 'pry'; binding.pry
