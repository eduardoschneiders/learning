require 'data_classes/main_class'

class Cars < MainClass
  def self.attrs
    [
      'symboling',
      'normalized-losses',
      'make',
      'fuel-type',
      'aspiration',
      'num-of-doors',
      'body-style',
      'drive-wheels',
      'engine-location',
      'wheel-base',
      'length',
      'width',
      'height',
      'curb-weight',
      'engine-type',
      'num-of-cylinders',
      'engine-size',
      'fuel-system',
      'bore',
      'stroke',
      'compression-ratio',
      'horsepower',
      'peak-rpm',
      'city-mpg',
      'highway-mpg',
      'price'
    ]
  end

  def self.file_name
    'data_cars.json'
  end
end
