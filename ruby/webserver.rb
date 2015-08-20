require 'rack'

app = Proc.new do |env|
  ['201', { 'Test' => 'bla', 'Content-Type' => 'text/html'}, ['Some body to show']]
end


Rack::Handler::WEBrick.run app
