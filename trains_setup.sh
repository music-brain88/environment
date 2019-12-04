#!/bin/bash

set -e

password(){
    if ! ${password+:} false
    then
        printf "password: "
        read -s password
    fi
  }


sudo mkdir -p /opt/trains/data/elastic
sudo mkdir -p /opt/trains/data/mongo/db
sudo mkdir -p /opt/trains/data/mongo/configdb
sudo mkdir -p /opt/trains/logs
sudo mkdir -p /opt/trains/config
sudo mkdir -p /opt/trains/data/fileserver


echo '############展開中############'
sudo tar zxvf data/trains_data.tar.gz -C /
echo '############展開中############'

if [ "$(uname)" == 'Darwin' ]; then
  sudo chown -R $(whoami):staff /opt/trains
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  sudo chown -R 1000:1000 /opt/trains
fi

echo 'setup finish'
