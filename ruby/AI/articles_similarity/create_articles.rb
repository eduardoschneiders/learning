#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'pry'

def download_html(url)
  begin
    Nokogiri::HTML(open(url))
  rescue => e
    redirect_url = e.message.split('->').last.strip
    download_html(redirect_url)
  end
end

def text(html, body_selector)
  html.css(body_selector).text.gsub(/\n|\t/, ' ')
end

def title(html)
  html.css('title').text.gsub(/[\W]/, '_').downcase[0..70]
end

def create_file(title, text)
  Dir.mkdir('articles/') unless File.exists? 'articles/'
  File.open("articles/#{title}", 'w') { |f| f.puts text }
end

def create_article(url, body_selector)
  html = download_html(url)
  text = text(html, body_selector)
  title = title(html)

  if block_given?
    rerun = yield(text, rerun)
    if rerun
      puts text.size
      return  create_article(url, body_selector)
    end
  end

  create_file(title, text)

  title
end


def generate_library_articles
  url = 'https://en.wikipedia.org/wiki/Special:Randompage'

  total = 500
  total.times do |i|
    title = create_article(url, '#bodyContent') do |text, rerun|
      true if text.size <= 5_000
    end
    puts "#{i + 1} of #{total} #{title}"
  end
end

def specific_articles
  [
    {
      url: 'https://www.theguardian.com/football/blog/2016/jun/29/lionel-messi-retirement-argentina-football-team',
      body_selector: '.content__main-column--article'
    },
    {
      url: 'http://www.independent.co.uk/sport/football/european/champions-league-final-lionel-messi-admits-barcelona-cheering-for-atletico-in-revenge-mission-a7022161.html',
      body_selector: '.text-wrapper'
    },
    {
      url: 'https://en.wikipedia.org/wiki/Lionel_Messi',
      body_selector: '#bodyContent'
    },
    {
      url: 'http://billpatrianakos.me/blog/2016/06/14/being-a-developer-is-not-about-writing-code/',
      body_selector: '.entry-content'
    },
    {
      url: 'https://en.wikipedia.org/wiki/Computer_programming',
      body_selector: '#bodyContent'
    },
    {
      url: 'https://en.wikipedia.org/wiki/Python_(programming_language)',
      body_selector: '#bodyContent'
    },
  ]
end

def generate_specific_articles
  specific_articles.each do |article|
    title = create_article(article[:url], article[:body_selector])
    puts title
  end
end

# generate_library_articles
generate_specific_articles
