#!/bin/bash

if [ "$2" != "" ]; then
  folder=$2;
else
  folder="./default_folder"
fi

if [ "$1" == "" ]; then
  echo "Usage: ./db_script.sh {dump|restore} folder"
elif [ "$1" == "dump" ]; then
  mkdir $folder
  mongodump --out $folder
else
  collections=($(ls $folder))

  for collection in "${collections[@]}"; do
    mongorestore -d "$collection" "${folder}/$collection" &
  done

  for job in $(jobs -p); do
    wait $job
  done
fi
