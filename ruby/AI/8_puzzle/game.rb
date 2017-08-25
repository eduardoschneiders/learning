#!/usr/bin/env ruby

require 'pry'
require 'graphviz'

# [1 2 3]
# [4 5 6]
# [7 8 _]

class Table
  attr_accessor :size, :original_matrix, :expected_matrix

  def initialize(original_matrix, expected_matrix, make_draw = true)
    @original_matrix = original_matrix
    @expected_matrix = expected_matrix
    @size = original_matrix.size

    draw if make_draw
  end

  def score
    score = 0

    (0..size-1).each do |expected_line|
      (0..size-1).each do |expected_collumn|
        if expected_number = expected_matrix[expected_line][expected_collumn]
          found_line, found_collumn = find_position(expected_number)
          diff = (found_line - expected_line).abs + (found_collumn - expected_collumn).abs
          score += diff
        end
      end
    end

    score
  end

  def find_position(item)
    (0..size-1).each do |line|
      (0..size-1).each do |collumn|
        if original_matrix[line][collumn] == item
          return [line, collumn]
        end
      end
    end
  end

  def find_blank_position
    find_position(nil)
  end

  def position_inside_range(position)
    (position) >= 0 && (position) < size
  end

  def possible_moves
    moves = [:down, :up, :left, :right]
    blank_line, blank_collumn = find_blank_position

    moves.delete(:down) if blank_line <= 0
    moves.delete(:up) if blank_line >= size - 1
    moves.delete(:left) if blank_collumn >= size - 1
    moves.delete(:right) if blank_collumn <= 0

    moves
  end

  def swap_line(offset)
    blank_line, blank_collumn = find_blank_position

    if position_inside_range(blank_line + offset)
      original_matrix[blank_line][blank_collumn] = original_matrix[blank_line + offset][blank_collumn]
      original_matrix[blank_line + offset][blank_collumn] = nil
    end
  end

  def swap_collumn(offset)
    blank_line, blank_collumn = find_blank_position

    if position_inside_range(blank_collumn + offset)
      original_matrix[blank_line][blank_collumn] = original_matrix[blank_line][blank_collumn + offset]
      original_matrix[blank_line][blank_collumn + offset] = nil
    end
  end

  def down
    swap_line(-1)
  end

  def up
    swap_line(1)
  end

  def left
    swap_collumn(1)
  end

  def right
    swap_collumn(-1)
  end

  def move(action, make_draw = false)
    send(action)
    draw(action) if make_draw
  end

  def draw(action = 'initialization')
    puts "\n------ #{action.upcase} ------"
    original_matrix.each { |line| p line }
  end

  def duplicate
    self.class.new(Marshal::load(Marshal.dump(original_matrix)), expected_matrix, false)
  end

  def hash
    original_matrix.hash
  end
end


class Node
  attr_accessor :table, :hash, :move, :finished, :nodes

  def initialize(table, move)
    @table = table.duplicate
    @hash = table.hash
    @finished = false
    @nodes = []
    @move = move
  end

  def finish
    @finished = true
  end
end

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

generate_graph= Proc.new do |g, node|

  node_id = node.move.to_s + node.hash.to_s[0..5]
  options = { label: node.move.to_s + ' ' + node.table.score.to_s }
  options.merge!(style: 'filled') if node.finished

  rn = g.add_node(node_id, options)

  node.nodes.each do |node|
    ch = generate_graph.call(g, node)
    g.add_edges(rn, ch)
  end

  rn
end

draw_graph = Proc.new do |root_node|
  g = GraphViz.new( :G, :type => :digraph )
  generate_graph.call(g, root_node)
  g.output(jpg: "graph.jpg")
end

root_table   = Table.new(original_matrix, expected_matrix)
current_node = root_node = Node.new(root_table, 'init')
moves_hashes = [root_table.hash]

while (current_node.table.score != 0 && !root_node.finished) do
  possible_moves = current_node.table.possible_moves.map do |move|
    new_table = current_node.table.duplicate
    new_table.move(move)

    { move: move, hash: new_table.hash, table: new_table }
  end

  next_move = possible_moves.select do |move|
    !moves_hashes.include?(move[:hash]) && !current_node.nodes.any? { |node| node.hash == move[:hash] && node.finished }
  end.sort_by do |move|
    move[:table].score
  end.first

  possible_moves.select do |move|
    !current_node.nodes.find { |node| node.hash ==move[:hash] }
  end.each do |move|
    next_node = Node.new(move[:table], move[:move])
    next_node.finish if moves_hashes.include?(move[:hash])
    current_node.nodes << next_node
  end

  draw_graph.call(root_node)
  sleep(5)

  if next_move
    next_node = current_node.nodes.find { |node| node.hash == next_move[:hash] }

    current_node = next_node
    moves_hashes << current_node.table.hash
    current_node.table.draw(next_move[:move])
  else
    p '================= FROM TOP ===================='
    current_node.finish
    current_node = root_node
    moves_hashes = [root_table.hash]
  end

end


p 'Ended'

# - get node
# - check possible moves

# - if find next move not in child
#                   move hash not in moves_hashes
#                   (finished: true, hash: hash)
#   - make the move
#   - moves_hashes << move hash
#   - if not in child
#       - add new node
#   - current_node => node
# else
#   - mark as finished
#   - current_node => root_node



