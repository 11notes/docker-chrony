![Banner](https://github.com/11notes/defaults/blob/main/static/img/banner.png?raw=true)

# 🏔️ Alpine - Chrony
![size](https://img.shields.io/docker/image-size/11notes/chrony/4.5?color=0eb305) ![version](https://img.shields.io/docker/v/11notes/chrony/4.5?color=eb7a09) ![pulls](https://img.shields.io/docker/pulls/11notes/chrony?color=2b75d6) ![activity](https://img.shields.io/github/commit-activity/m/11notes/docker-chrony?color=c91cb8) ![commit-last](https://img.shields.io/github/last-commit/11notes/docker-chrony?color=c91cb8) ![stars](https://img.shields.io/docker/stars/11notes/chrony?color=e6a50e)

# SYNOPSIS
Chrony as NTP time server, pure and simple, maximized for performance and security.

# RUN
```shell
docker run --name chrony \
  -p 123:123/udp \
  -d 11notes/chrony:[tag]
```

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

# PARENT IMAGE
* [11notes/alpine:stable](https://hub.docker.com/r/11notes/alpine)

# BUILT WITH
* [chrony](https://chrony-project.org)
* [alpine](https://alpinelinux.org)

# TIPS
* Only use rootless container runtime (podman, rootless docker)
* Allow non-root ports < 1024 via `echo "net.ipv4.ip_unprivileged_port_start=53" > /etc/sysctl.d/ports.conf`
* Use a reverse proxy like Traefik, Nginx to terminate TLS with a valid certificate
* Use Let’s Encrypt certificates to protect your SSL endpoints

# ElevenNotes<sup>™️</sup>
This image is provided to you at your own risk. Always make backups before updating an image to a new version. Check the changelog for breaking changes.
    