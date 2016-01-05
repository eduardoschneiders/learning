#!/bin/bash
# A simple bash script to parse auth file and check login time

LANG=en_US
TODAY=$(date +"%b %_d")
FILE='/var/log/auth.log'
USER=$(whoami)

RESULT=$(sudo grep -E "$TODAY.*adclient.*INFO.*PAM authentication granted.*$USER" $FILE | grep -v 'COMMAND' | grep -v 'sudo')

while read line; do
  echo $line | awk '{print $3;}'
done <<< "$RESULT"

IFS=$'\n' read -rd '' -a lines <<< "$RESULT"
hour=$(echo ${lines[0]} | awk '{print $3;}')
add=$(echo 8 0.5 | awk '{print ($1 + 1 + $2)*60 }')
finishtime=$(date -d "$hour $add minutes" +'%H:%M')

printf "\nFinish time: $finishtime!\n"

