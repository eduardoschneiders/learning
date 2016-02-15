#!/usr/bin/python
import sys
from hashlib import md5

if len(sys.argv) < 3:
   exit(1)

trans_5C = ''.join(chr(x ^ 0x5c) for x in xrange(256))
trans_36 = ''.join(chr(x ^ 0x36) for x in xrange(256))
blocksize = md5().block_size

def hmac_md5(key, message):
    if len(key) > blocksize:
        key = md5(key).digest()
    else:
        key += chr(0) * (blocksize - len(key))
    o_key_pad = key.translate(trans_5C)
    i_key_pad = key.translate(trans_36)

    return md5(o_key_pad + md5(i_key_pad + message).digest())

key = sys.argv[1]
message = sys.argv[2]

hash = hmac_md5(key, message)
print hash.hexdigest()
