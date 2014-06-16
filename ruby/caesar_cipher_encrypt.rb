def caesar_cipher(string, number, encrypt = true)
  encrypt_string = string.each_char.map do |letter|
    ord_letter = letter.ord
    index = encrypt ? ord_letter - number : ord_letter + number
    index.chr('UTF-8')
  end.join

  encrypt_string
end
