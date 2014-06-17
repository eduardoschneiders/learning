def substrings(word, dictionary = [])
  words_found = Hash.new

  dictionary.each do |dictionary_word|
    found =  word.downcase.scan(/#{dictionary_word}/)
    words_found[dictionary_word.to_sym] = found.size if found.any?
  end

  words_found
end
