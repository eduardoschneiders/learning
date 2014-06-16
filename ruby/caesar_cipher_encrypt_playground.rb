require_relative 'caesar_cipher_encrypt'

encrypted_string = caesar_cipher('Eduardo Schneiders - noreply@gmail.com', 5)
decrypted_string = caesar_cipher(encrypted_string, 5, false)

puts "Encrypted: #{encrypted_string}"
puts "Decrypted: #{decrypted_string}"
