# Alpine :: Chrony (Server)
![size](https://img.shields.io/docker/image-size/11notes/chrony/4.3?color=0eb305) ![version](https://img.shields.io/docker/v/11notes/chrony?color=eb7a09) ![pulls](https://img.shields.io/docker/pulls/11notes/chrony?color=2b75d6) ![activity](https://img.shields.io/github/commit-activity/m/11notes/docker-chrony?color=c91cb8) ![commit-last](https://img.shields.io/github/last-commit/11notes/docker-chrony?color=c91cb8)

Run a Chrony NTP server based on Alpine Linux. Small, lightweight, secure and fast 🏔️

## Volumes
* **/chrony/etc** - Directory of chrony configuration file chrony.conf

## Run
```shell
docker run --name chrony \
  -v .../etc:/chrony/etc \
  --cap-add SYS_TIME \
  -d 11notes/chrony:[tag]
```

## Defaults
| Parameter | Value | Description |
| --- | --- | --- |
| `user` | docker | user docker |
| `uid` | 1000 | user id |
| `gid` | 1000 | group id |

## Parent image
* [11notes/alpine:stable](https://github.com/11notes/docker-alpine)

## Built with and thanks so
* [chrony](https://chrony-project.org)
* [Alpine Linux](https://alpinelinux.org)

## Tips
* Only use rootless container runtime (podman, rootless docker)
* Don't bind to ports < 1024 (requires root), use NAT/reverse proxy (haproxy, traefik, nginx)