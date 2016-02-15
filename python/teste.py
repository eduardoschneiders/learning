#!/usr/bin/env python
# -*- encoding: utf-8 -*-

import os
import logging
import random
import telegram
from time import sleep


try:
  from urllib.error import URLError
except ImportError:
  from urllib2 import URLError

logfile = os.path.dirname(os.path.abspath(__file__)) + '/details.log'
logging.basicConfig(filename=logfile,level=logging.DEBUG)

def main():
  update_id = None
  logging.info('before')
  logging.info('92767084:AAEki33XqyRvGfIUPuX5xsQdh3hFaUz5_pQ')

  # try:
  #   os.environ['TELEGRAM_TOKEN']
  # except:
  #   print 'You need the TELEGRAM_TOKEN variable'
  #   exit(1)

  bot = telegram.Bot('92767084:AAEki33XqyRvGfIUPuX5xsQdh3hFaUz5_pQ')

  print 'Bot Telegram iniciado...'

  # logging.info('asdf')
  bot.sendMessage(chat_id='63458157', text='End time')
  bot.sendMessage(chat_id='63458157', text='/command')

if __name__ == '__main__':
  main()
