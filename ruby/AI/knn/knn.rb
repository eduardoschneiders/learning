require 'json'
require './flags'
require './cars'

def euclidean_distance(instance1, instance2, k)
  total = 0
  k.times.each do |x|
    total += (instance1[x] - instance2[x]) ** 2
  end

  Math.sqrt(total)
end

def neighbors(train_data, instance)
  train_data.map do |instance_data|
    distance = euclidean_distance(instance_data, instance, instance.size - 1)
    { distance: distance, name: instance_data[-1], instance: instance_data }
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
  current/values.max.to_f
end

def normalize_field(values, value)
  values.group_by { |a| a }.keys.map { |a| a == value ? 1 : 0}
end

def normalize(data)
  data.map do |record|
    name = record.pop

    record.each_with_index.map do |attr, i|
      values = data.map { |d| d[i] }

      if attr.class == String
        normalize_field(values, attr)
      else
        normalize_value(values, attr)
      end
    end.flatten.push(name)
  end
end

train_data            = Flags.train_data('religion', 'zone', 'population', 'area', 'language', 'mainhue', 'circles', 'name')
train_data            = Cars.train_data('peak-rpm', 'stroke', 'city-mpg', 'compression-ratio', 'fuel-type')
normalized_train_data = normalize(train_data)

instance = normalized_train_data[Random.rand(normalized_train_data.size)]
neighbors = neighbors(normalized_train_data, instance)
name = class_name(neighbors)

puts "\n\nPredicted Class: #{name}"
puts "Actual Class: #{instance[-1]}"
puts "\nInstance: #{instance}"
puts  "Most relevant: #{neighbors.first[:instance]}"
