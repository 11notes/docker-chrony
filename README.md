# docker-chrony

chronyd inside an alpine docker container. Lightweight and fast.

## Volumes

/chrony/etc

Purpose: Configuration file of chronyd

/chrony/var

Purpose: drift file etc

/chrony/log

Purpose: Log directory if activated in config

## Run
```shell
docker run --name chrony \
    -v volume-etc:/chrony/etc \
    -v volume-var:/chrony/var \
    -v volume-log:/chrony/log \
    --cap-add SYS_TIME \
    -d 11notes/chrony:latest
```

## Build with
* [Alpine Linux](https://alpinelinux.org/) - Alpine Linux
* [chrond](https://chrony.tuxfamily.org/) - Chronyd timeserver

## Tips
* [Permanent Storge with NFS/CIFS/...](https://github.com/11notes/alpine-docker-netshare) - Module to store permanent container data via NFS/CIFS/...