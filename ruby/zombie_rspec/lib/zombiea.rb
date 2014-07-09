class Zombie
  attr_accessor :name, :brains, :alive

  def initialize
    @name = 'Ash'
    @brains = 0
    @alive = false
  end

  def alive?
    @alive
  end
end
