![banner](https://github.com/11notes/defaults/blob/main/static/img/banner.png?raw=true)

# CHRONY
![size](https://img.shields.io/docker/image-size/11notes/chrony/4.7?color=0eb305)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)![version](https://img.shields.io/docker/v/11notes/chrony/4.7?color=eb7a09)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)![pulls](https://img.shields.io/docker/pulls/11notes/chrony?color=2b75d6)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)[<img src="https://img.shields.io/github/issues/11notes/docker-CHRONY?color=7842f5">](https://github.com/11notes/docker-CHRONY/issues)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)![swiss_made](https://img.shields.io/badge/Swiss_Made-FFFFFF?labelColor=FF0000&logo=data:image/svg%2bxml;base64,PHN2ZyB2ZXJzaW9uPSIxIiB3aWR0aD0iNTEyIiBoZWlnaHQ9IjUxMiIgdmlld0JveD0iMCAwIDMyIDMyIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgogIDxyZWN0IHdpZHRoPSIzMiIgaGVpZ2h0PSIzMiIgZmlsbD0idHJhbnNwYXJlbnQiLz4KICA8cGF0aCBkPSJtMTMgNmg2djdoN3Y2aC03djdoLTZ2LTdoLTd2LTZoN3oiIGZpbGw9IiNmZmYiLz4KPC9zdmc+)

Run chrony rootless and distroless, secure by default!

# SYNOPSIS 📖
**What can I do with this?** Run chrony as an NTP server for your network, pure and simple, maximized for performance and security. If you plan to run this in production, make sure you stand up multiple NTP instances and put them behind a load balancer and use virtual IPs.

# UNIQUE VALUE PROPOSITION 💶
**Why should I run this image and not the other image(s) that already exist?** Good question! All the other images on the market that do exactly the same don’t do or offer these options:

> [!IMPORTANT]
>* This image runs as 1000:1000 by default, most other images run everything as root
>* This image has no shell since it is distroless, most other images run on a distro like Debian or Alpine with full shell access (security)
>* This image is created via a secure, pinned CI/CD process and immune to upstream attacks, most other images have upstream dependencies that can be exploited
>* This image contains a proper health check that verifies the app is actually working, most other images have either no health check or only check if a port is open or ping works
>* This image works as read-only, most other images need to write files to the image filesystem
>* This image is a lot smaller than most other images

If you value security, simplicity and the ability to interact with the maintainer and developer of an image. Using my images is a great start in that direction.

# COMPARISON 🏁
Below you find a comparison between this image and the most used or original one.

| **image** | 11notes/chrony:4.7 | dockurr/chrony:latest |
| ---: | :---: | :---: |
| **image size on disk** | 1.22MB | 15.4MB |
| **process UID/GID** | 1000/1000 | 0/0 |
| **distroless?** | ✅ | ❌ |
| **rootless?** | ✅ | ❌ |


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
    image: "11notes/chrony:4.7"
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

* [4.7](https://hub.docker.com/r/11notes/chrony/tags?name=4.7)

### There is no latest tag, what am I supposed to do about updates?
It is of my opinion that the ```:latest``` tag is super dangerous. Many times, I’ve introduced **breaking** changes to my images. This would have messed up everything for some people. If you don’t want to change the tag to the latest [semver](https://semver.org/), simply use the short versions of [semver](https://semver.org/). Instead of using ```:4.7``` you can use ```:4```. Since on each new version these tags are updated to the latest version of the software, using them is identical to using ```:latest``` but at least fixed to a major or minor version.

If you still insist on having the bleeding edge release of this app, simply use the ```:rolling``` tag, but be warned! You will get the latest version of the app instantly, regardless of breaking changes or security issues or what so ever. You do this at your own risk!

# REGISTRIES ☁️
```
docker pull 11notes/chrony:4.7
docker pull ghcr.io/11notes/chrony:4.7
docker pull quay.io/11notes/chrony:4.7
```

# SOURCE 💾
* [11notes/chrony](https://github.com/11notes/docker-CHRONY)

# PARENT IMAGE 🏛️
> [!IMPORTANT]
>This image is not based on another image but uses [scratch](https://hub.docker.com/_/scratch) as the starting layer.
>The image consists of the following distroless layers that were added:
>* [11notes/distroless](https://github.com/11notes/docker-distroless/blob/master/arch.dockerfile) - contains users, timezones and Root CA certificates

# BUILT WITH 🧰
* [chrony](https://gitlab.com/chrony/chrony)

# GENERAL TIPS 📌
> [!TIP]
>* Use a reverse proxy like Traefik, Nginx, HAproxy to terminate TLS and to protect your endpoints
>* Use Let’s Encrypt DNS-01 challenge to obtain valid SSL certificates for your services

# ElevenNotes™️
This image is provided to you at your own risk. Always make backups before updating an image to a different version. Check the [releases](https://github.com/11notes/docker-chrony/releases) for breaking changes. If you have any problems with using this image simply raise an [issue](https://github.com/11notes/docker-chrony/issues), thanks. If you have a question or inputs please create a new [discussion](https://github.com/11notes/docker-chrony/discussions) instead of an issue. You can find all my other repositories on [github](https://github.com/11notes?tab=repositories).

*created 12.06.2025, 08:29:00 (CET)*