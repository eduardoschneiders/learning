require 'json'

class Cars
  ATTRS = [
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

  def self.train_data(*attributes)
    data.map do |d|
      attributes.map do |attr|
        d[ATTRS.index(attr)]
      end
    end
  end

  def self.data
    data = JSON.parse(File.read('data_cars.json'))
    data.select { |d| d.none? { |prop| prop == '?'} }
  end
end
