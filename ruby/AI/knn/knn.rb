a = [4,4]
c = [2,2]

train_data = [
  [4,4, 'x'],
  [7,7, 'x'],
  [10,10, 'y'],
  [15,15, 'y'],
  [20,20, 'y'],
  [30,35, 'y'],
  [1,1, 'x'],
  [3,3, 'x'],
]

a = [2, 2, 'x']
b = [20, 15, 'y']

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
    { distance: distance, name: instance_data[-1] }
  end.sort_by do |data|
    data[:distance]
  end
end

def class_name(instances, k)
  instances.take(k).inject({}) do |data, i|
    data[i[:name]] ||= 0
    data[i[:name]] += 1
    data
  end.keys.first
end

neighbors = neighbors(train_data, b)
p class_name(neighbors, 3)
