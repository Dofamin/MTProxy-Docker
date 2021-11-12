# OS
FROM ubuntu:latest
# Set version label
LABEL maintainer="github.com/Dofamin"
LABEL image="MTProxy"
LABEL OS="Ubuntu/latest"
# ARG & ENV
ARG Secret
ENV Secret=${Secret:-ec4dd80983dbf12d6b354cf7bcfe9a48}
ARG Workers
ENV Workers=${Workers:-1}
WORKDIR /srv/
ENV TZ=Europe/Moscow
# Update system packages:
RUN apt -y update > /dev/null 2>&1;\
# Fix for select tzdata region
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone > /dev/null 2>&1;\
    dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1;\
# Install dependencies, you would need common set of tools.
    apt -y install git curl build-essential libssl-dev zlib1g-dev cron wget logrotate > /dev/null 2>&1;\
# Clone the repo:
    IP_EXT=$(curl ifconfig.co/ip -s) ;\
    IP_INT=$(hostname --ip-address) ;\
    git clone https://github.com/TelegramMessenger/MTProxy /srv/MTProxy > /dev/null 2>&1 ;\
# To build, simply run make, the binary will be in objs/bin/mtproto-proxy:
    cd /srv/MTProxy ; \
    make > /dev/null 2>&1;\    
# Obtain a secret, used to connect to telegram servers.
    curl -s https://core.telegram.org/getProxySecret -o /srv/MTProxy/objs/bin/proxy-secret > /dev/null 2>&1 ;\
    curl -s https://core.telegram.org/getProxyConfig -o /srv/MTProxy/objs/bin/proxy-multi.conf > /dev/null 2>&1 ;\
# Obtain current telegram configuration. It can change (occasionally), so we encourage you to update it once per day.
    (crontab -l 2>/dev/null; echo "@daily curl -s https://core.telegram.org/getProxySecret -o /srv/MTProxy/objs/bin/proxy-secret && systemctl restart MTProxy.service >> /var/log/cron.log 2>&1") | crontab - ;\
    (crontab -l 2>/dev/null; echo "@daily curl -s https://core.telegram.org/getProxyConfig -o /srv/MTProxy/objs/bin/proxy-multi.conf && systemctl restart MTProxy.service >> /var/log/cron.log 2>&1") | crontab - ;\
    (crontab -l 2>/dev/null; echo '@daily wget --output-document="/MTProxy/Stats/$(date +%d.%m.%y).log" localhost:8888/stats  >> /var/log/cron.log 2>&1') | crontab - ;\
# Cleanup
    apt-get clean > /dev/null 2>&1;\
    # Info message for the build
    echo -e "\e[1;31m \n\
    ███╗   ███╗████████╗██████╗ ██████╗  ██████╗ ██╗  ██╗██╗   ██╗ \n\
    ████╗ ████║╚══██╔══╝██╔══██╗██╔══██╗██╔═══██╗╚██╗██╔╝╚██╗ ██╔╝ \n\
    ██╔████╔██║   ██║   ██████╔╝██████╔╝██║   ██║ ╚███╔╝  ╚████╔╝ \n\
    ██║╚██╔╝██║   ██║   ██╔═══╝ ██╔══██╗██║   ██║ ██╔██╗   ╚██╔╝  \n\
    ██║ ╚═╝ ██║   ██║   ██║     ██║  ██║╚██████╔╝██╔╝ ██╗   ██║   \n\
    ╚═╝     ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝ \e[0m \n\
    All is setup and done! \n\
    For access MTProxy use this link: \n\
    \e[1;33mhttps://t.me/proxy?server=$IP_EXT&port=443&secret=$Secret\e[0m"
# Change WORKDIR    
WORKDIR /srv/MTProxy/objs/bin/
# HEALTHCHECK
#HEALTHCHECK --interval=60s --timeout=30s --start-period=300s CMD node extra/healthcheck.js
# Expose Ports:
EXPOSE 8889/tcp 8889/udp
# CMD
CMD ["/bin/bash" , "-c" , "./mtproto-proxy -u nobody -p 8888 -H 8889 -S $Secret --aes-pwd proxy-secret proxy-multi.conf -M $Workers --nat-info $(hostname --ip-address):$(curl ifconfig.co/ip -s) --http-stats"]
