<<<<<<< HEAD
import sys
print sys.maxint


exit()

exec "import os; os.system('ls /')"


exit()

exec "a = 1"
print a
exec "a = 2"
print a

exit()

a = {'chave': 'valor', 'spam': 'eggs'}
print a
del a['spam']
print a

exit()

a = [1, 2, 3]
print a
del a[1]
print a

exit()

f = open("/tmp/print", "w")
print >> f, "Dentro do arquivo"
f.close

exit()

print "spam"
print "eggs"
print "foo",
print "bar"

exit()

a = ["spam", "eggs", "foo", "bar", "qoox"]

for i, elemento in enumerate(a):
  print i, elemento

print list(enumerate(a))


exit()
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




--------------------------------------------




Type "help", "copyright", "credits" or "license" for more information.
>>> f = file("arq.txt")
>>> f.readline()
'linha um\n'
>>> f.readline().strip()
'linha dois'
>>> f.readline()
'linha tres\n'
>>> f.readline()
''
>>> f.readline()
''
>>> f.close()
>>> f = open("arq.txt")
>>> f
<open file 'arq.txt', mode 'r' at 0xb72ebf40>
>>> for linha in f
  File "<stdin>", line 1
    for linha in f
                 ^
SyntaxError: invalid syntax
>>> for linha in f:
...   print linha
... 
linha um

linha dois

linha tres

>>> for linha in f:
...   print linha.strip()
... 
>>> f.seek(0)
>>> for linha in f:
...   print linha.strip()
... 
linha um
linha dois
linha tres
>>> f.seek(0)
>>> for linha in f:
...   print linha.strip()
... 
linha um
linha dois
linha tres
>>> f.seek(1)
>>> for linha in f:
...   print linha.strip()
... 
inha um
linha dois
linha tres
>>> f.seek(0)
>>> l = f.readlines()
>>> l
['linha um\n', 'linha dois\n', 'linha tres\n']
>>> for i in l:
...   print i
... 
linha um

linha dois

linha tres

>>> l
['linha um\n', 'linha dois\n', 'linha tres\n']
>>> f.seek(0)
>>> f.read(3)
'lin'
>>> f.read(3)
'ha '
>>> f.read(3)
'um\n'
>>> f.read(3)
'lin'
>>> f.read(3)
'ha '
>>> f.read(3)
'doi'
>>> f.read(3)
's\nl'
>>> f.read(3)
'inh'
>>> f.close
<built-in method close of file object at 0xb72ebf40>
>>> f = open("arq.txt", "w")
>>> f.close()
>>> exit()
edu@eduardo-desktop:~/projects/python$ cat arq.txt 
edu@eduardo-desktop:~/projects/python$ python
Python 2.7.3 (default, Aug  1 2012, 05:16:07) 
[GCC 4.6.3] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> f = open("arq.txt", "w")
>>> f.write
<built-in method write of file object at 0xb7285ee8>
>>> f.write("Linha um \n")
>>> f.close
<built-in method close of file object at 0xb7285ee8>
>>> f.close()
>>> exit()
edu@eduardo-desktop:~/projects/python$ cat arq.txt 
Linha um 
edu@eduardo-desktop:~/projects/python$ python
Python 2.7.3 (default, Aug  1 2012, 05:16:07) 
[GCC 4.6.3] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> f.open("arq.txt", "a")
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
NameError: name 'f' is not defined
>>> f = open("arq.txt", "a")
>>> f.close()
>>> exit()
edu@eduardo-desktop:~/projects/python$ cat arq.txt 
Linha um 
edu@eduardo-desktop:~/projects/python$ python 
Python 2.7.3 (default, Aug  1 2012, 05:16:07) 
[GCC 4.6.3] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> f = open("arq.txt", "a")
>>> f.write("Linha dois \n")
>>> f.close
<built-in method close of file object at 0xb728eee8>
>>> f.close()
>>> exit()
edu@eduardo-desktop:~/projects/python$ cat arq.txt 
Linha um 
Linha dois 
edu@eduardo-desktop:~/projects/python$ python
Python 2.7.3 (default, Aug  1 2012, 05:16:07) 
[GCC 4.6.3] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> f = open("arq.txt", "a")
>>> pritn >> f, "Linha três"
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
NameError: name 'pritn' is not defined
>>> pritn >>f, "Linha três"
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
NameError: name 'pritn' is not defined
>>> print >> f, "Linha três"
>>> f.close()
>>> exit()
edu@eduardo-desktop:~/projects/python$ cat arq.txt 
Linha um 
Linha dois 
Linha três
edu@eduardo-desktop:~/projects/python$ python
Python 2.7.3 (default, Aug  1 2012, 05:16:07) 
[GCC 4.6.3] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> f = open("arq.txt", "a")
>>> f.write("Linha quatro\n")
>>> f.flush()
>>> f.close()
>>> f = open("arq.txt", "a")
>>> f = open("arq.txt")
>>> f.tell()
0L
>>> f.read(5)
'Linha'
>>> f.tell()
5L
>>> f.seek(12)
>>> f.tell()
12L
>>> i = iter("spam")
>>> i
<iterator object at 0xb72c220c>
>>> dir(i)
['__class__', '__delattr__', '__doc__', '__format__', '__getattribute__', '__hash__', '__init__', '__iter__', '__length_hint__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', 'next']
>>> i.next()
's'
>>> i.next()
'p'
>>> i.next()
'a'
>>> i.next()
'm'
>>> i.next()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
StopIteration
>>> l = range(10)
>>> l
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
>>> q = [x ** 2 for x in l]
>>> q
[0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
>>> g = (x**2 for x in l)
>>> g
<generator object <genexpr> at 0xb6b8bfa4>
>>> dir(g)
['__class__', '__delattr__', '__doc__', '__format__', '__getattribute__', '__hash__', '__init__', '__iter__', '__name__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', 'close', 'gi_code', 'gi_frame', 'gi_running', 'next', 'send', 'throw']
>>> g.next()
0
>>> g.next()
1
>>> g.next()
4
>>> g.next()
9
>>> g.next()
16
>>> g.next()
25
>>> g.next()
36
>>> g.next()
49
>>> g.next()
64
>>> g.next()
81
>>> g.next()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
StopIteration
>>> abs(-5)
5
>>> abs(5)
5
>>> divmode(3, 2)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
NameError: name 'divmode' is not defined
>>> divmod(3, 2)
(1, 1)
>>> 
>>> 3 / 2, 3 % 2
(1, 1)
>>> round(3.141592, 2)
3.14
>>> print round(3.141592, 2)
3.14
>>> print round(3.141592, 0)
3.0
>>> round(3.141592, 0)
3.0
>>> callable("spam")
False
>>> def f():
...   pass
... callable(f)
  File "<stdin>", line 3
    callable(f)
           ^
SyntaxError: invalid syntax
>>> callable(f)
False
>>> execfile("notas.py")
Conteúdo do dicionário:
---------------------+--------
Nome                 | Nota   
---------------------+--------
Eruc Idle            | 10.0
Graham Chapmam       |  5.5
Jhon Cleese          |  7.0
Michael Palin        |  3.5
Terry Gilliam        |  4.5
Terry Jone           |  4.5
---------------------+--------
Média               |  5.8
>>> hash("spam")
1626740519
>>> a = [1, 2, 3]
>>> b = [1, 2, 3]
>>> a == b
True
>>> id(a)
3065566796L
>>> id(b)
3065566828L
>>> a is b
False
>>> len a
  File "<stdin>", line 1
    len a
        ^
SyntaxError: invalid syntax
>>> len(a)
3
>>> len("spam")
4
>>> raw_input("Nome: ")
Nome: eduardo
'eduardo'
>>> input("Expressão: ")
Expressão: 3 + 4
7
>>> a = 3
>>> b = 5
>>> input("Expressão: ")
Expressão: a + b
8
>>> globals()
{'a': 3, 'b': 5, 'cont': 6, 'notas': {'Terry Gilliam': 4.5, 'Graham Chapmam': 5.5, 'Michael Palin': 3.5, 'Terry Jone': 4.5, 'Eruc Idle': 10, 'Jhon Cleese': 7.0}, 'g': <generator object <genexpr> at 0xb6b8bfa4>, 'f': <open file 'arq.txt', mode 'r' at 0xb7345ee8>, '__builtins__': <module '__builtin__' (built-in)>, 'soma': 35.0, 'pprint': <module 'pprint' from '/usr/lib/python2.7/pprint.pyc'>, 'l': [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], '__package__': None, 'q': [0, 1, 4, 9, 16, 25, 36, 49, 64, 81], 'i': <iterator object at 0xb72c220c>, 'x': 9, '__name__': '__main__', 'nome': 'Terry Jone', '__doc__': None}
>>> locals()
{'a': 3, 'b': 5, 'cont': 6, 'notas': {'Terry Gilliam': 4.5, 'Graham Chapmam': 5.5, 'Michael Palin': 3.5, 'Terry Jone': 4.5, 'Eruc Idle': 10, 'Jhon Cleese': 7.0}, 'g': <generator object <genexpr> at 0xb6b8bfa4>, 'f': <open file 'arq.txt', mode 'r' at 0xb7345ee8>, '__builtins__': <module '__builtin__' (built-in)>, 'soma': 35.0, 'pprint': <module 'pprint' from '/usr/lib/python2.7/pprint.pyc'>, 'l': [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], '__package__': None, 'q': [0, 1, 4, 9, 16, 25, 36, 49, 64, 81], 'i': <iterator object at 0xb72c220c>, 'x': 9, '__name__': '__main__', 'nome': 'Terry Jone', '__doc__': None}
>>> vars()
{'a': 3, 'b': 5, 'cont': 6, 'notas': {'Terry Gilliam': 4.5, 'Graham Chapmam': 5.5, 'Michael Palin': 3.5, 'Terry Jone': 4.5, 'Eruc Idle': 10, 'Jhon Cleese': 7.0}, 'g': <generator object <genexpr> at 0xb6b8bfa4>, 'f': <open file 'arq.txt', mode 'r' at 0xb7345ee8>, '__builtins__': <module '__builtin__' (built-in)>, 'soma': 35.0, 'pprint': <module 'pprint' from '/usr/lib/python2.7/pprint.pyc'>, 'l': [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], '__package__': None, 'q': [0, 1, 4, 9, 16, 25, 36, 49, 64, 81], 'i': <iterator object at 0xb72c220c>, 'x': 9, '__name__': '__main__', 'nome': 'Terry Jone', '__doc__': None}
>>> mas(1, 2,3 )
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
NameError: name 'mas' is not defined
>>> max(1, 2, 3)
3
>>> max([1, 2, 3])
3
>>> max([1, 2, 3])
KeyboardInterrupt
>>> range(10)
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
>>> range(1, 10)
[1, 2, 3, 4, 5, 6, 7, 8, 9]
>>> l = ["spam", "eggs", "ham", "foo", "bar"]
>>> for s in l:
...   print s
... 
spam
eggs
ham
foo
bar
>>> for i, s in enumerate(l):
...   print i, s
... 
0 spam
1 eggs
2 ham
3 foo
4 bar
>>> enumarate(l)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
NameError: name 'enumarate' is not defined
>>> enumarate(l)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
NameError: name 'enumarate' is not defined
>>> enumerate(l)
<enumerate object at 0xb6b8bd74>
>>> dir(enumerate(l))
['__class__', '__delattr__', '__doc__', '__format__', '__getattribute__', '__hash__', '__init__', '__iter__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', 'next']
>>> e = enumerate(l)
>>> e.next
<method-wrapper 'next' of enumerate object at 0xb6b8bd74>
>>> e.next()
(0, 'spam')
>>> e.next()
(1, 'eggs')
>>> e.next()
(2, 'ham')
>>> e.next()
(3, 'foo')
>>> e.next()
(4, 'bar')
>>> e.next()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
StopIteration

