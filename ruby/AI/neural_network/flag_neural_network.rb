require 'cerebrum'

lines = File.open('flag.data', 'r') { |f| f.read }.split("\n").take(10)
data = lines.each_with_index.map do |e, i|
  result = e.split(',')[10..16].map(&:to_i)
  x = lines.size.times.map { |iz| iz == i ? 1 : 0 }
  { input: result, output: x}
end

network = Cerebrum.new
network.train(data)

countries_to_find = {
  'Algeria' => [1,1,0,0,1,0,0],
  'Andorra' => [1,0,1,1,0,0,0],
}

countries_to_find.each do |country, color_params|
  ret = network.run(color_params).map(&:round)
  index = ret.index(1)
  country_name = lines[index].split(',')[0]
  p "Trying to find name for #{country}; Found #{country_name}"
end
