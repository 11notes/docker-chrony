![banner](https://raw.githubusercontent.com/11notes/static/refs/heads/main/img/banner/README.png)

# CHRONY
![size](https://img.shields.io/badge/image_size-${{ image_size }}-green?color=%2338ad2d)![5px](https://raw.githubusercontent.com/11notes/static/refs/heads/main/img/markdown/transparent5x2px.png)![pulls](https://img.shields.io/docker/pulls/11notes/chrony?color=2b75d6)![5px](https://raw.githubusercontent.com/11notes/static/refs/heads/main/img/markdown/transparent5x2px.png)[<img src="https://img.shields.io/github/issues/11notes/docker-chrony?color=7842f5">](https://github.com/11notes/docker-chrony/issues)![5px](https://raw.githubusercontent.com/11notes/static/refs/heads/main/img/markdown/transparent5x2px.png)![swiss_made](https://img.shields.io/badge/Swiss_Made-FFFFFF?labelColor=FF0000&logo=data:image/svg%2bxml;base64,PHN2ZyB2ZXJzaW9uPSIxIiB3aWR0aD0iNTEyIiBoZWlnaHQ9IjUxMiIgdmlld0JveD0iMCAwIDMyIDMyIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgogIDxyZWN0IHdpZHRoPSIzMiIgaGVpZ2h0PSIzMiIgZmlsbD0idHJhbnNwYXJlbnQiLz4KICA8cGF0aCBkPSJtMTMgNmg2djdoN3Y2aC03djdoLTZ2LTdoLTd2LTZoN3oiIGZpbGw9IiNmZmYiLz4KPC9zdmc+)

run chrony rootless and distroless.

# INTRODUCTION 📢

chrony is a versatile implementation of the Network Time Protocol (NTP). It can synchronise the system clock with NTP servers, reference clocks e.g. GPS receiver), and manual input using wristwatch and keyboard.

# SYNOPSIS 📖
**What can I do with this?** Run chrony as an NTP server for your network, pure and simple, maximized for performance and security. If you plan to run this in production, make sure you stand up multiple NTP instances and put them behind a load balancer and use virtual IPs. Pair this image with a GPS USB antenna and you can run your own Stratum 1 NTP for your entire network.

# UNIQUE VALUE PROPOSITION 💶
**Why should I run this image and not the other image(s) that already exist?** Good question! Because ...

> [!IMPORTANT]
>* ... this image runs [rootless](https://github.com/11notes/RTFM/blob/main/linux/container/image/rootless.md) as 1000:1000
>* ... this image has no shell since it is [distroless](https://github.com/11notes/RTFM/blob/main/linux/container/image/distroless.md)
>* ... this image is auto updated to the latest version via CI/CD
>* ... this image has a health check
>* ... this image runs read-only
>* ... this image is automatically scanned for CVEs before and after publishing
>* ... this image is created via a secure and pinned CI/CD process
>* ... this image is very small

If you value security, simplicity and optimizations to the extreme, then this image might be for you.

# COMPARISON 🏁
Below you find a comparison between this image and the most used or original one.

| **image** | **size on disk** | **init default as** | **[distroless](https://github.com/11notes/RTFM/blob/main/linux/container/image/distroless.md)** | supported architectures
| ---: | ---: | :---: | :---: | :---: |
| dockurr/chrony | 15MB | 0:0 | ❌ | amd64, arm64, armv7 |

# VOLUMES 📁
* **/chrony/etc** - Directory of your config

# DEFAULT CONFIG 📑
```sh
pool ch.pool.ntp.org iburst maxsources 5
pool ntp.ubuntu.com iburst maxsources 5
maxupdateskew 10.0
makestep 1 -1
clientloglimit 268435456
driftfile /run/chrony/drift
allow all
```

# COMPOSE ✂️
```yaml
name: "chrony"
services:
  app:
    image: "11notes/chrony:4.8.0"
    read_only: true
    environment:
      TZ: "Europe/Zurich"
    volumes:
      - "etc:/chrony/etc"
    ports:
      - "123:123/udp"
    tmpfs:
      # tmpfs volume because of read_only: true
      - "/run/chrony:mode=0770,uid=1000,gid=1000"
    sysctls:
      # allow rootless container to access ports < 1024
      net.ipv4.ip_unprivileged_port_start: 123
    restart: "always"

volumes:
  etc:
```
To find out how you can change the default UID/GID of this container image, consult the [RTFM](https://github.com/11notes/RTFM/blob/main/linux/container/image/11notes/how-to.changeUIDGID.md#change-uidgid-the-correct-way).

# DEFAULT SETTINGS 🗃️
| Parameter | Value | Description |
| --- | --- | --- |
| `user` | docker | user name |
| `uid` | 1000 | [user identifier](https://en.wikipedia.org/wiki/User_identifier) |
| `gid` | 1000 | [group identifier](https://en.wikipedia.org/wiki/Group_identifier) |
| `home` | /chrony | home directory of user docker |

# ENVIRONMENT 📝
| Parameter | Value | Default |
| --- | --- | --- |
| `TZ` | [Time Zone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) | |
| `DEBUG` | Will activate debug option for container image and app (if available) | |

# MAIN TAGS 🏷️
These are the main tags for the image. There is also a tag for each commit and its shorthand sha256 value.

* [4.8.0](https://hub.docker.com/r/11notes/chrony/tags?name=4.8.0)
* [4.8.0-unraid](https://hub.docker.com/r/11notes/chrony/tags?name=4.8.0-unraid)
* [4.8.0-nobody](https://hub.docker.com/r/11notes/chrony/tags?name=4.8.0-nobody)

### There is no latest tag, what am I supposed to do about updates?
It is my opinion that the ```:latest``` tag is a bad habbit and should not be used at all. Many developers introduce **breaking changes** in new releases. This would messed up everything for people who use ```:latest```. If you don’t want to change the tag to the latest [semver](https://semver.org/), simply use the short versions of [semver](https://semver.org/). Instead of using ```:4.8.0``` you can use ```:4``` or ```:4.8```. Since on each new version these tags are updated to the latest version of the software, using them is identical to using ```:latest``` but at least fixed to a major or minor version. Which in theory should not introduce breaking changes.

If you still insist on having the bleeding edge release of this app, simply use the ```:rolling``` tag, but be warned! You will get the latest version of the app instantly, regardless of breaking changes or security issues or what so ever. You do this at your own risk!

# REGISTRIES ☁️
```
docker pull 11notes/chrony:4.8.0
docker pull ghcr.io/11notes/chrony:4.8.0
docker pull quay.io/11notes/chrony:4.8.0
```

# UNRAID VERSION 🟠
This image supports unraid by default. Simply add **-unraid** to any tag and the image will run as 99:100 instead of 1000:1000.

# NOBODY VERSION 👻
This image supports nobody by default. Simply add **-nobody** to any tag and the image will run as 65534:65534 instead of 1000:1000.

# SOURCE 💾
* [11notes/chrony](https://github.com/11notes/docker-chrony)

# PARENT IMAGE 🏛️
> [!IMPORTANT]
>This image is not based on another image but uses [scratch](https://hub.docker.com/_/scratch) as the starting layer.
>The image consists of the following distroless layers that were added:
>* [11notes/distroless](https://github.com/11notes/docker-distroless/blob/master/arch.dockerfile) - contains users, timezones and Root CA certificates, nothing else

# BUILT WITH 🧰
* [chrony](https://gitlab.com/chrony/chrony)

# GENERAL TIPS 📌
> [!TIP]
>* Use a reverse proxy like Traefik, Nginx, HAproxy to terminate TLS and to protect your endpoints
>* Use Let’s Encrypt DNS-01 challenge to obtain valid SSL certificates for your services

# ElevenNotes™️
This image is provided to you at your own risk. Always make backups before updating an image to a different version. Check the [releases](https://github.com/11notes/docker-chrony/releases) for breaking changes. If you have any problems with using this image simply raise an [issue](https://github.com/11notes/docker-chrony/issues), thanks. If you have a question or inputs please create a new [discussion](https://github.com/11notes/docker-chrony/discussions) instead of an issue. You can find all my other repositories on [github](https://github.com/11notes?tab=repositories).

*created 26.01.2026, 22:01:53 (CET)*