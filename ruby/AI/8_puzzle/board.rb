class Board
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

