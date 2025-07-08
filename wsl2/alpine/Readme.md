# Steps to install and configure

- Download alpine linux mini root filesystem x86_64
- make dir C:\WSL\Alpine
- run command
- cd to Downloads directory
 ```sh
wsl --import Alpine C:\WSL\Alpine .\alpine-minirootfs-3.22.0-x86_64.tar.gz --version 2
wsl -d ALpine
```

## Now this will open the Alpine shell
## Install some apps:
```sh
apk update && apk upgrade
apk add vim git wget curl nano openrc iproute2 bash
```
## Edit some files

- nano /etc/wsl.conf
[automount]
enabled = true
mountFsTab = true

[interop]
enabled = true
appendWindowsPath = true

[boot]
command = "/sbin/openrc default"

- nano /etc/network/interfaces
auto lo
iface lo inet loopback

## Install docker
apk add docker docker-compose

## configure to run on start
rc-update del docker default
rc-update add docker default
rc-update show default

# to restart, if required
rc-service docker status
rc-service docker restart
