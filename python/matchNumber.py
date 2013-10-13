
#_*_ encoding: utf-8 _*_

import random 
numero = random.randint (1, 100)

tentativas = 0
escolha = 0

while numero != escolha:
  escolha = input("Informe um número entre 1 e 100: ")
  tentativas += 1
  if escolha > numero:
    print "Maior"
  elif escolha < numero:
    print "Menor"

print "Acertou. O número sorteado era " , numero
print "Você usou ", tentativas, "tentativas"
