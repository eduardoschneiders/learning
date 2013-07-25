#!/usr/bin/env python
# -*- encoding: utf-8 -*-

import time

def fib(n):
  if n < 2: return 1
  return fib(n-1) + fib(n-2)

def memoize(fn):
  memo = {}
  def memoizer(*param1):
    key = repr(param1)
    if not key in memo:
      memo[key] = fn(*param1)
    return memo[key]
  return memoizer

t1 = time.time()
for i in range(40):
  print "fib(%s) -> %s" % (i, fib(i))
t2 = time.time()
print "Tempo de execução: %.3fs" % (t2-t1,)



fib = memoize(fib)

t1 = time.time()
for i in range(35):
  print "fib(%s) -> %s" % (i, fib(i))
t2 = time.time()
print "Tempo de execução: %.3fs" % (t2-t1,)

