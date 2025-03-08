This directory will host the files needed by the client in order to boot from network.

Right at the beginning, client will need files _pxelinux.0_ and _pxelinux.cfg/default_.

_pxelinux.0_ is the Network Boot Program (NBP). Once downloaded in RAM, the client will boot it. This file, combined with _pxelinux.cfg/default_, will permit to load the next necessary items.

Next is needed a Linux kernel and an initramfs (Linux File system in RAM).
Once this minimalistic OS retrieved, it is booted and will proceed with a full OS boot (install, live, etc).

This is the chain of PXE boot.

With this in mind, no files will be checked here.
All the files and directories that should be here, will be either:
1) made available through the distribution release or
2) highly customized by individuals or
3) tweaked by the Makefile above.