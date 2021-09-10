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
# Update system packages:
RUN yum -y update > /dev/null 2>&1;\
# Install dependencies, you would need common set of tools for building from source, and development packages for openssl and zlib.
    yum -y install openssl-devel zlib-devel curl cronie wget hostname logrotate > /dev/null 2>&1;\
    yum -y groupinstall "Development Tools" > /dev/null 2>&1 ;\
# Clone the repo:
    IP_EXT=$(curl ifconfig.co/ip -s) ;\
    IP_INT=$(hostname --ip-address) ;\
    git clone https://github.com/TelegramMessenger/MTProxy /MTProxy > /dev/null 2>&1 ;\
# To build, simply run make, the binary will be in objs/bin/mtproto-proxy:
    cd /MTProxy ; \
    make > /dev/null 2>&1;\
# Obtain a secret, used to connect to telegram servers.
    curl -s https://core.telegram.org/getProxySecret -o /proxy-secret > /dev/null 2>&1 ;\
    (crontab -l 2>/dev/null; echo "@daily curl -s https://core.telegram.org/getProxySecret -o /MTProxy/objs/bin/proxy-secret && systemctl restart MTProxy.service >> /var/log/cron.log 2>&1") | crontab - ;\
# Obtain current telegram configuration. It can change (occasionally), so we encourage you to update it once per day.
    (crontab -l 2>/dev/null; echo "@daily curl -s https://core.telegram.org/getProxyConfig -o /proxy-multi.conf && systemctl restart MTProxy.service >> /var/log/cron.log 2>&1") | crontab - ;\
    (crontab -l 2>/dev/null; echo '@daily wget --output-document="/MTProxy/Stats/$(date +%d.%m.%y).log" localhost:8888/stats  >> /var/log/cron.log 2>&1') | crontab - ;\
    curl -s https://core.telegram.org/getProxyConfig -o /proxy-multi.conf > /dev/null 2>&1 ;\
# Systemd service
    systemctl enable MTProxy.service > /dev/null 2>&1 ;\
    systemctl enable crond > /dev/null 2>&1 ;\
# Clean up
    yum -y groupremove "Development Tools" > /dev/null 2>&1 ;\
    yum -y autoremove > /dev/null 2>&1 ;\
    yum -y remove openssl-devel zlib-devel > /dev/null 2>&1;\
    yum clean all > /dev/null 2>&1;\
    rm -rf /var/cache/yum > /dev/null 2>&1
# Expose Ports:
EXPOSE 8889 8888
# CMD
CMD ["sh", "-c", "/MTProxy/objs/bin/mtproto-proxy -u nobody -p 8888 -H 8889 -S $Secret --aes-pwd proxy-secret proxy-multi.conf -M $Workers --nat-info $(getent hosts $(cat /etc/hostname) | awk '{print $1; exit}'):$(curl ifconfig.co) --http-stats"]
