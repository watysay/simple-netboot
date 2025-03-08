.PHONY: up debian prep clean

# So what happend when I launch make ?

# I want to 
# 1) build Dockerfile(s)
# 2) run docker compose up
# 3) display info / rc pour dire que c'est ok et que l'IP est xxx
up:
	docker compose build \
	&& docker compose up -d \
	&& echo "TFPT next-server is : $(shell ip a | grep "inet " | grep -v " lo\|docker\|br-" | cut -d '/' -f1 | sed -E 's: +inet::g')"

# pour "debian" si existe fichier pxelinux.0 alors ne rien faire
# sinon dl dans tftp
# http://ftp.fr.debian.org/debian/dists/bookworm/main/installer-amd64/current/images/netboot/netboot.tar.gz
# Pour le démarrage PXE, tout ce dont vous avez besoin est dans l'archive netboot/netboot.tar.gz.
# Extrayez les fichiers dans le répertoire des images de tftpd. Assurez-vous que le serveur DHCP donnera bien le fichier pxelinux.0 comme fichier d'amorçage à tftpd.
# Pour les machines avec UEFI, vous devrez vous assurer de donner un nom adapté à l'image (par exemple /debian-installer/amd64/bootnetx64.efi).
# ^^^^ on peut faire un if dans le fichier avec l'arch renvoyé par le client (bios ou uefi) pour proposer la bonne image
debian:
	$(MAKE) tftp/debian-installer/amd64/pxelinux.0

tftp/debian-installer/amd64/pxelinux.0:
	wget http://ftp.fr.debian.org/debian/dists/bookworm/main/installer-amd64/current/images/netboot/netboot.tar.gz
	tar xzf netboot.tar.gz -C tftp/
	rm netboot.tar.gz
# interet de cette construction: 
# si le fichier distrib est présent alors je ne le re recupere pas
#DISTRIB:
#	$(MAKE) <fichier distrib>
#
#<fichier distrib>:
#	Comment récupérer le fichier de DISTRIB sous tftp/

# prep prepare le fichier de menu a présenter aux machines au boot PXE
# le but est de consolider les fichiers de config des différentes distrib 'automatiquement'

# on rajoutera des paragraphes pour proxmox et d'autres

clean:
	docker compose down

# pour les tests, proxmox propose seaBIOS et UEFI
