class Name
  def initialize(first, last = nil)
    @first = first
    @last = last
  end
  def format
    [@last, @first].compact.join(', ')
  end
end

user_names = []
user_names << Name.new('Eduardo', 'Schneiders')
user_names << Name.new('Name', 'LastName')
user_names << Name.new('First')

user_names.each {|n| puts n.format}

puts '-------------------'
def params(param1, *param2)
  puts "#{param2.join(', ')}, #{param1}"
end

params('Eduardo', 'a', 'b', 'c', 'd')

puts '-------------------'

def hash_params(name, options = {})
  puts name
  puts options[:last_name]
  puts options[:age]
  puts options[:location]
end

hash_params('Eduardo',
            :last_name => 'Schneiders',
            :age => 23,
            :location => 'POA'
           )
