#!/usr/bin/env ruby

require 'pry'

# [1 2 3]
# [4 5 6]
# [7 8 _]

class Table
  attr_accessor :size, :original_matrix, :expected_matrix

  def initialize(original_matrix, expected_matrix)
    @original_matrix = original_matrix
    @expected_matrix = expected_matrix
    @size = original_matrix.size
  end

  def score
    score = 0

    # expected_matrix.each do |expected_line|
    #   expected_line.each do |expected_collumn|
    #     found_line, found_collumn = find_position(expected_collumn)
    #     diff = (found_line - line).abs + (found_collumn - collumn).abs
    #     score += diff
    #   end
    # end

    # score

    (0..size-1).each do |expected_line|
      (0..size-1).each do |expected_collumn|
        if item = expected_matrix[expected_line][expected_collumn]
          found_line, found_collumn = find_position(item)
          diff = (found_line - expected_line).abs + (found_collumn - expected_collumn).abs
          score += diff
        end
      end
    end

    score
  end

  def find_position(item)
    (0..@size-1).each do |line|
      (0..@size-1).each do |collumn|
        if original_matrix[line][collumn] == item
          return [line, collumn]
        end
      end
    end
  end

  def find_blank_position
    find_position(nil)
  end

  def down
    line, collumn = find_blank_position

    if (line - 1 >= 0)
      original_matrix[line][collumn] = original_matrix[line - 1][collumn]
      original_matrix[line - 1][collumn] = nil
    end
  end

  def up
    line, collumn = find_blank_position

    if (line + 1 < size)
      original_matrix[line][collumn] = original_matrix[line + 1][collumn]
      original_matrix[line + 1][collumn] = nil
    end
  end

  def left
    line, collumn = find_blank_position

    if (collumn + 1 < size)
      original_matrix[line][collumn] = original_matrix[line][collumn + 1]
      original_matrix[line][collumn + 1] = nil
    end
  end

  def right
    line, collumn = find_blank_position

    if (collumn - 1 >= 0)
      original_matrix[line][collumn] = original_matrix[line][collumn - 1]
      original_matrix[line][collumn - 1] = nil
    end
  end

  def move(action, make_draw = false)
    send(action)
    draw(action) if make_draw
  end

  def draw(action = 'initialization')
    puts "\n-------> #{action}"
    original_matrix.each { |line| p line }
  end

  def duplicate
    new(Marshal::load(Marshal.dump(original_matrix)), expected_matrix)
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

while (score != 0) do
  selected_action = nil

  [:up, :right, :down, :left].each do |action|
    current_score = score
    new_table = table.duplicate
    new_table.move(action)

    if new_table.score < current_score
      current_score = new_table.score
      selected_action = action
    end
  end

  table.move(selected_action, true)
  score = table.score
end

p 'Ended'
