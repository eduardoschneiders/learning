#!/usr/bin/env ruby

module BubbleSort
  def bubble_sort
    @numbers.each do
      @numbers.each_with_index do |number, index|
        try_switch(index)
      end
    end
  end

  private

  def try_switch(index)
    current_number = @numbers[index]
    next_number = @numbers[index + 1]

    if next_number && current_number > next_number
      @numbers[index] = next_number
      @numbers[index + 1] = current_number
    end
  end
end

module QuickSort
  def quick_sort(numbers = @numbers)
    return numbers if numbers.length <= 1

    pivot = numbers.last
    less = []
    equal = []
    greater = []

    numbers.each do |number|
      if number < pivot
        less << number
      elsif number > pivot
        greater << number
      else
        equal << number
      end
    end

    less = quick_sort(less)
    greater = quick_sort(greater)

    less.concat(equal).concat(greater)
  end
end

class Sort
  include BubbleSort
  include QuickSort
  attr_accessor :length, :max, :numbers, :begin_time, :end_time

  def initialize(length = 10, max = 20)
    @length = length
    @max = max

    rand_numbers
  end

  def benchmark
    @begin_time = Time.now
    yield
    @end_time = Time.now

    puts duration
  end

  def duration
    puts Time.at(@end_time - @begin_time).utc.strftime('%H:%M:%S:%L')
  end

  private

  def rand_numbers
    puts 'Generating numbers ...'
    random = Random.new
    @numbers = @length.times.map { random.rand(@max) }
  end
end

sort = Sort.new 1_000, 100

sort.benchmark do
  puts 'Bubble_sort: '
  sort.bubble_sort
end

sort.benchmark do
  puts 'Quick_sort: '
  sort.quick_sort
end
