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
