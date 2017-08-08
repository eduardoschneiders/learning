# [1 2 3]
# [4 5 6]
# [7 8 _]

class Table
  attr_accessor :size, :lines, :table

  def initialize(size, lines)
    @lines = lines
  end

  def find_blank_position
    (0..2).each do |line|
      (0..2).each do |collumn|
        if lines[line][collumn] == nil
          return [line, collumn]
        end
      end
    end
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

    if (line + 1 <= 2)
      lines[line][collumn] = lines[line + 1][collumn]
      lines[line + 1][collumn] = nil
    end
  end

  def left
    line, collumn = find_blank_position

    if (collumn - 1 >= 0)
      lines[line][collumn] = lines[line][collumn - 1]
      lines[line][collumn - 1] = nil
    end
  end

  def right
    line, collumn = find_blank_position

    if (collumn + 1 <= 2)
      lines[line][collumn] = lines[line][collumn + 1]
      lines[line][collumn + 1] = nil
    end
  end

  def draw
    p '-------'
    lines.each { |line| p line }
  end
end

table = Table.new(3, [[1,2,3],[4,5,6],[7,8,nil]])
table.up
table.draw
