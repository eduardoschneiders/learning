#!/usr/bin/env ruby
# ./image.rb && compare -metric AE -compose src image.png image_mod.png difference.pdf
require 'pry'
require 'rmagick'
require 'caesar_encrypt'
include Magick

image = ImageList.new("image_mod.png").first
pixels = image.get_pixels(0, 0, image.columns, image.rows)

string = char = ""
init_range = 0
end_range = 2

while (selected_pixels = pixels[init_range..end_range]) do
  i = 0

  selected_pixels = selected_pixels.map do |pixel|
    [
      (pixel.red / 257).to_s(2).rjust(8, '0'),
      (pixel.green / 257).to_s(2).rjust(8, '0'),
      (pixel.blue / 257).to_s(2).rjust(8, '0')
    ]
  end

  char = selected_pixels.flatten.take(8).map { |char| char[-1] }.join('').to_i(2).chr
  break if char == "\0"
  string << char

  init_range += 3
  end_range += 3
end
puts string
decrypted = CaesarEncrypt.decrypt(string, 5)
File.write('text_translated.txt', decrypted)
