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
  attr_accessor :table, :hash, :finished, :nodes

  def initialize(table)
    @table = table
    @finished = false
    @nodes = []
    @hash = table.hash
  end

  def finish
    finished = true
  end
end

expected_matrix = [
  [1,2,3],
  [8,nil,4],
  [7,6,5]
]
original_matrix = [
  [2,8,3],
  [1,6,4],
  [7,nil,5]
]

table = Table.new(original_matrix, expected_matrix)
score = table.score
 = []

moves_history = MovesHistory.new(table.duplicate.original_matrix, nil)
moves_hashes << table.hash

last_history = moves_history

while (score != 0) do
  selected_action = nil

  table.possible_moves.each do |action|
    current_score = score
    new_table = table.duplicate
    new_table.move(action)

    if new_table.score < current_score
      current_score = new_table.score
      selected_action = action
    end
  end

  if selected_action
    table.move(selected_action, true)

    current_histoy = MovesHistory.new(table.duplicate.original_matrix,  selected_action)
    last_history.nodes << current_histoy
    last_history = current_histoy
  else
    last_history.finished
    table = moves_history.state
  end

  score = table.score
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



