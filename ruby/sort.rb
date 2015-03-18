#!/usr/bin/env ruby
class Sort
  attr_accessor :length, :max, :numbers, :begin_time, :end_time

  def initialize(length = 10, max = 20)
    @length = length
    @max = max

    rand
  end

  def bubble_sort
    @begin_time = Time.now

    @numbers.each do
      @numbers.each_with_index do |number, index|
        try_switch(index)
      end
    end

    @end_time = Time.now
  end

  def duration
    puts Time.at(@end_time - @begin_time).utc.strftime "%H:%M:%S"
  end

  def print
    puts @numbers
  end

  private

  def rand
    @numbers = @length.times.map { Random.new.rand(@max) }
  end

  def try_switch(index)
    current_number = @numbers[index]
    next_number = @numbers[index + 1]

    if next_number && current_number > next_number
      @numbers[index] = next_number
      @numbers[index + 1] = current_number
    end
  end
end

bubble_sort = Sort.new 10000

bubble_sort.bubble_sort
bubble_sort.duration
