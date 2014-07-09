require 'spec_helper'

describe Zombie do
  it 'is named Ash' do
    zombie = Zombie.new
    expect(zombie.name).to eql 'Ash'
  end

  it 'has no brains' do
    zombie = Zombie.new
    expect(zombie.brains).to be < 1
  end

  it 'is not alive' do
    zombie = Zombie.new
    expect(zombie).not_to be_alive
  end
end
