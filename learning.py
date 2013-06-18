d = dict(chave1 = 'valor1', chave2 = 'chave2')
d.update({'chave1': "VALOR1", "chave3": "balblabl"})
print d

poped = d.pop("chave1")
print poped


exit()

d = dict(chave1 = 'valor1', chave2 = 'chave2')
print d.get('chave1')
print d.get('chave3', 'Default')
print d.keys()
print d.values()

for chave in sorted(d.keys()):
  print chave, d[chave]
exit()


d = dict(chave1 = 'valor1', chave2 = 'chave2')
for chave in d:
  print chave, d[chave]

print d.items()

for chave, valor in d.items():
  print chave, valor

exit()

d = {'nome': 'fulano', 'email': 'fulando@asdfhasd'}
print d['nome']
print d['email']

d[5] = "valor 5"
print d

class Pessoa:
  pass

p = Pessoa()

d[p] = "Pessoa 1"
print d
d['lista'] = [1, 2, 3]

d = dict(chave1 = 'valor1', chave2 = 'chave2')
print "novo dict:"
print d

exit()

t = (1, 2, 3, 4)
t = 1, 2, 3, 4

a = 3
b = 2

a, b = b, a

print a, b

def f(): return 4, 5

a, b = f()

print a, b

exit()

b = [1, 3, 4, 7, 1]
lista = list(reversed(b))
print lista

exit()

b = list("Spam")
b.append("eggs")
b.insert(0, "Ham")


print b

poped = b.pop()
print poped
print b


b.reverse()
print "reversed"
print b

sorteado = sorted(b)
print "sorted"
print sorteado

exit()


a = [0, 1, 2, 3, 4]
print a

b = list("spam")
print b

b[0] = "S"
print b

c = b + ['ham']
print c

b += ["foo"]
print b

b += "bar"
print b

b.extend("baz")
print b

b.extend(["baz"])
print b

exit()

a = [("key1", "value1"),("key2", "value2"),("key3", "value3")]
print a

for key, value in a:
  print "key: ", key, "value: ", value

print range(10)
print range(4, 10)
print range(4, 10, 2)

for i in range(10):
  print i

exit()


a = 0 

while a < 10:
  print a
  a += 1
  #if a > 3:
   #print "interrompido"
   #break
else:
  print "fim."
