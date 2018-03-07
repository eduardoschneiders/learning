require 'json'

class Object
  def deep_copy
    Marshal.load(Marshal.dump(self))
  end
end

class KNN
  attr_accessor :train_data

  def initialize(train_data)
    @train_data = normalize(train_data)
  end

  def take_an_example(i= nil)
    i ||= Random.rand(train_data.size)
    train_data[i]
  end

  def neighbors(instance)
    train_data.map do |instance_data|
      distance = euclidean_distance(instance_data, instance, instance.size - 1)
      { distance: distance, name: instance_data[-1], instance: instance_data }
    end.sort_by do |data|
      data[:distance]
    end
  end

  def class_name(instances)
    a = instances.group_by do |i|
      i[:name]
    end.map do |name, instances|
      [
        name,
        instances.inject(0) { |total, i| i[:distance] + total } / instances.size
      ]
    end
    require 'pry'; binding.pry
      a.sort_by { |a| a[1]}.first[0]
  end

  private

  def euclidean_distance(instance1, instance2, k)
    total = 0
    k.times.each do |x|
      total += (instance1[x] - instance2[x]) ** 2
    end

    Math.sqrt(total)
  end

  def normalize_value(values, current)
    current/values.max.to_f
  end

  def normalize_field(values, value)
    values.group_by { |a| a }.keys.map { |a| a == value ? 1 : 0}
  end

  def normalize(data)
    data.deep_copy.map do |record|
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
end
