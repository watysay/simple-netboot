# Simple TFTP server

Simple TFTP server for PXE booting

## How to use

Use ```make``` in order to build the image and launch the container, exposing local tftp directory content to port 69 on local IP.
On network boot, other machines on the network should be able to get pxelinux.0 bootloader.

> **Important** :
on running ```make```, you should get your local IP address.
Set this IP in your DHCP server as 'next-server' or 'TFTP server' value.
Set 'filename' to equal _pxelinux.0_


Other options are:

```make debian``` will retrieve Debian 12 netboot archive
and set it up under tftp/

```make clean``` will stop and remove container and network (aka ```docker compose down```)




## Files

### Dockerfile

Dockerfile contains tfpt server installation, configuration and entrypoint for clients.

### docker-compose.yml

This file contains info for building the image, expose port and bind local tftp directory for sharing.

### Makefile

Use makefile in order to build image, start container, stop container, retrieve distribution.


## TODOs

- Add other distributions
- Add ```make``` options to create service from container
- Add UEFI support