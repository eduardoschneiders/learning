#!/usr/bin/env ruby

original_cities = {
  A: { B: 1641, C: 1248, D: 3022 },
  B: { A: 2079, C: 2111, D: 1432 },
  C: { A: 1578, B: 2824, D: 3117 },
  D: { A: 6000, B: 6083, C: 4736 }
}

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
      second_gen[i] = temp.to_sym
    end

    [first_gen, second_gen]
  end.flatten(1)
end

available_cities = original_cities.dup
start_city = available_cities.delete(:A)

gens = 10.times.map do
  all_cities = available_cities.dup
  gem = []

  while(all_cities.size != 0)
    n = Random.rand all_cities.size
    city_key = all_cities.keys[n]
    all_cities.delete(city_key)
    gem << city_key
  end

  gem.unshift(:A) << :A
end


10.times.each do
  best = gens.sort_by { |gen| measure_distance(gen.dup, original_cities) }.take(6)
  best_mutated = mutate(best.dup)
  gens = best_mutated + gens.take(4)
end

best_gen = gens.first
require 'pry'; binding.pry
