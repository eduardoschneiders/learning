#!/usr/bin/env python
# _*_ encoding: utf-8 _*_

import pprint

notas = {
  "Graham Chapmam": 5.5,
  "Jhon Cleese": 7.0,
  "Terry Gilliam": 4.5,
  "Terry Jone": 4.5,
  "Eruc Idle": 10,
  "Michael Palin": 3.5,
}

print "Conteúdo do dicionário:"
#pprint.pprint(notas)

print "%-20s-+-%-7s" % ("-" * 20, "-" * 7)
print "%-20s | %-7s" % ("Nome", "Nota")
print "%-20s-+-%-7s" % ("-" * 20, "-" * 7)

soma = 0
cont = 0

for nome in sorted(notas):
  print "%-20s | %4.1f" % (nome, notas[nome])
  soma += notas[nome]
  cont += 1

print "%-20s-+-%-7s" % ("-" * 20, "-" * 7)
print "%-20s | %4.1f" % ("Média", soma / cont)
