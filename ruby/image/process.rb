#!/usr/bin/env ruby
# ./process.rb && compare -metric AE -compose src image.png image_mod.png difference.pdf
require 'pry'
require 'rmagick'
require 'caesar_encrypt'
include Magick

image = ImageList.new("image.png").first
pixels = image.get_pixels(0, 0, image.columns, image.rows)

string = "Eduardo Schneiders"
# string = 10000.times.map { Random.rand(97..122).chr }.join('')

string = File.read('text_to_translate.txt')

string = CaesarEncrypt.encrypt(string, 5) + "\0"

char_position = init_range = 0

while ((char = string[char_position]) && (selected_pixels = pixels[init_range..init_range + 2])) do
  origin_pixels = selected_pixels
  binary_char = char.unpack("B*").first

  selected_pixels = selected_pixels.map do |pixel|
    [
      (pixel.red / 257).to_s(2).rjust(8, '0'),
      (pixel.green / 257).to_s(2).rjust(8, '0'),
      (pixel.blue / 257).to_s(2).rjust(8, '0')
    ]
  end

  i = 0
  binary_char.each_char do |bit|
    selected_pixels.flatten[i][7] = bit
    i += 1
  end

  selected_pixels.each_with_index do |rgb, i|
    rgb.each_with_index do |byte, j|
      selected_pixels[i][j] = byte.to_i(2) * 257
    end
  end

  selected_pixels = selected_pixels.each_with_index do |rgb, i|
    origin_pixels[i].red = rgb[0]
    origin_pixels[i].green = rgb[1]
    origin_pixels[i].blue = rgb[2]
  end

  pixels[init_range] = origin_pixels[0]
  pixels[init_range + 1] = origin_pixels[1]
  pixels[init_range + 2] = origin_pixels[2]

  init_range += 3
  char_position += 1
end

image.store_pixels(0, 0, image.columns, image.rows, pixels)
image.write('image_mod.png')
