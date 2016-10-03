#!/usr/bin/env ruby

require 'pry'
require './library'
#
# tf–idf -> term frequency-inverse document frequency
#
# 1) --- THE DATA
#
#
# Article1 = { the: 10, in: 7, Messi: 2 }
#
# Library = [
#   Article2 = { the: 12 ... },
#   Article3 = { the: 15, in: 2, ... },
#   Article4 = { the: 100, Messi: 1, ... },
#   Article5 = { the: 5, in: 3, ... },
#   Article6 = { the: 35, in: 15, ... },
#   .
#   .
#   .
# ]
#
#
#
#
# 2) --- THE IDF array
#
# Generate the tf-idf based on the word repeated on the library
# tf-idf = log(library_length/1 + articles_with_word)
#
# library_length = 54
# 
# THE:
#   articles_with_word = 53
#   log(53/1 + 53)
#   0.03
#
# IN:
#   articles_with_word = 52
#   log(53/1 + 52)
#   0.03
#
# MESSI
#   articles_with_word = 3
#   log(53/1 + 3)
#   0.43
#
# IDF - Inverse Document Frequency
#
# term_frequency= { the: 10, in: 7, Messi: 2 }
#
# tf =     [10, 7, 2 ]
#               X
# idf =    [0.03, 0.03, 0.43]
#                ==
# tf*idf = [0.3, 0.3, 0.86]
#
# A1= { the: 0.3, in: 0.3, Messi: 0.86 }
#
#
class TfIdf
  attr_accessor :main_article, :library

  def initialize(main_article, library = Library.new)
    @main_article = main_article
    @library = library
  end

  def main_article_text
    # article = 'being_a_developer_is_not_about_writing_code___bill_patrianakos'
    # main_article = 'lionel_messi___wikipedia__the_free_encyclopedia'
    # article = 'teste'
    library.article_text(main_article)
  end

  def terms_frequency
    words = main_article_text.gsub(/\W/, ' ').downcase.split(' ')
    words.inject(Hash.new(0)) { |h, i| h[i] += 1; h }
  end

  def find_word_on_article(word, article)
    text = library.article_text(article)
    text =~ /\b#{word}\b/i
  end

  def count_repeated_words_in_library(word)
    library.articles.inject(0) do |acc, article|
      acc += 1 if find_word_on_article(word, article)

      acc
    end
  end

  def inverse_document_frequency(word)
    word_repeated_on_library = count_repeated_words_in_library(word)
    word_repeated_on_library += 1 unless word_repeated_on_library == library.length

    Math.log2(library.length/word_repeated_on_library)
  end

  def generate
    tf_idf = terms_frequency.inject(Hash.new(0)) do |hash, term|
      word                = term[0]
      repeated_on_article = term[1]
      idf                 = inverse_document_frequency(word)

      hash[word] = repeated_on_article * idf

      hash
    end

    tf_idf.sort_by { |term, value| value }.reverse.to_h
  end
end
