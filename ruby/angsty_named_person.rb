class AngstyNamedPerson
  attr_reader :name
  attr_accessor :age

  @@hated_names = %w(Leroy Sparkles Thaddius)
  @@hated_ages = [20, 30, 40, 50]

  def name=(new_name)
    @name = new_name
    raise "I have problems with being named #{@name}." if @@hated_names.include?(new_name)
  end

  def age=(new_age)
    @age = new_age
    raise "I heve problems with being at age #{@age}." if @@hated_ages.include?(new_age)
  end

  def initialize(name, age)
    @name = name
    @age = age
  end

  def transactionally(&block)
    old_name = @name
    old_age = @age

    begin
      yield self if block_given?
    rescue => e
      puts e
      @name = old_name
      @age = old_age
    end
  end
end
