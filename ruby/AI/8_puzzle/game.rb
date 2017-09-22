#!/usr/bin/env ruby

require 'pry'
# require 'graphviz'

# [1 2 3]
# [4 5 6]
# [7 8 _]

require './board.rb'
require './node.rb'
expected_matrix = [
  [1,2,3],
  [4,5,6],
  [7,8,nil]
]

original_matrix = [
  [nil,1,2],
  [4,5,3],
  [7,8,6]
]

board = Board.new(original_matrix, expected_matrix)
root_node = Node.new(board)

root_node.board.possible_moves.each do |m|
  new_board = board.duplicate
  new_board.move(m)
  root_node.add_chield(new_board)
end
binding.pry
