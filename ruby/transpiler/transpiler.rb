require './grammar'
require 'pry'

source_code = 'abcdefg'
g = Grammar.new
g.validate(source_code)
