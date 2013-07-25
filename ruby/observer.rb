module Observable

  attr_accessor :state

  def attachObserver(o)
    @observers ||= []
    @observers << o if !@observers.include?(o)
  end

  def removeObserver(o)
    @observers.delete(o)
  end

  def state=(s)
    @state = s
    @observers.each do |o|
      o.update(self)
    end
  end
end

module Observer
  def update(o)
    raise "Implement this"
  end
end

class QueenAnt
  include Observable
end

class WorkAnt
  include Observer

  def update(o)
    p "I am working hard. Queen has changed state to #{o.state}"
  end
end

queen = QueenAnt.new

worker1 = WorkAnt.new
worker2 = WorkAnt.new
worker3 = WorkAnt.new

queen.attachObserver(worker1)
queen.attachObserver(worker2)

queen.state = 'sleeping'


class SoldierAnt
  include Observer
  
  def update(o)
    p "Reporting for duty! Queen has changed state to #{o.state}!"
  end
end

class BreederAnt
  include Observer
  def update(o)
    p "Need to look for a mate. Queen has changed state to #{o.state}!"
  end
end

queen = QueenAnt.new
soldier = SoldierAnt.new
breeder = BreederAnt.new

queen.attachObserver(soldier)
queen.attachObserver(breeder)

queen.state = 'sleeping'
