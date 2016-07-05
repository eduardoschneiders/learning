#!/usr/bin/env ruby

require 'pry'
require 'json'
require './library'
require './tf_idf'

def create_result_file(title, text)
  Dir.mkdir('results/') unless File.exists? 'results/'
  File.open("results/#{title}", 'w') { |f| f.puts text }
end

def library
  Library.new
end

def results_files
  Dir.entries('results/').reject { |file| file =~ /\.|\.\./ }
end

def other_results_files(exclude_article)
  Dir.entries('results/').reject { |file| file =~ /\.|\.\.|#{exclude_article}/ }
end

def read_result_file(article)
  File.open("results/#{article}", 'r') { |f| f.read }
end

def article_results(article)
  JSON.parse(read_result_file(article))['results']
end

def other_articles_vectors(exclude_article)
  other_results_files(exclude_article).map do |article|
    results = article_results(article)

    {
      article: article,
      vector: normalized_vector(results)
    }
  end
end

def generate_tf_idf
  library.articles.take(7).each do |article|
    tf_idf = TfIdf.new(article, library).generate.take(50).to_h
    create_result_file(article,  { results: tf_idf }.to_json)
  end
end

def normalized_value(values)
  Math.sqrt(values.map { |n| n ** 2}.inject(0) { |acc, n| acc + n})
end

def normalized_vector(results)
  normalized_value = normalized_value(results.values)

  results.inject(Hash.new(0)) do |h, (word, value)|
    h[word] = normalized_value
    h
  end

end


def calculate_vactors(v1, v2)
  total_v1 =  v1.inject(0) { |acc, (word, value)| acc += v2[word] || 0; acc }
  total_v2 =  v2.inject(0) { |acc, (word, value)| acc += v1[word] || 0; acc }

  total_v1 + total_v2
end

def generate_comparison
  results_files.each do |article|
    results = article_results(article)
    main_vector = normalized_vector(results)

    comparisons = other_articles_vectors(article).map do |other_article|
      article_title = other_article[:article]
      value = calculate_vactors(main_vector, other_article[:vector])
      {
        article: article_title,
        value: value
      }
    end.sort_by { |c| c[:value] }.reverse

    create_result_file(article, { results: results, comparisons: comparisons}.to_json)
  end
end

