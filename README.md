![Banner](https://github.com/11notes/defaults/blob/main/static/img/banner.png?raw=true)

# 🏔️ Alpine - Chrony
![size](https://img.shields.io/docker/image-size/11notes/chrony/4.5?color=0eb305) ![version](https://img.shields.io/docker/v/11notes/chrony/4.5?color=eb7a09) ![pulls](https://img.shields.io/docker/pulls/11notes/chrony?color=2b75d6)

# SYNOPSIS
**What can I do with this?** Run chrony as NTP time server for your network, pure and simple, maximized for performance and security.

# CONFIG (EXAMPLE)
/chrony/etc/default.conf
```yaml
pool ch.pool.ntp.org  iburst maxsources 5
pool ntp.ubuntu.com   iburst maxsources 5
maxupdateskew 10.0
makestep 1 -1
clientloglimit 268435456
driftfile /chrony/run/drift
allow all
```

# COMPOSE
```yaml
name: "chrony"
services:
  chown:
    image: "11notes/chrony:4.5"
    user: "chrony"
    environment:
      TZ: "Europe/Zurich"
    restart: "always"
```

# DEFAULT SETTINGS
| Parameter | Value | Description |
| --- | --- | --- |
| `user` | docker | user docker |
| `uid` | 1000 | user id 1000 |
| `gid` | 1000 | group id 1000 |
| `home` | /chrony | home directory of user docker |

# ENVIRONMENT
| Parameter | Value | Default |
| --- | --- | --- |
| `TZ` | [Time Zone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) | |
| `DEBUG` | Show debug information | |

# SOURCE
* [11notes/chrony:4.5](https://github.com/11notes/docker-chrony/tree/4.5)

# PARENT IMAGE
* [11notes/alpine:stable](https://hub.docker.com/r/11notes/alpine)

# BUILT WITH
* [chrony](https://chrony-project.org)
* [alpine](https://alpinelinux.org)

# TIPS
* Use a reverse proxy like Traefik, Nginx to terminate TLS with a valid certificate
* Use Let’s Encrypt certificates to protect your SSL endpoints

# ElevenNotes<sup>™️</sup>
This image is provided to you at your own risk. Always make backups before updating an image to a new version. Check the changelog for breaking changes. You can find all my repositories on [github](https://github.com/11notes).
    