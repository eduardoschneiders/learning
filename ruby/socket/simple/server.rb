require 'socket'

server = UNIXServer.new('/tmp/simple.sock')

while true
  puts '=== Waiting connection'
  socket = server.accept

  puts '=== Client request:'
  puts socket.readline

  puts "=== Writting response:"
  socket.write('Yes I can hear you loud!')
  
  socket.close
end

File.delete('/tmp/simple.sock')
