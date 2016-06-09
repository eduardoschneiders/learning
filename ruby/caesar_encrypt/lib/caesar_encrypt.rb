class CaesarEncrypt
  def self.encrypt(string, number)
    encrypt_string = string.each_char.map do |letter|
      ord_letter = letter.ord
      index = ord_letter - number
      index.chr
    end.join

    [encrypt_string].pack("m0")
  end

  def self.decrypt(string, number)
    decrypt_string = string.unpack("m0").first.each_char.map do |letter|
      ord_letter = letter.ord
      index = ord_letter + number
      index.chr
    end.join

    decrypt_string
  end

end
