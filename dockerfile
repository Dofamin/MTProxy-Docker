# OS
FROM centos/systemd
# Set version label
LABEL maintainer="github.com/Dofamin"
LABEL image=MTProxy
LABEL OS=Centos7
# ARG & ENV
ARG Secret
ENV Secret=${Secret:-ec4dd80983dbf12d6b354cf7bcfe9a48}
ARG Workers
ENV Workers=${Workers:-1}
ADD container-image-root/MTProxy.service /etc/systemd/system/
# Update system packages:
RUN yum -y update > /dev/null 2>&1;\
# Install dependencies, you would need common set of tools for building from source, and development packages for openssl and zlib.
    yum -y install openssl-devel zlib-devel curl cronie wget hostname > /dev/null 2>&1;\
    yum -y groupinstall "Development Tools" > /dev/null 2>&1 ;\
# Clone the repo:
    IP_EXT=$(curl ifconfig.co/ip -s) ;\
    IP_INT=$(hostname --ip-address) ;\
    git clone https://github.com/TelegramMessenger/MTProxy /MTProxy > /dev/null 2>&1 ;\
# To build, simply run make, the binary will be in objs/bin/mtproto-proxy:
    cd /MTProxy ; \
    make > /dev/null 2>&1;\
# Obtain a secret, used to connect to telegram servers.
    curl -s https://core.telegram.org/getProxySecret -o /MTProxy/objs/bin/proxy-secret > /dev/null 2>&1 ;\
    (crontab -l 2>/dev/null; echo "@daily curl -s https://core.telegram.org/getProxySecret -o /MTProxy/objs/bin/proxy-secret && systemctl restart MTProxy.service >> /var/log/cron.log 2>&1") | crontab - ;\
# Obtain current telegram configuration. It can change (occasionally), so we encourage you to update it once per day.
    (crontab -l 2>/dev/null; echo "@daily curl -s https://core.telegram.org/getProxyConfig -o /MTProxy/objs/bin/proxy-multi.conf && systemctl restart MTProxy.service >> /var/log/cron.log 2>&1") | crontab - ;\
    curl -s https://core.telegram.org/getProxyConfig -o /MTProxy/objs/bin/proxy-multi.conf > /dev/null 2>&1 ;\
# Systemd service
    sed -i "8 i ExecStart=/MTProxy/objs/bin/mtproto-proxy -u nobody -p 8888 -H 443 -S $Secret --aes-pwd proxy-secret proxy-multi.conf -M $Workers --nat-info $IP_INT:$IP_EXT --http-stats" /etc/systemd/system/MTProxy.service ;\
    systemctl enable MTProxy.service > /dev/null 2>&1 ;\
    systemctl enable crond > /dev/null 2>&1 ;\
# Clean up
    yum -y groupremove "Development Tools" > /dev/null 2>&1 ;\
    yum -y autoremove > /dev/null 2>&1 ;\
    yum -y remove openssl-devel zlib-devel > /dev/null 2>&1;\
    yum clean all > /dev/null 2>&1;\
    rm -rf /var/cache/yum > /dev/null 2>&1 ;\
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
# Expose Ports:
EXPOSE 443/tcp 443/udp
# CMD
CMD ["/usr/sbin/init"]