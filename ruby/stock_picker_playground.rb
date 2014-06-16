require_relative'stock_picker'

better_days = stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])

puts "Better day to buy: #{better_days.first}"
puts "Better day to sell: #{better_days.last}"
