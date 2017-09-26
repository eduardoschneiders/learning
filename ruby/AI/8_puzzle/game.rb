#!/usr/bin/env ruby

require 'pry'
# [1 2 3]
# [4 5 6]
# [7 8 _]

require './board.rb'
require './node.rb'
require './graph.rb'

def debug(root_node)
  Node.nodes.each { |n| n.board.draw};
  puts '===========================================';
  Node.leave_nodes.each { |n| n.board.draw};
  puts '====================';
  Node.best_leave.board.draw

  graph = Graph.new
  graph.build_graph(root_node) && graph.output
  nil
end

expected_matrix = [
  [1,2,3],
  [4,5,6],
  [7,8,nil]
]

original_matrix = [
  [6,4,7],
  [8,5,nil],
  [3,2,1]
]

board = Board.new(original_matrix, expected_matrix)
root_node = Node.new(board, 'init')
graph = Graph.new

while((current_node = Node.best_leave) && current_node.board.score != 0)
  current_node.mark_as_visited

  current_node.board.possible_moves.each do |move|
    new_board = current_node.board.duplicate
    new_board.move(move)
    current_node.add_chield(new_board, move)
  end
end

count = current_node.count_moves
p "#{count} moves"

graph.build_graph(root_node)
graph.output
