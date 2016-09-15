var_name        = /[a-zA-Z][a-zA-Z0-9_]*/                             # xpto_123
var_declaration = /(?:var\s)?(#{var_name})/                           # var xpto
value           = /[\d]+|#{var_name}/                                 # 12

function_params_declaration = /\((?:#{var_name},\s?)*#{var_name}\)/         # (x) | (x, y) | (x, y, z)
function_params_call        = /\((?:#{value},\s?)*#{value}\)/               # (1) | (1, 2) | (1, 2, 3)

function_declaration        = /function\s(#{var_name})\s?#{function_params_declaration}\s?{?/   # function multiply(x, y) {
function_call               = /(#{var_name})\s?#{function_params_call}/                         # multiply(1, 2)

binary_operator       = /==|>=|<=|>|<|\/|\*|\+|-/                                             # <
unary_operator        = /\+\+|--/                                                             # ++|--
binary_expression     = /(#{value}\s?#{binary_operator}\s?#{value})/                          # f < g | f * 1
unary_expression      = /(#{var_name}#{unary_operator})/                                      # f++ | f--
expression            = /#{binary_expression}|#{unary_expression}|#{function_call}|#{value}/  # f < g | multiply(1, 2) | f++ | 1
attribution           = /#{var_declaration}\s?=\s?(#{expression});?/                          # xtpo = h <= i

function_return       = /return\s(#{expression});?/                                             # return x * y;
conditional           = /if\s\((#{attribution}|#{expression})\)\s?{?/                           # if (x < 0) {
for_loop              = /for\s?\(#{attribution};\s?#{expression};\s?#{unary_expression}\)\s?{?/ # for (x = 0, x <= 10, x++)
while_loop            = /while\s?\(#{expression}\)\s?{?/                                        # while (x <= 10)

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
  } else if(){
    x--;
  }

  for (x = 0; x <= result; x++){
    x++;
  }

  while (x <= 10){
    x++;
  }
'

file_content = File.read('source_code.txt')
unless file_content.empty?
  source_code = file_content
end

results = []
line_number = 1
source_code.each_line do |line|

  if match = line.match(function_declaration)
    function_name = match.captures.first
    results << { text: "Function declaration: #{function_name}", line_number: line_number, line_text: line }
  end

  if match = line.match(function_return)
    return_expression = match.captures.first
    results << { text: "Function return: #{return_expression}", line_number: line_number, line_text: line }
  end

  if match = line.match(attribution)
    var, expression = match.captures[0..1]
    results << { text: "Attribution of expression: #{expression} to var: #{var}", line_number: line_number, line_text: line }
  end

  if match = line.match(conditional)
    condition = match.captures.first
    results << { text: "Conditional: #{condition}", line_number: line_number, line_text: line }
  end

  if match = line.match(unary_expression)
    expression = match.captures.first
    results << { text: "Unary expression: #{expression}", line_number: line_number, line_text: line }
  end

  if match = line.match(binary_expression)
    expression = match.captures.first
    results << { text: "Binary expression: #{expression}", line_number: line_number, line_text: line }
  end

  if match = line.match(for_loop)
    results << { text: "For loop", line_number: line_number, line_text: line }
  end

  if match = line.match(while_loop)
    results << { text: "while loop", line_number: line_number, line_text: line }
  end

   line_number += 1
end

results.each do | result |
  p "%2s %-60s %-35s" % [result[:line_number], result[:text], result[:line_text].gsub("\n", '')]
end
