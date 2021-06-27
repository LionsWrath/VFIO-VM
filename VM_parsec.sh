#!/bin/bash

qemu-system-x86_64 \
	-enable-kvm \
	-cpu host,kvm=off,hv_vendor_id=wathever,-hypervisor,+topoext \
	-m 8G \
	-M q35,kernel_irqchip=on \
	-name "KappaVM" \
	-smp cores=8 \
	-drive format=raw,file=vm-kappa.img,if=virtio \
	-drive format=qcow2,file=/home/lionswrath/data/drive-kappa.qcow2,if=virtio \
	-drive if=pflash,format=raw,readonly=on,file=/usr/share/edk2-ovmf/x64/OVMF_CODE.fd \
	-drive if=pflash,format=raw,file=vars/MY_VARS.fd \
	-device vfio-pci,host=26:00.0,multifunction=on,romfile=vbios/Zotac.GTX1050Ti.patched.rom \
	-device vfio-pci,host=26:00.1 \
	-device vfio-pci,host=27:00.3 \
	-nic bridge,model=virtio,br=br0 \
	-monitor none \
	-vga none \
	-daemonize \
	$@
