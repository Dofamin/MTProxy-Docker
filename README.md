[![Docker](https://github.com/Dofamin/MTProxy-Docker/actions/workflows/docker-image-build-publish.yml/badge.svg)](https://github.com/Dofamin/MTProxy-Docker/actions/workflows/docker-image-build-publish.yml)
# MTProxy-Docker

---

Simple MT-Proto proxy **ONLY FOR x86_64 SYSTEMS**

## Requirements

* VPS outside a country that blocked Telegram
* Minimum knowledge about docker and/or docker compose
* Read this entire README, the link at the end and understand what this project does

### With docker compose

#### Default settings

* Run `docker compose up -d`

#### Custom settings

If you want to customize an environment, create a `.env` file replacing the follow default values:

| Environment      | Default value                                |
| ---------------- | -------------------------------------------- |
| SECRET           | `ec4dd80983dbf12d6b354cf7bcfe9a48`           |
| WORKERS          | 1                                            |
| MTPROTO_REPO_URL | https://github.com/TelegramMessenger/MTProxy |
| TZ               |                                              |
| IP               | Public IP address (optional)                 |

An alternative to `MTPROTO_REPO_URL` is https://github.com/GetPageSpeed/MTProxy that is a fork from MTProxy with patches applied.

Public IP address is detected using "curl ifconfig.co". If it fails, you can provide it with the IP variable.

To more informations read the follow session.

### Building without docker compose

---

You can specify two arguments when building an image.
1. --build-arg WORKERS= (1 is the number of workers. You can increase the number of workers, if you have a powerful server.)

2. --build-arg SECRET=  (Default is ec4dd80983dbf12d6b354cf7bcfe9a48)
To generate a random secret, run the following command:
```shell
head -c 16 /dev/urandom | xxd -ps
```

```shell
git clone https://github.com/Dofamin/MTProxy-Docker.git /srv/MTProxy/

docker build /srv/MTProxy/ --tag mtproxy 

docker rm --force MTProxy

docker create \
  --name=MTProxy \
  -p 443:8889 \
  -e SECRET=ec4dd80983dbf12d6b354cf7bcfe9a48 \
  -e WORKERS=1 \
  --privileged \
  --restart unless-stopped \
  --memory="100m" \
  mtproxy:latest

docker start MTProxy

```

Or just pull from GitHub

```shell

docker pull ghcr.io/dofamin/mtproxy-docker:main

docker rm --force MTProxy

docker create \
  --name=MTProxy \
  -p 443:8889 \
  -e SECRET=ec4dd80983dbf12d6b354cf7bcfe9a48 \
  -e WORKERS=1 \
  --privileged \
  --restart unless-stopped \
  --memory="100m" \
  ghcr.io/dofamin/mtproxy-docker:main

docker start MTProxy

```


### Random padding

---

Due to some ISPs detecting MTProxy by packet sizes, random padding is added to packets if such mode is enabled.

It's only enabled for clients which request it.

Add dd prefix to secret (cafe...babe => ddcafe...babe) to enable this mode on client side.


### Troubleshooting

---

MTProto Proxy may fail to operate properly in certain conditions. There are two major problem categories: the client might not be able to connect to your proxy server (client applications will hang in "connecting" state), or your proxy server is unable to connect to the core Telegram servers (application hangs in "updating" state).

"Connecting" problems are usually caused by a misconfigured firewall, a Docker port forwarding problem, a state censorship issue, or a combination of the above.

If clients hang in an "updating" state, be sure to check the following:

1.Firewalls and/or DPI checkpoints between your proxy server and the core Telegram servers may not allow traffic to pass. Check your local firewall first.

2.Your proxy server's system time should be within five seconds of UTC. You should be running a time synchronization daemon to keep these issues to a minimum.

3.The MTProto Proxy must know about its globally routable external IP address if it's behind NAT. The container tries to detect the external IP address automatically, but this may fail if you have extracted the binary out of the container. Use mtproto-proxy --nat-info command line switch to configure the proxy server.

---

##### [Official MTProxy GitHub Repository](https://github.com/TelegramMessenger/MTProxy)
