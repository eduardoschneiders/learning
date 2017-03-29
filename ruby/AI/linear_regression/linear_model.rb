class FirstDegree
  attr_accessor :observations

  def initialize(observations)
    @observations = observations
  end

  def y_prediction(x)
    slope * x + y_intercept
  end

  private

  def slope
    top_formula = sum_xy - (sum_x * sum_y / n.to_f)
    bottom_formula = sum_squared_x - (square_of_sum_x / n.to_f)

    top_formula / bottom_formula
  end

  def y_intercept
    (sum_y - (slope * sum_x)) / n
  end

  def sum_xy #Exy
    observations.inject(0) { |multiply, o| multiply += o[0] * o[1] }
  end

  def sum_x #Ex
    observations.inject(0) { |sum, o|  sum + o[0] }
  end

  def sum_y #Ey
    observations.inject(0) { |sum, o|  sum + o[1] }
  end

  def n
    observations.size
  end

  def sum_squared_x #Ex**2
    observations.inject(0) { |sum, o| sum += o[0] ** 2 }
  end

  def square_of_sum_x #(Ex) ** 2
    sum_x ** 2
  end

end

class SecondDegree
  attr_accessor :observations

  def initialize(observations)
    @observations = observations
  end

  def y_prediction(x)
    (a * x ** 2) + (b * x) + c
  end

  private

  def sum_x #Ex
    observations.inject(0) { |sum, o|  sum + o[0] }
  end

  def sum_y #Ey
    observations.inject(0) { |sum, o|  sum + o[1] }
  end

  def n
    observations.size
  end

  def sum_squared_x #Ex**2
    observations.inject(0) { |sum, o| sum += o[0] ** 2 }
  end

  def sum_squared_x_multiply_y #Ex**2 . y
    observations.inject(0) { |sum, o| sum += (o[0] ** 2) * o[1] }
  end

  def sum_cubic_x #Ex**3
    observations.inject(0) { |sum, o| sum += o[0] ** 3 }
  end

  def sum_quadratic_x #Ex**4
    observations.inject(0) { |sum, o| sum += o[0] ** 4 }
  end

  def sum_xy #Exy
    observations.inject(0) { |multiply, o| multiply += o[0] * o[1] }
  end

  def final_sum_xx # Σxx
    sum_squared_x - ((sum_x ** 2) / n.to_f)
  end

  def final_sum_xy
    sum_xy - ((sum_x * sum_y) / n.to_f)
  end

  def final_sum_xx_powered
    sum_cubic_x - ((sum_squared_x * sum_x) / n.to_f)
  end

  def final_sum_x_powered_y
    sum_squared_x_multiply_y - ((sum_squared_x * sum_y) / n.to_f)
  end

  def final_sum_x_powered_y_powerd
    sum_quadratic_x - ((sum_squared_x ** 2) / n.to_f)
  end

  def a
    top = ((final_sum_x_powered_y * final_sum_xx) - (final_sum_xy * final_sum_xx_powered)) 
    bottom = (final_sum_xx * final_sum_x_powered_y_powerd) - final_sum_xx_powered ** 2

    top / bottom
  end

  def b
    top = final_sum_xy * final_sum_x_powered_y_powerd - final_sum_x_powered_y * final_sum_xx ** 2
    bottom = final_sum_xx * final_sum_x_powered_y_powerd - final_sum_xx_powered ** 2

    top / bottom
  end

  def c
    (sum_y / n.to_f) - (b * sum_x / n.to_f) - (a * (sum_squared_x / n.to_f))
  end
end

class LinearModel
  attr_accessor :observations

  def initialize(observations)
    @observations = observations
  end

  def first_degree_y_prediction(x)
    FirstDegree.new(@observations).y_prediction(x)
  end

  def second_degree_y_prediction(x)
    SecondDegree.new(@observations).y_prediction(x)
  end
end
