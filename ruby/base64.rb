require 'pry'

# A
# 01000001
# 010000 010000

# encode('And') == 'QW5k'

# 'A' 00000000
# 'n' 00000000
# 'd' 00000000

# 00000000 00000000 00000000
# 000000 000000 000000 000000

class Base64
  def self.encode(str)
    str.split('').each_slice(3).map do |pack|
      pack.join.bytes.map { |c| c.to_s(2).rjust(8, '0') }.join
    end.map do |pack|
      pack.split('').each_slice(6).map do |bits|
        i = bits.join.ljust(6, '0').to_i(2)
        table[i]
      end.join.ljust(4, '=')
    end.join
  end

  def self.decode(str)
    str.gsub('=', '').split('').each_slice(4).map do |pack|
      pack.map do |char|
        table.index(char).to_s(2).rjust(6, '0')
      end.join
    end.map do |bits|
      bits.split('').each_slice(8).map do |byte|
        next if byte.size < 8
        byte.join.to_i(2).chr
      end.compact
    end.join
  end

  private

  def self.table
    [].tap do |t|
      t << ('A'..'Z').to_a
      t << ('a'..'z').to_a
      t << ('0'..'9').to_a
      t << ['+', '/']
    end.flatten
  end
end

def expect(current, expected)
  if current == expected
    p 'OK'
  else
    p 'Error'
  end
end

10.times.each do
  str = 200.times.map { Random.rand(256).chr }.join
  expect(Base64.decode(Base64.encode(str)), str)
end

p Base64.encode('And')
p Base64.decode('QW5k')