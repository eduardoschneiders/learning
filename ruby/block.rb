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
