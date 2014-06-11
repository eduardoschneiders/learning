def alphabet_down_case
  ('a'..'z').to_a.push(alphabet_especial_caracters).flatten
end

def alphabet_up_case
  ('A'..'Z').to_a.push(alphabet_especial_caracters).flatten
end

def alphabet_especial_caracters
  [' ', '!', '@', '#', '$', '%', '*', '(', ')', '_', '-', '+', '=', '[', '{', '}', ']', '/', '?', ';', ':', '.', '>', ',', '<']
end

def caesar_cipher (string, number, encrypt = true)
  encrypt_string = ""

  string.split('').each do |letter|

    if alphabet_down_case.include?(letter)
      alphabet = alphabet_down_case
    else
      alphabet = alphabet_up_case
    end

    alphabet.each_with_index do |value, index|
      if letter == value
        index = encrypt ? index - number : index + number
        if index >= alphabet.length
          index = index - alphabet.length
        end
        encrypt_string << alphabet[index]
      end
    end
  end

  encrypt_string
end

encrypted_string = caesar_cipher('Eduardo Schneiders', 5)
decrypted_string = caesar_cipher(encrypted_string, 5, false)

puts "Encrypted: #{encrypted_string}"
puts "Decrypted: #{decrypted_string}"
