class Array
  def total
    pos = total = 0
    while pos < self.length do
      valor = yield(self[pos])
      if valor <= 1000
        total += valor
      end
      pos += 1
    end
    total
  end
end

total = [5, 15, 20, 1001].total do |numero|
  if numero > 10
    numero * 2
  else
    numero
  end
end

puts total

total = [5, 15, 20].total do |numero|
  if numero > 40
    numero * 2
  else
    numero
  end
end

puts total

class Banco
  def initialize(contas)
    @contas = contas
  end

  def status
    saldo = 0

    for conta in @contas
      saldo += conta

      yield saldo if block_given?
    end

    saldo
  end
end

banco = Banco.new([100, 200, 300])
banco.status do |saldo_parcial|
  puts "Parcial: #{saldo_parcial}"
end

puts "Total: #{banco.status}"
