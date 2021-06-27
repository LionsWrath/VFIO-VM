#!/bin/bash

qemu-system-x86_64 \
	-enable-kvm \
	-cpu host,kvm=off,hv_vendor_id=wathever,-hypervisor,+topoext \
	-m 12G \
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
	-spice port=5900,disable-ticketing=on \
	-device virtio-serial-pci \
	-device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 \
	-chardev spicevmc,id=spicechannel0,name=vdagent \
	-device ich9-usb-ehci1,id=usb \
	-device ich9-usb-uhci1,masterbus=usb.0,firstport=0,multifunction=on \
	-chardev spicevmc,name=usbredir,id=usbredirchardev1 -device usb-redir,chardev=usbredirchardev1,id=usbredirdev1 \
	$@
