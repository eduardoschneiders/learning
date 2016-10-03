#!/usr/bin/env ruby
#source https://www.youtube.com/watch?v=1C3olrs1CUw

require './linear_model'

observations = [
  [65, 105],
  [65, 125],
  [62, 110],
  [67, 120],
  [69, 140],
  [65, 135],
  [61, 95],
  [67, 130]
]


def write(observations, regression_coordinates)
  data  = "var data = {"
  data << "'observations': #{observations},"
  data << "'regression_coordinates': #{regression_coordinates}"
  data << "}"

  File.open('data.js', 'w') { |f| f.write(data) }
end

def min_x(observations)
  observations.map(&:first).inject { |memo, value| memo < value ? memo : value }
end

def max_x(observations)
  observations.map(&:first).inject { |memo, value| memo > value ? memo : value }
end

lm = LinearModel.new(observations)

init_x = min_x(observations) * 0.9
init_y = lm.y_prediction(init_x)

final_x = max_x(observations) * 1.1
final_y = lm.y_prediction(final_x)

write(observations, [[init_x, init_y], [final_x, final_y]])
