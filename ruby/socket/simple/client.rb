require 'socket'

i = 0
while i < 10
  socket = UNIXSocket.new('/tmp/simple.sock')
  puts "=== Sending #{i} request"
  socket.write("#{i} attempt! Hello server, can you hear me?\n")

  puts '=== Getting Response'
  puts socket.readline

  socket.close

  i += 1
end

