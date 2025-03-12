This directory will host the files needed by the client in order to boot from network.


## PXE

### For BIOS boot :

Right at the beginning, client will need files _pxelinux.0_ and _pxelinux.cfg/default_.

_pxelinux.0_ is the Network Boot Program (NBP). Once downloaded in RAM, the client will boot it. This file, combined with _pxelinux.cfg/default_, will permit to load the next necessary items.

Next is needed a Linux kernel and an initramfs (Linux File system in RAM).
Once this minimalistic OS retrieved, it is booted and will proceed with a full OS boot (install, live, etc).


### For UEFI boot

The process is the same, except the files needed are different.

UEFI need an .efi NBP (_shim.efi_ usually or _bootnetx64.efi_ for Debian), completed by _grubx64.efi_ and a _grub.cfg_ menu config.
Once in the GRUB menu, choosing an item will load kernel and iniramfs, like in BIOS. 


This is the chain of PXE boot.

## iPXE

Built on top of PXE, iPXE was created to respond to the limitations of PXE.

The idea is to have BIOS netboot and UEFI netboot boot from iPXE itself,
which then takes control of the next boot process.
It can by default use tftp server but also use http server.
It has a lot more options and capabilities that PXE.


With this in mind, no files will be checked here.
All the files and directories that should be here, will be either:
1) made available through the distribution release or
2) highly customized by individuals or
3) tweaked by the Makefile above.