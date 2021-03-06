def sort(numbers)
  init_position = 0
  end_position = 0
  run = true

  begin
    any_changes = false
    a = b = nil

    numbers.size.times.each do |n|
      init_position = n
      end_position = [init_position + 1, numbers.size - 1].min

      a = numbers[init_position]
      b = numbers[end_position]

      if a > b
        any_changes = true
        numbers[init_position] = b
        numbers[end_position] = a
      end
    end

    run = any_changes
  end while run

  numbers
end

def processor_pack(numbers, size = 3)
  numbers_pack = {}
  sorted_pack = {}


  i = 0
  while numbers.any?
    numbers_pack[i] = numbers.slice!(0,size)
    i += 1
  end

  numbers_pack.map do |numbers|
    Thread.new do
      sorted_pack[numbers[0]] = sort(numbers[1])
    end
  end.each(&:join)

  sorted_pack.sort_by { |k, v| k }.map { |pack| pack[1]}.flatten
end

size = 3
numbers = [9, 3, 2, 8, 4, 1, 3]
numbers = 500.times.map { Random.rand(100) }
t = numbers.dup

begin
  numbers = processor_pack(numbers, size)
end while(size <= numbers.size && size *= 2)

p numbers
raise 'Not equal' if numbers.hash != t.sort.hash
