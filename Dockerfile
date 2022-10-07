# OS
FROM ubuntu:latest
# Set version label
LABEL maintainer="github.com/Dofamin"
LABEL image="MTProxy"
LABEL OS="Ubuntu/latest"
COPY container-image-root/ /
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
    apt -y install git curl build-essential libssl-dev zlib1g-dev cron wget logrotate ntp > /dev/null 2>&1;\
    apt install -y gcc-9 g++-9 cpp-9 > /dev/null 2>&1;\
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 100 --slave /usr/bin/g++ g++ /usr/bin/g++-9 --slave /usr/bin/gcov gcov /usr/bin/gcov-9 > /dev/null 2>&1;\
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
    (crontab -l 2>/dev/null; echo "@daily curl -s https://core.telegram.org/getProxySecret -o /srv/MTProxy/objs/bin/proxy-secret >> /var/log/cron.log 2>&1") | crontab - ;\
    (crontab -l 2>/dev/null; echo "@daily curl -s https://core.telegram.org/getProxyConfig -o /srv/MTProxy/objs/bin/proxy-multi.conf >> /var/log/cron.log 2>&1") | crontab - ;\
    (crontab -l 2>/dev/null; echo '@daily wget --output-document="/MTProxy/Stats/$(date +%d.%m.%y).log" localhost:8888/stats  >> /var/log/cron.log 2>&1') | crontab - ;\
    (crontab -l 2>/dev/null; echo '0 4 * * *  pkill -f mtproto-proxy  >> /var/log/cron.log 2>&1') | crontab - ;\
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
HEALTHCHECK --interval=60s --timeout=30s --start-period=10s CMD curl -f http://localhost:8888/stats || exit 1
# Expose Ports:
EXPOSE 8889/tcp 8889/udp
# ENTRYPOINT
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]