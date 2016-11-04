require 'pry'

var_name        = /[a-zA-Z][a-zA-Z0-9_]*/                             # xpto_123
var_declaration = /(?:var\s)?(#{var_name})/                           # var xpto
value           = /[\d]+|#{var_name}/                                 # 12

function_params_declaration = /\(((?:#{var_name},\s?)*#{var_name})\)/         # (x) | (x, y) | (x, y, z)
function_params_call        = /\((?:#{value},\s?)*#{value}\)/               # (1) | (1, 2) | (1, 2, 3)

function_declaration        = /function\s(#{var_name})\s?#{function_params_declaration}\s?{?/   # function multiply(x, y) {
function_call               = /(#{var_name})\s?#{function_params_call}/                         # multiply(1, 2)

binary_operator       = /==|>=|<=|>|<|\/|\*|\+|-/                                             # <
unary_operator        = /(\+)\+|(-)-/                                                             # ++|--
binary_expression     = /(#{value}\s?#{binary_operator}\s?#{value})/                          # f < g | f * 1
unary_expression      = /(#{var_name})#{unary_operator}/                                      # f++ | f--
expression            = /#{binary_expression}|#{unary_expression}|#{function_call}|#{value}/  # f < g | multiply(1, 2) | f++ | 1
attribution           = /#{var_declaration}\s?=\s?(#{expression});?/                          # xtpo = h <= i

function_return       = /return\s(#{expression});?/                                             # return x * y;
conditional           = /if\s\((#{attribution}|#{expression})\)\s?{?/                           # if (x < 0) {
else_conditional      = /} else if\s\((#{attribution}|#{expression})\)\s?{?/                           # if (x < 0) {
for_loop              = /for\s?\(#{attribution};\s?#{expression};\s?#{unary_expression}\)\s?{?/ # for (x = 0, x <= 10, x++)
while_loop            = /while\s?\(#{expression}\)\s?{?/                                        # while (x <= 10)


block_begin           = /{/
block_end             = /}/


source_code = '
  var xpto = 123;

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
  } else if (xpto <= 0){
    x--;
  }

  for (x = 0; x <= results; x++){
    x++;
  }

  while (x <= 10){
    x++;
  }
'

output = ""


source_code.each_line do |line|
  if match = line.match(for_loop)
    var_range = match.captures[7].split(' ').last
    var_unit = match.captures[12]

    output << "for #{var_unit} in #{var_range}\n"
  elsif match = line.match(while_loop)
    condition = match.captures.first

    output << "while #{condition} do\n"
  elsif match = line.match(attribution)
    var_name, value = match.captures
    output << "#{var_name} = #{value}\n"

  elsif match = line.match(function_declaration)
    function_name, function_params = match.captures
    output << "def #{function_name} (#{function_params})\n"

  elsif match = line.match(function_return)
    return_expression = match.captures.first
    output << "#{return_expression}\n"

  elsif match = line.match(else_conditional)
    condition = match.captures.first
    output << "elsif #{condition} do\n"

  elsif match = line.match(block_end)
    output << "end\n"

  elsif match = line.match(conditional)
    condition = match.captures.first
    output << "if #{condition} do\n"

  elsif match = line.match(unary_expression)
    var_name = match.captures.first
    operator = match.captures[1] || match.captures[2]
    output << "#{var_name} #{operator}= 1\n"

  end
end


puts output
