# Simple Netboot server

Simple Netboot server for iPXE booting

> *Warning* v2.0 is not compatible with v1.0.
> iPXE bootloading is NOT compatible with the use of previous files

## How to use

### TL;DR

For Debian 12 netboot:

```$ make```

Put shown IP address in DHCP config, add 'undionly.kpxe' as BIOS filename,
'ipxe.efi' as UEFI filename and 'main.ipxe' as iPXE filename.


### Details

Use ```make``` in order to retrieve Debian netboot image, setup ipxe, build the Docker image and launch the container,
exposing local data directory content to port 69 (tftp protocol) on local IP.
On network boot, other machines on the network should be able to get iPXE bootloaders.

> **Important** :
on running ```make```, you should get your local IP address.
Set this IP in your DHCP server as 'next-server' or 'TFTP server' value.
Set 'filename' to equal _undionly.kpxe_ (BIOS)
If possible, add conditionnal for architecture : serve either _undionly.kpxe_ or _ipxe.efi_
(for BIOS or UEFI).


> For OPNSense, the right config seems to be (under Services > DHCPv4 > LAN):
> - Empty fields in 'TFTP server'
> - in Network booting:
>   - Enable
>   - Next-server IP set
>   - default bios filename = undionly.kpxe
>   - x64 UEFI filename = ipxe.efi
>   - iPXE filename = main.ipxe


Other options are:

```make debian``` will retrieve Debian 12 netboot archive and set it up under data/

```make ipxe``` will retrieve iPXE Network Boot Programs (undionly.kpxe and ipxe.efi) under data/ and copy main.ipxe under data/

```make clean``` will stop and remove container and network (aka ```docker compose down```)



## Files

### Dockerfile

Dockerfile contains tfpt server installation, configuration and entrypoint for clients.

### docker-compose.yml

This file contains info for building the image, expose port and bind local data directory for sharing.

### Makefile

Use makefile in order to build image, start container, stop container, retrieve distribution, setup iPXE.


## TODOs

- Add other distributions
- Add ```make``` options to create service from container
