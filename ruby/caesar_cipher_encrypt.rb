def caesar_cipher(string, number, encrypt = true)
  encrypt_string = string.each_char.map do |letter|
    ord_letter = letter.ord
    index = encrypt ? ord_letter - number : ord_letter + number
    index.chr
  end.join

  encrypt_string
end

encrypted_string = caesar_cipher('Eduardo Schneiders - noreply@gmail.com', 5)
decrypted_string = caesar_cipher(encrypted_string, 5, false)

puts "Encrypted: #{encrypted_string}"
puts "Decrypted: #{decrypted_string}"
