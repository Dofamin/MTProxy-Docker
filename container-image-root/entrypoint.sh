#!/bin/bash
set -x

service ntp start
cron

if [ "$1" == "" ];
then
./mtproto-proxy -u nobody -p 8888 -H 8889 -S $Secret --aes-pwd proxy-secret proxy-multi.conf -M $Workers --nat-info $(hostname --ip-address):$(curl ifconfig.co/ip -s) --http-stats
else
exec "$1"
fi
