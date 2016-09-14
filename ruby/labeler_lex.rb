var_name        = /[a-zA-Z][a-zA-Z0-9_]*/                             #xpto_123
var_declaration = /(?:var\s)?(#{var_name})/                           #var xpto
value           = /[\d]+|#{var_name}/                                 #12

function_params_declaration = /\((?:#{var_name},\s?)*#{var_name}\)/         #(x) | (x, y) | (x, y, z)
function_params_call        = /\((?:#{value},\s?)*#{value}\)/               #(1) | (1, 2) | (1, 2, 3)

function_declaration        = /function\s(#{var_name})\s?#{function_params_declaration}\s?{?/   #function multiply(x, y) {
function_call               = /(#{var_name})\s?#{function_params_call}/                         #multiply(1, 2)

binary_operator       = /==|>=|<=|>|<|\/|\*|\+|-/                                     #<
unary_operator        = /\+\+|--/                                                     #++|--
binary_expression     = /#{value}\s?#{binary_operator}\s?#{value}/                    #f < g | f * 1
unary_expression      = /#{var_name}#{unary_operator}/                                   #f++ | f--
expression            = /(?:#{binary_expression})|(?:#{unary_expression})|(?:#{function_call})|(?:#{value})/  #f < g | multiply(1, 2) | f++ | 1
attribution           = /#{var_declaration}\s?=\s?(#{expression});?/                #xtpo = h <= i

function_return       = /return\s(#{expression});?/                               #return x * y;
conditional           = /if\s\((#{attribution}|#{expression})\)\s?{?/
for_loop              = /for\s?\(#{attribution};\s?#{expression};\s?#{unary_expression}\)\s?{?/
while_loop            = /while\s?\(#{expression}\)\s?{?/



source_code = '
  function multiply(x, y) {
    return x * y;
  }

  result = multiply(1, 2);

  xtpo = a >= b;
  xtpo = c > e;
  xtpo = f < g;
  xtpo = h <= i;
  xpto = x++;

  if (xpto >= 0) {
    x++;
  }

  for (x = 0; x <= result; x++){
    x++;
  }

  while (x <= 10){
    x++;
  }

'

results = []
line_number = 0
source_code.each_line do |line|

  if match = line.match(function_declaration)
    function_name = match.captures.first
    results << { text: "Function declaration: #{function_name}", line: line_number }
  end

  if match = line.match(function_return)
    return_expression = match.captures.first
    results << { text: "Function return: #{return_expression}", line: line_number }
  end

  if match = line.match(attribution)
    var, expression = match.captures[0..1]
    results << { text: "Attribution of expression: #{expression} to var: #{var}", line: line_number }
  end

  if match = line.match(conditional)
    condition = match.captures.first
    results << { text: "Conditional: #{condition}", line: line_number }
  end

  if match = line.match(unary_expression)
    results << { text: "Unary expression", line: line_number }
  end

  if match = line.match(binary_expression)
    results << { text: "Binary expression", line: line_number }
  end

  if match = line.match(for_loop)
    results << { text: "For loop", line: line_number }
  end

  if match = line.match(while_loop)
    results << { text: "while loop", line: line_number }
  end

   line_number += 1
end

results.each do | result |
  p "#{result[:line]}  #{result[:text]}"
end
