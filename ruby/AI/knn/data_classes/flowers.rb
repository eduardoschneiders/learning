require "data_classes/main_class"

class Flowers < MainClass
  def self.attrs
    [
      'sepal_length',
      'sepal_width',
      'petal_length',
      'petal_width',
      'class'
    ]
  end

  def self.file_name
    'data_iris.json'
  end
end
