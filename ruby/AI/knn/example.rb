$:.unshift(File.dirname(__FILE__))

require 'knn'
require 'data_classes/flowers'
require 'data_classes/cars'
require 'data_classes/flags'

# train_data            = Flags.train_data('religion', 'zone', 'population', 'area', 'language', 'mainhue', 'circles', 'name')
train_data            = Cars.train_data('make', 'width', 'height', 'curb-weight', 'engine-type', 'fuel-type')
# train_data            = Flowers.train_data('sepal_length', 'sepal_width', 'petal_length', 'petal_width', 'class')

train = KNN.new(train_data)

train_example = train.take_an_example(8)
neighbors = train.neighbors(train_example)
predicted_class = train.class_name(neighbors)


puts "\n\nPredicted Class: #{predicted_class}"
puts "Actual Class: #{train_example[-1]}"
puts "\nInstance: #{train_example}"
puts  "Most relevant: #{neighbors.first[:instance]}"
