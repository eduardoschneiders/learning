#!/usr/bin/env ruby

require 'pry'

# [1 2 3]
# [4 5 6]
# [7 8 _]

class Table
  attr_accessor :size, :lines, :table

  def initialize(size, mixed, expected)
    @lines = mixed
    @expected_lines = expected
    @size = size
  end

  def sum_diff
    sum = 0
    (0..@size-1).each do |line|
      (0..@size-1).each do |collumn|
        if item = @expected_lines[line][collumn]
          found_line, found_collumn = find_position(item)
          diff = (found_line - line).abs + (found_collumn - collumn).abs
          sum += diff
        end
      end
    end

    sum
  end

  def find_position(item)
    (0..@size-1).each do |line|
      (0..@size-1).each do |collumn|
        if lines[line][collumn] == item
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
      lines[line][collumn] = lines[line - 1][collumn]
      lines[line - 1][collumn] = nil
    end
  end

  def up
    line, collumn = find_blank_position

    if (line + 1 < size)
      lines[line][collumn] = lines[line + 1][collumn]
      lines[line + 1][collumn] = nil
    end
  end

  def left
    line, collumn = find_blank_position

    if (collumn + 1 < size)
      lines[line][collumn] = lines[line][collumn + 1]
      lines[line][collumn + 1] = nil
    end
  end

  def right
    line, collumn = find_blank_position

    if (collumn - 1 >= 0)
      lines[line][collumn] = lines[line][collumn - 1]
      lines[line][collumn - 1] = nil
    end
  end

  def move(action, make_draw = false)
    send(action)
    draw(action) if make_draw
  end

  def draw(action = 'initialization')
    puts "\n-------> #{action}"
    lines.each { |line| p line }
  end
end

expected = [[1,2,3],[4,5,6],[7,8,nil]]
mixed = [
  [1,5,3],
  [4,2,6],
  [nil,7,8]
]
# mixed = [[4,7,8],[1,5,3],[6,2,nil]]

table = Table.new(3, mixed, expected)
diff = table.sum_diff

while (diff != 0) do
  selected_action = nil

  [:down, :up, :left, :right].each do |action|
    lines = Marshal::load(Marshal.dump(table.lines))
    t = Table.new(3, lines, expected)
    t.move(action)
    before_sum ||= t.sum_diff

    if t.sum_diff < before_sum || t.sum_diff < table.sum_diff
      before_sum = t.sum_diff
      selected_action = action
    end
  end

  table.move(selected_action, true) if selected_action
  diff = table.sum_diff
end
