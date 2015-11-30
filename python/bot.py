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

logging.basicConfig(filename='details.log',level=logging.WARNING)

def main():
  update_id = None

  try:
    os.environ['TELEGRAM_TOKEN']
  except:
    print 'You need the TELEGRAM_TOKEN variable'
    exit(1)

  bot = telegram.Bot(os.environ['TELEGRAM_TOKEN'])

  print 'Bot Telegram iniciado...'

  while True:
    try:
      update_id = checkMessages(bot, update_id)
    except telegram.TelegramError as e:
      if e.message in ("Bad Gateway", "Timed out"):
        sleep(1)
      else:
        raise e
    except URLError as e:
      sleep(1)


def checkMessages(bot, update_id):
# {
#   'message': {
#     'from': {
#       'first_name': u'Eduardo', 
#       'last_name': u'Schneiders', 
#       'id': 63458157
#     }, 
#     'text': u'testjng blaba', 
#     'chat': {
#       'first_name': u'Eduardo', 
#       'last_name': u'Schneiders', 
#       'type': u'private', 
#       'id': 63458157
#     }, 
#     'date': 1448645666, 
#     'message_id': 29
#   }, 
#   'update_id': 64440194
# }

    for update in bot.getUpdates(offset=update_id, timeout=10):
        chat_id = update.message.chat_id
        update_id = update.update_id + 1

        # Captura a mensagem de texto enviada ao bot no dado chat_id
        message = update.message.text
        logging.warning("Message: " + message)

        if message:
          responseMessage = "Did you sad '" + message + "' ?"

          messageParams = message.split(' ')
          command       = messageParams[0]
          path          = ' '.join(messageParams[1:])
          print "Command: " + command + " " + path

          if command == 'ls':
            responseMessage = "\n".join(os.listdir(path))
            bot.sendMessage(chat_id=chat_id, text=responseMessage)
            bot.sendPhoto(chat_id=chat_id, photo=open('IntelEdisonEmbedded.png', 'rb'))

          elif command == 'background':
            pictures = os.listdir('/usr/share/backgrounds/')
            randomInt = random.randint(0, len(pictures) - 1)
            newPic = pictures[randomInt]
            os.system("gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/" + newPic)
            bot.sendPhoto(chat_id=chat_id, photo=open("/usr/share/backgrounds/" + newPic))

    return update_id

if __name__ == '__main__':
  main()
