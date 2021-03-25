# docker-chrony

chronyd inside an alpine docker container. Lightweight and fast.

## Run
```shell
docker run --name chrony:version \
    --cap-add SYS_TIME \
    -d 11notes/chrony:version
```

## Build with
* [Alpine Linux](https://alpinelinux.org/) - Alpine Linux
* [chrond](https://chrony.tuxfamily.org/) - Chronyd timeserver

## Tips
* [Permanent Storge with NFS/CIFS/...](https://github.com/11notes/alpine-docker-netshare) - Module to store permanent container data via NFS/CIFS/...