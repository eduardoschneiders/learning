

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
