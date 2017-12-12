#!/usr/bin/env ruby
require 'net/http'
require 'json'

city_map = {
  :A => 'Aracajú',
  :B => 'Belém',
  :C => 'Belo Horizonte',
  :D => 'Boa Vista - Roraima',
  :E => 'Brasília',
  :F => 'Campo Grande, MS',
  :G => 'Cuiabá - Mato Grosso',
  :H => 'Curitiba',
  :I => 'Florianópolis',
  :J => 'Fortaleza',
  :K => 'Goiânia',
  :L => 'João Pessoa',
  :M => 'Maceió',
  :N => 'Manaus',
  :O => 'Natal, RN',
  :P => 'Palmas',
  :Q => 'Porto Alegre, RS',
  :R => 'Porto Velho',
  :S => 'Recife',
  :T => 'Rio Branco, Acre, Brasil',
  :U => 'Rio de Janeiro',
  :V => 'Salvador - BA',
  :W => 'São Luis',
  :X => 'São Paulo',
}

def distances(origin, destinations)
  uri = URI(URI.escape("http://maps.googleapis.com/maps/api/distancematrix/json?origins=#{origin}&destinations=#{destinations.join('|')}"))
  response = JSON.parse Net::HTTP.get(uri)
  begin
    response['rows'].first['elements'].map { |e| e['distance']['value'] }
  rescue
    require 'pry'; binding.pry
  end
end


# original_cities = {}
# city_map.each do |key, city|
#   p city
#   distances = distances(city, city_map.map { |_, c| c.gsub(' ', '+') })
#   sleep(10)
#   original_cities[key] = city_map.each_with_index.map { |e, i| [e.first, distances[i]]}.to_h
# end
original_cities = File.open('distances.json', 'r') { |f| JSON.parse f.read }



start_city_name = 'D'

def measure_distance(city, original_cities)
  prev = city.shift
  city.inject(0) do |total, current|
    distance = original_cities[prev][current]
    prev = current
    total + distance
  end
end

def mutate(gens)
  (gens.size/2).times.map do
    first_gen = gens.shift
    second_gen = gens.shift

    range = first_gen.first.size
    start = Random.rand(range)
    finish = Random.rand(range - start)

    (start..start+finish).each do |i|
      temp = first_gen[0][i]

      first_gen[i] = second_gen[i]
      # second_gen[i] = temp.to_sym
      second_gen[i] = temp
    end

    [first_gen, second_gen]
  end.flatten(1)
end

available_cities = original_cities.dup
start_city = available_cities.delete(start_city_name)

samples = 1000
ages = 100
to_mutate = 900
to_sort = 100

##Geração dos arrays
gens = samples.times.map do
  all_cities = available_cities.dup
  gem = []

  while(all_cities.size != 0)
    n = Random.rand all_cities.size
    city_key = all_cities.keys[n]
    all_cities.delete(city_key)
    gem << city_key
  end

  gem.unshift(start_city_name) << start_city_name
end

##ERAS
all = ages.times.map do
  sorted = gens.sort_by { |gen| measure_distance(gen.dup, original_cities) }
  best_mutated = mutate(sorted.dup.take(to_mutate))
  gens = sorted.take(to_sort) + best_mutated
  gens
end
b = all.flatten(1).sort_by{ |gen| measure_distance(gen.dup, original_cities) }.first
p measure_distance(b.dup, original_cities)
p b.inspect

p '--------'
p measure_distance(gens.first.dup, original_cities)
p gens.first.inspect

best_gen = gens.first
p measure_distance(best_gen.dup, original_cities)
cities = best_gen.map { |l| city_map[l.to_sym].gsub(' ', '+') }
start_city = cities.shift
finish_city = cities.pop
waypoints = cities.join('|')
url =  "'https://www.google.com/maps/dir/?api=1&origin=#{start_city}&destination=#{finish_city}&waypoints=#{waypoints}'"
system "firefox #{url}"
p best_gen.inspect
