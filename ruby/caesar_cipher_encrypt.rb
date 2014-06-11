require 'unicode_utils/upcase'

class String
  def upcase
    UnicodeUtils.upcase(self)
  end
end

def alphabet_down_case
  ('a'..'z').to_a
end

def alphabet_up_case
  ('A'..'Z').to_a
end

def alphabet_especial_caracters
  [' ', '!', '@', '#', '$', '%', '*', '(', ')', '_', '-', '+', '=', '[', '{', '}', ']', '/', '?', ';', ':', '.', '>', ',', '<']
end

def alphabet_accent_caracters_down_case
  ['à', 'á', 'â', 'ã', 'ä', 'è', 'é', 'ê', 'ẽ', 'ë', 'ì', 'í', 'î', 'ĩ', 'ï', 'ò', 'ó', 'ô', 'õ', 'ö', 'ù', 'ú', 'û', 'ũ', 'ü', 'ç']
end

def alphabet_accent_caracters_up_case
  alphabet_accent_caracters_down_case.map(&:upcase)
end

def caesar_cipher (string, number, encrypt = true)
  encrypt_string = ""

  string.split('').each do |letter|
    if alphabet_down_case.include?(letter)
      alphabet = alphabet_down_case
    elsif alphabet_especial_caracters.include?(letter)
      alphabet = alphabet_especial_caracters
    elsif alphabet_accent_caracters_down_case.include?(letter)
      alphabet = alphabet_accent_caracters_down_case
    elsif alphabet_accent_caracters_up_case.include?(letter)
      alphabet = alphabet_accent_caracters_up_case
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

encrypted_string = caesar_cipher('Eduardo Schneiders - noreply@gmail.com', 5)
decrypted_string = caesar_cipher(encrypted_string, 5, false)

puts "Encrypted: #{encrypted_string}"
puts "Decrypted: #{decrypted_string}"
