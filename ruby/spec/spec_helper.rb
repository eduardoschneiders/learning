$: << File.join(File.dirname(__FILE__), '..')

require 'pry' if ENV['APP_ENV'] == 'debug' # add `binding.pry` wherever you need to debug

require 'caesar_cipher_encrypt'
require 'stock_picker'
require 'substrings'
require 'angsty_named_person'
