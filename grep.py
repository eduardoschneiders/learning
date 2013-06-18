#!/usr/bin/env python
# _*_ encoding: utf-8 _*
#usage ./grep.py 'linha' arq.txt /etc/passwd teste.txt_

import sys
#print sys.argv

search = sys.argv[1]
filenames = sys.argv[2:]

for filename in filenames:
  f = open(filename)
  for line in f:
    if search in line:
      print "%s: %s" % (filename, line.strip())
  f.close
