class Request
  def self.get(url, headers)
    url = URI(url)

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)

    headers.each do |key, value|
      request[key] = value
    end

    response = http.request(request)
    response.read_body
  end

  def self.post(url, params)
    uri = URI.parse(url)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(params)

    response = http.request(request)
    response.body
  end
end

