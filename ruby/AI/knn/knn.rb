require 'json'

CAR_ATTRS = [
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

FLAGS_ATTRS =[
  'name',
  'landmass',
  'zone',
  'area',
  'population',
  'language',
  'religion',
  'bars',
  'stripes',
  'colours',
  'red',
  'green',
  'blue',
  'gold',
  'white',
  'black',
  'orange',
  'mainhue',
  'circles',
  'crosses',
  'saltires',
  'quarters',
  'sunstars',
  'crescent',
  'triangle',
  'icon',
  'animate',
  'text',
  'topleft',
  'botright',
]

def euclidean_distance(instance1, instance2, k)
  total = 0
  k.times.each do |x|
    total += (instance1[x] - instance2[x]) ** 2
  end

  Math.sqrt(total)
end

def neighbors(train_data, instance)
  train_data.map do |instance_data|
    distance = euclidean_distance(instance_data[:data], instance[:data], instance[:data].size - 1)
    { distance: distance, name: instance_data[:data][-1], instance: instance_data }
  end.sort_by do |data|
    data[:distance]
  end
end

def class_name(instances)
  instances.group_by do |i|
    i[:name]
  end.map do |name, instances|
    [
      name,
      instances.inject(0) { |total, i| i[:distance] + total } / instances.size
    ]
  end.sort_by { |a| a[1]}.first[0]
end

def normalize_value(values, current)
  current/values.max
end

def normalize_field(values, value)
  values.group_by { |a| a }.keys.map { |a| a == value ? 1 : 0}
end

def json_data(file)
  file = File.open(file, 'r') { |f| f.read}
  JSON.parse(file)
end

def data
  file_name = 'data_cars.json'
  file_name = 'data_flags.json'

  data = json_data(file_name)
  data.select { |d| d.none? { |prop| prop == '?'} }
end

def car_attributes(data, record, attributes)
  attributes.map do |attr|
    index_attribute = FLAGS_ATTRS.index(attr)
    raw_value = record[index_attribute]

    if raw_value.class == String
      normalize_field(data.map{ |d| d[index_attribute]}, raw_value)
    else
      normalize_value(data.map{ |d| d[index_attribute]}, raw_value)
    end
  end.flatten
end

train_data = data.map do |i|
  index_attribute = FLAGS_ATTRS.index('zone')
  raw_value = i[index_attribute]

  {
    data: car_attributes(data, i, ['triangle', 'icon', 'sunstars', 'zone', 'language', 'religion', 'stripes', 'colours', 'red', 'green']).push(raw_value),
    raw: i
  }
end.compact

instance = train_data[48]
neighbors = neighbors(train_data, instance)
name = class_name(neighbors)

puts "\n\nPredicted Class: #{name}"
puts "\n\nActual Class: #{instance}"
puts  "\n\nMost relevant: #{neighbors.first[:instance]}"
