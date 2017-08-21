#!/usr/bin/env ruby

require 'pry'

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
  attr_accessor :hash, :finished, :nodes

  def initialize(hash)
    @hash = hash
    @finished = false
    @nodes = []
  end

  def finish
    @finished = true
  end
end

expected_matrix = [
  [1,2,3],
  [8,nil,4],
  [7,6,5]
]
original_matrix = [
  [2,8,3],
  [1,4,6],
  [7,nil,5]
]

root_table   = Table.new(original_matrix, expected_matrix)
root_node    = Node.new(root_table.hash)
score        = root_table.score
moves_hashes = []

moves_hashes << root_table.hash
current_node = root_node
table        = root_table.duplicate

while (score != 0 && !root_node.finished) do
  a = table.possible_moves.map do |move|
    new_table = table.duplicate
    new_table.move(move)

    { move: move, hash: new_table.hash, score: new_table.score }
  end

    binding.pry if @a
  b = a.select do |move|
    !current_node.nodes.any? { |node| node.hash == move[:hash] && node.finished }
  end

  next_move = b.sort_by do |move|
    move[:score]
  end.first
    child_nodes_finished = current_node.nodes.all? { |node| node.hash == move[:hash] && node.finished }

  # binding.pry if @a
  if next_move
    table.move(next_move[:move], true)
    score = table.score
    moves_hashes << table.hash

    unless next_node = current_node.nodes.find { |node| node.hash == table.hash }
     next_node = Node.new(table.hash)
     current_node.nodes << next_node
    end

     current_node = next_node
  else
    p '================= FROM TOP ===================='
    @a = false
    current_node.finish
    current_node = root_node
    table = root_table
  end
  p score
  sleep(0.1)
end
binding.pry

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



