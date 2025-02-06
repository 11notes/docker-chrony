![Banner](https://github.com/11notes/defaults/blob/main/static/img/banner.png?raw=true)

# 🏔️ chrony on Alpine
[<img src="https://img.shields.io/badge/github-source-blue?logo=github&color=040308">](https://github.com/11notes/docker-chrony)![size](https://img.shields.io/docker/image-size/11notes/chrony/4.6.1?color=0eb305)![version](https://img.shields.io/docker/v/11notes/chrony/4.6.1?color=eb7a09)![pulls](https://img.shields.io/docker/pulls/11notes/chrony?color=2b75d6)[<img src="https://img.shields.io/github/issues/11notes/docker-chrony?color=7842f5">](https://github.com/11notes/docker-chrony/issues)

**Chrony NTP server on Alpine**

# SYNOPSIS 📖
**What can I do with this?** Run chrony as NTP server for your network, pure and simple, maximized for performance and security. If you plan to run this in production, make sure you stand up multiple NTP instances and put them behind a load balancer and use virtual IPs.

# DEFAULT CONFIG 📑
/chrony/etc/default.conf
```yaml
pool ch.pool.ntp.org iburst maxsources 5
pool ntp.ubuntu.com iburst maxsources 5
maxupdateskew 10.0
makestep 1 -1
clientloglimit 268435456
pidfile /chrony/run/chrony.pid
driftfile /chrony/run/drift
allow all
```

# COMPOSE ✂️
```yaml
name: "chrony"
services:
  chrony:
    image: "11notes/chrony:4.6.1"
    container_name: "chrony"
    environment:
      TZ: "Europe/Zurich"
    ports:
      - "123:123/udp"
    sysctls:
      - net.ipv4.ip_unprivileged_port_start=123
    restart: "always"
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
| `DEBUG` | Show debug messages from image **not** app | |

# SOURCE 💾
* [11notes/chrony](https://github.com/11notes/docker-chrony)

# PARENT IMAGE 🏛️
* [11notes/alpine:stable](https://hub.docker.com/r/11notes/alpine)

# BUILT WITH 🧰
* [chrony](https://chrony-project.org)
* [alpine](https://alpinelinux.org)

# TIPS 📌
* Use a reverse proxy like Traefik, Nginx, HAproxy to terminate TLS with a valid certificate
* Use Let’s Encrypt certificates to protect your SSL endpoints
  
# ElevenNotes™️
This image is provided to you at your own risk. Always make backups before updating an image to a different version. Check the [releases](https://github.com/11notes/docker-chrony/releases) for breaking changes. If you have any problems with using this image simply raise an [issue](https://github.com/11notes/docker-chrony/issues), thanks . You can find all my repositories on [github](https://github.com/11notes?tab=repositories).