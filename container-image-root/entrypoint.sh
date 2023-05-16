#!/bin/bash
set -x

service ntp start
cron

if [ "$1" == "" ];
then
./mtproto-proxy -u nobody -p 8888 -H 8889 -S $SECRET --aes-pwd proxy-secret proxy-multi.conf -M $WORKERS --nat-info $(hostname --ip-address):$(curl ifconfig.co/ip -s) --http-stats
else
exec "$1"
fi
