require "matrix"
string = File.read('iris.data').strip.split("\n")
 
output = []
data = string.map do |line|
  line = line.split(",")
  output << case(line.last)
    when /setosa/i then [1, 0, 0]
    when /versicolor/i then [0, 1, 0]
    else [0, 0, 1]
  end
  line[0..3].map { |e| e.to_f }
end
 
input_matrix = Matrix[*data]
output_matrix = Matrix[*output]
 
def initial_weights(rows, cols)
  weights = 1.upto(rows).map do
    1.upto(cols).map do
      rand / 10 - 0.05
    end
  end
  Matrix[*weights]
end
 
def activation_function(x)
  Math.tanh(x)
end
 
def activation_derivative(x)
  1 - (Math.tanh(x) ** 2)
end
 
input_weights = initial_weights(5, 8)
hidden_weights = initial_weights(9, 3)
 
def calculate_neuron(input, weights)
  input_with_bias = input.to_a.map { |x| [1] + x }
  input_with_bias = Matrix[*input_with_bias]
  input_with_bias * weights
end
 
 
def calculate_neuron_activation(input, weights)
  output = calculate_neuron(input, weights)
  output.map { |element| activation_function(element) }
end
 
def dot_multiply(m1, m2)
  result = m1.to_a.zip(m2.to_a).map do |row1, row2|
    row1.zip(row2).map do |e1, e2|
      e1 * e2
    end
  end
  Matrix[*result]
end
 
lastcost = 100
alpha = 0.1
lamb = 1
 
class Matrix
  def size
    [row_size, column_size]
  end
end
 
def calculate_gradient(input, input_weights, hidden_weights, output_matrix)
  hidden_layer_input = calculate_neuron_activation(input, input_weights)
  output = calculate_neuron_activation(hidden_layer_input, hidden_weights)
 
  #Custo desta solução:
  size = output_matrix.row_size
  error = output - output_matrix
  squared_error = error.map { |e| e * e }
  mean_squared_error = squared_error.to_a.flatten.inject(0) { |r, e| r + e } / (2 * size)
 
  #Preparando uma matriz sem a função de ativação
  input_with_bias = input.to_a.map { |x| [1] + x }
  input_with_bias = Matrix[*input_with_bias]
  hidden_layer_input_without_activation = (input_with_bias * input_weights).transpose
 
  #Cálculo dos gradientes (oculta -> saída)
  hidden_layer_input_with_bias = hidden_layer_input.to_a.map { |x| [1] + x }
  hidden_layer_input_with_bias = Matrix[*hidden_layer_input_with_bias]
  gradient1 = (error.transpose * hidden_layer_input_with_bias).transpose / size
 
  #Cálculo dos gradientes (entrada -> oculta)
  hidden_weights_chopped = Matrix[*hidden_weights.to_a[1..-1]]
  gradient2 = hidden_weights_chopped * error.transpose
 
  #Calculando a derivada da função de ativação. Como não temos, em Ruby, uma função
  #Math.sech, basta saber que 1-tanh(elemento)^2 é a mesma  coisa que sech(2)^2
  derivatives = hidden_layer_input_without_activation.map { |e| 1 - Math.tanh(e) ** 2 }
 
  #Multiplicar elemento a elemento é meio chato. Estamos aqui transformando
  #o "map" num enumerable, para poder multiplicar com o outro elemento
  mapped = gradient2.enum_for(:map)
  derivatives = derivatives.to_a.flatten
  gradient2 = mapped.with_index { |element, i| element * derivatives[i] }
 
  #Multiplicação pelos neurônios de entrada
  gradient2 = input_with_bias.transpose * gradient2.transpose
  #Divisão pelo número de elementos de treinamento
  gradient2 = gradient2 / size
 
  {
    :cost => mean_squared_error,
    :gradient_inputs => gradient2,
    :gradient_hidden => gradient1
  }
end
 
last_weights = [ input_weights, hidden_weights ]
last_cost = Float::MAX
alpha = 2
while(true)
  gradients = calculate_gradient(input_matrix, input_weights, hidden_weights, output_matrix)
 
  if gradients[:cost] < last_cost
    last_weights = [ input_weights, hidden_weights ]
    input_weights -= gradients[:gradient_inputs].map { |e| e * alpha }
    hidden_weights -= gradients[:gradient_hidden].map { |e| e * alpha}
  else
    #Reseta os pesos para o mesmo valor da iteração anterior
    input_weights, hidden_weights = last_weights
    alpha *= 0.8 #Baixa o alfa em 20%
  end
  last_cost = gradients[:cost]
 
  puts "Custo Atual: #{gradients[:cost]}"
  break if gradients[:cost] < 0.04
end
 
def predict(input, input_weights, hidden_weights)
  hidden_layer_input = calculate_neuron_activation(input, input_weights)
  calculate_neuron_activation(hidden_layer_input, hidden_weights)
end
 
def interpret_result(output)
  output.to_a.map do |e1, e2, e3|
    if e1 > e2 && e1 > e3
      "Setosa"
    elsif e2 > e1 && e2 > e3
      "Versicolor"
    else
      "Virginica"
    end
  end
end
 
 d = [["5.1", "3.5", "1.4", "0.2"]]
 input_matrix = Matrix[*data]
hidden_layer_input = calculate_neuron_activation(input_matrix, input_weights)
require 'pry'; binding.pry
output = calculate_neuron_activation(hidden_layer_input, hidden_weights)
puts interpret_result(output)