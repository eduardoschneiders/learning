#!/usr/bin/env python
# _*_ encoding: utf-8 _*
#usage ./grep.py 'linha' arq.txt /etc/passwd teste.txt_

import sys
#print sys.argv
FOUND = 0
NOT_FOUND = 1
ERROR = 2

def find(search, filename):

  f = open(filename)
  for line in f:
    if search in line:
      yield line.strip()  
  f.close

def main(args):
  try:
    search = args[1]
  except IndexError:
    print >> sys.stderr, "Usage: grep [OPTION]...PATTERN [FILE]..."
    return ERROR

  filenames = args[2:]

  ret = NOT_FOUND
  for filename in filenames:
    try:
      for line in find(search, filename):
        print "%s:%s" % (filename, line)
        ret = FOUND
    except IOError, ex:
      print >>sys.stderr, "grep.py: %s: %s" % (ex.filename, ex.strerror)

  return ret

args = sys.argv
ret = main(args)
sys.exit(ret)
