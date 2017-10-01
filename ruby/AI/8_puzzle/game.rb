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

def generate_chields(current_node)
  # current_node.mark_as_visited

  children_options = current_node.board.possible_moves.map do |move|
    new_board = current_node.board.duplicate
    new_board.move(move)
    { board: new_board, move: move }
  end

  current_node.add_children(children_options)
end

count = 0
while(!winner = Node.leave_nodes.find { |node| node.board.score == 0}) do
  t = Time.now
  leaves = Node.leave_nodes
  # leaves = [Node.best_leave]
  queue = Queue.new
  leaves.each do |node|
    queue.push node
  end

  300.times.map do
    Thread.new do
      while !queue.empty?
        node = queue.pop
        generate_chields(node)
      end
    end
  end.each(&:join)
  leaves = Node.leave_nodes
  min_score = leaves.min_by { |n| n.board.score }.board.score

  p "#{(Time.now - t).round(2)} -> #{leaves.count}, score: #{min_score}"
  count += 1
  # break if count >= 15
end

# winner ||= Node.leave_nodes.min_by { |node| node.board.score }
count = winner.count_moves
p "#{count} moves"

graph.build_graph(root_node)
graph.output
