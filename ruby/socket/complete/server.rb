# source http://blog.honeybadger.io/how-unicorn-talks-to-nginx-an-introduction-to-unix-sockets-in-ruby/
# $ ruby server.rb
# $ nginx -c "$(pwd)/nginx.conf"
# $ access http://localhost:2048/

require 'socket'

class Connection
  attr_accessor :path

  def initialize(path)
    @path = path
    File.unlink(path) if File.exists?(path)
  end

  def server
    @server ||= UNIXServer.new(path)
  end

  def on_request
    puts 'wating request ...'
    socket = server.accept
    yield socket
    socket.close
  end
end

class AppServer
  attr_reader :connection, :template

  def initialize(connection, template)
    @connection = connection
    @template = template
  end

  def run
    while true
      connection.on_request do |socket|
        while (line = socket.readline) != "\r\n"
          puts line
        end
        socket.write(template)
      end
    end
  end
end

class Viwer
  def self.template_response
<<-EOF
%[HTTP/1.1 200 OK
Content-Length: 36
Content-Type: text/plain

The current timestamp is: #{ Time.now.to_i }
EOF
  end
end

connection = Connection.new('/tmp/complete.sock')
server = AppServer.new(connection, Viwer.template_response)
server.run
