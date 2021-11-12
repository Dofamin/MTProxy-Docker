#!/bin/bash
git clone https://github.com/Dofamin/MTProxy-Docker.git /srv/MTProxy/

docker build /srv/MTProxy/ --tag mtproxy 

docker rm --force MTProxy

docker create \
  --name=MTProxy \
  -p 443:443/tcp \
  -p 443:443/udp \
  -v /srv/MTProxy/container-image-root/Stats/:/MTProxy/Stats/\
  -v /srv/MTProxy/container-image-root/logrotate/:/etc/logrotate.d/\
  --privileged \
  --restart unless-stopped \
  mtproxy:latest

docker start MTProxy
