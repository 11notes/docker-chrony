# Alpine :: Chrony (Server)
Run a Chrony NTP server based on Alpine Linux. Small, lightweight, secure and fast 🏔️


## Volumes
* **/chrony/etc** - Directory of chrony configuration file chrony.conf

## Run
```shell
docker run --name chrony \
  -v .../etc:/chrony/etc \
  -d 11notes/chrony:[tag]
```

## Defaults
| Parameter | Value | Description |
| --- | --- | --- |
| `user` | docker | user docker |
| `uid` | 1000 | user id 1000 |
| `gid` | 1000 | group id 1000 |

## Parent
* [11notes/alpine:stable](https://github.com/11notes/docker-alpine)

## Built with
* [chrony](https://chrony-project.org)
* [Alpine Linux](https://alpinelinux.org)

## Tips
* Don't bind to ports < 1024 (requires root), use NAT/reverse proxy
* [Permanent Storage](https://github.com/11notes/alpine-docker-netshare) - Module to store permanent container data via NFS/CIFS and more