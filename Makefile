.PHONY: up debian prep ipxe clean

# So what happend when I launch make ?

# I want to 
# 1) build Dockerfile(s)
# 2) run docker compose up
# 3) display info / rc pour dire que c'est ok et que l'IP est xxx
up: debian ipxe
	docker compose build \
	&& docker compose up -d \
	&& echo "Next-server is : $(shell ip a | grep "inet " | grep -v " lo\|docker\|br-" | cut -d '/' -f1 | sed -E 's: +inet::g')" \
	&& echo "Add : 'undionly.kpxe' as BIOS filename and 'ipxe.efi' as UEFI filename and 'main.ipxe' as iPXE filename"

# pour "debian" si existe fichier pxelinux.0 alors ne rien faire
# sinon dl dans data
# http://ftp.fr.debian.org/debian/dists/bookworm/main/installer-amd64/current/images/netboot/netboot.tar.gz
# Pour le démarrage PXE, tout ce dont vous avez besoin est dans l'archive netboot/netboot.tar.gz.
# Extrayez les fichiers dans le répertoire des images de tftpd. Assurez-vous que le serveur DHCP donnera bien le fichier pxelinux.0 comme fichier d'amorçage à tftpd.
# Pour les machines avec UEFI, vous devrez vous assurer de donner un nom adapté à l'image (par exemple /debian-installer/amd64/bootnetx64.efi).
# ^^^^ on peut faire un if dans le fichier avec l'arch renvoyé par le client (bios ou uefi) pour proposer la bonne image
debian: data/debian-installer/amd64/pxelinux.0
data/debian-installer/amd64/pxelinux.0:
	wget http://ftp.fr.debian.org/debian/dists/bookworm/main/installer-amd64/current/images/netboot/netboot.tar.gz
	tar xzf netboot.tar.gz -C ./data/
	rm netboot.tar.gz

# Ajout de fonctionnalité iPXE
# Ajout deux fichiers pour booter iPXE depuis BIOS ou UEFI
#+ menu main.ipxe pour gérer le boot kernel
ipxe: data/main.ipxe data/undionly.kpxe data/ipxe.efi
data/main.ipxe: main.ipxe
	cp -p ./main.ipxe ./data/
data/undionly.kpxe:
	wget http://boot.ipxe.org/undionly.kpxe -O ./data/undionly.kpxe
data/ipxe.efi:
	wget http://boot.ipxe.org/ipxe.efi -O ./data/ipxe.efi

# prep prepare le fichier de menu a présenter aux machines au boot PXE
# le but est de consolider les fichiers de config des différentes distrib 'automatiquement'
# on rajoutera des paragraphes pour proxmox et d'autres

clean:
	docker compose down
reset:
	$(MAKE) clean
	cd data && find . ! -name "README.md" -delete && echo "Directory data/ purged"

# pour les tests, proxmox propose seaBIOS et UEFI
