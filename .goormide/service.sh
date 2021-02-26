#!/bin/bash

###########################################################
###		This is a services script		###
###########################################################

#v2ray server service
v2rayServer() {
  PID=`ps aux |grep "v2ray"| awk '{print $2}'`
  if [[ $PID != ""  ]]
  then
    kill -9 $PID > /dev/null 2>&1
    sleep 1
  fi
  nohup  /usr/bin/v2ray/v2ray -config /etc/v2ray/config.json  >/dev/null 2>&1 &
  echo v2ray启动
}

agentServer() {
  PID=`ps aux |grep "agent"| awk '{print $2}'`
  if [[ $PID != ""  ]]
  then
    kill -9 $PID > /dev/null 2>&1
    sleep 1
  fi
  cd /workspace/*
  if [[ -e addr.txt ]]
  then
    read -p "面板地址已保存，是否重新输入:" confirm

    if [[ x$confirm == x || $confirm == "y" || $confirm == "Y" ]]
    then
      read -p "输入面板地址:" addr
      echo $addr > addr.txt
    fi
  else
    read -p "输入面板地址:" addr
    echo $addr > addr.txt
  fi
  nohup ./agent -d -s $(cat addr.txt) -p $(cat secret.txt) >/dev/null 2>&1 &
  echo agent启动
}

v2rayServer
agentServer
