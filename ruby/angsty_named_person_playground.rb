require_relative 'angsty_named_person'

eduardo = AngstyNamedPerson.new('Eduardo', 23)

eduardo.transactionally do |obj| #will not change any properties
  obj.age = 20
  obj.name = 'Sparkles'
end

puts 'Not changed: '
puts eduardo.name
puts eduardo.age

eduardo.transactionally do |obj| #will change all properties
  obj.age = 21
  obj.name = 'Matheus'
end

puts 'Changed: '
puts eduardo.name
puts eduardo.age
