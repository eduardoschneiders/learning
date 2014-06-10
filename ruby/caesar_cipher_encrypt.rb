def alphabet
  ['a', 'b', 'c', 'd', 'e', 'f', 'g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','x','w','y','z']
end

def caesar_cipher (string, number)
  encrypt_string = ""

  string.split('').each do |letter|
    alphabet.each_with_index do |value, index|
      if letter == value
        encrypt_string << alphabet[index - number]
      end
    end
  end

  encrypt_string
end

puts caesar_cipher('eduardo', 5)
