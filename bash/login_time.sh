#!/bin/sh
# A simple bash script to parse auth file and check login time

LANG=en_US
TODAY=$(date +"%b %_d")
FILE=/tmp/auth.log
# sudo cat /var/log/auth.log.1 /var/log/auth.log > $FILE
sudo cat /var/log/auth.log > $FILE
USER=$(whoami)
RESULT=$(grep -E "$TODAY.*adclient.*INFO.*PAM authentication granted.*$USER" $FILE| grep -v 'COMMAND' | grep -v 'sudo')

# while read line; do
#   echo $line | awk '{print $3;}'
# done <<< "$RESULT"

# echo $RESULT
IFS=$'\n' read -rd '' -a lines <<< "$RESULT"
hour=$(echo ${lines[0]} | awk '{print $3;}')
add=$(echo 8 0.5 | awk '{print ($1 + 1.0 + $2)*60 }')
finishtime=$(date -d "$hour $add minutes" +'%H:%M')

printf "\nFinish time: $finishtime!\n"

