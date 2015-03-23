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
    random = Random.new
    @numbers = @length.times.map { random.rand(@max) }
  end
end

class Benchmark
  attr_accessor :lengths, :results

  def initialize(lengths = [10])
    @lengths = lengths
    @results = {}
  end

  def bench
    @lengths.each do |length|
      begin_time = Time.now
      yield length
      end_time = Time.now
      @results[length] = end_time - begin_time
    end
  end

  def results
    @results
  end
end

benchmark = Benchmark.new([50, 1_000, 5_000, 10_000])

benchmark.bench do |length|
  sort = Sort.new length
  sort.bubble_sort
end

bubble_sort_results = benchmark.results.values

benchmark.bench do |length|
  sort = Sort.new length
  sort.quick_sort
end

quick_sort_results = benchmark.results.values

require 'gruff'
g = Gruff::Line.new
g.title = 'Bubble sort Vs Quick sort'
labels = Hash.new
i = 0
benchmark.results.keys.map { |key| labels[i] = key.to_s; i += 1  }
g.labels = labels
g.data :BubbleSort, bubble_sort_results
g.data :QuickSort, quick_sort_results

g.write('bubble_vs_quick.png')
