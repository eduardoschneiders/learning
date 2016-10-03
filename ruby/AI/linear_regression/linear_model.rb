class LinearModel
  attr_accessor :observations

  def initialize(observations)
    @observations = observations
  end

  def y_prediction(x)
    slope * x + y_intercept
  end

  private

  def y_intercept
    (sum_y - (slope * sum_x)) / n
  end

  def slope
    top_formula / bottom_formula
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

  def top_formula
    sum_xy - (sum_x * sum_y / n.to_f)
  end

  def bottom_formula
    sum_squared_x - (square_of_sum_x / n.to_f)
  end
end
