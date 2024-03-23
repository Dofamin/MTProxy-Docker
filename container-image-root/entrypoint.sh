#!/bin/bash
set -x

[ "$IP" == "" ] && IP=$(curl ifconfig.co/ip -s)

service ntp start
cron

if [ "$1" == "" ];
then
./mtproto-proxy -u nobody -p 8888 -H 8889 -S $SECRET --aes-pwd proxy-secret proxy-multi.conf -M $WORKERS --nat-info $(hostname --ip-address):$IP --http-stats
else
exec "$1"
fi
