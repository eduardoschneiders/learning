#!/usr/bin/env ruby
#source https://www.youtube.com/watch?v=1C3olrs1CUw

require './linear_model'

observations = [
  [-5, 21],
  [-2, 19],
  [1, 19],
  [4, 21],
  [7, 21],
  [10, 24],
  [13, 27],
  [16, 24]
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

init_x = min_x(observations)
init_y = lm.first_degree_y_prediction(init_x)

final_x = max_x(observations)
final_y = lm.first_degree_y_prediction(final_x)

# regression_coordinates = 10.times.map { : }
write(observations, [[init_x, init_y], [final_x, final_y]])
