#!/usr/bin/env bash

# see https://drewdevault.com/2018/09/10/Getting-started-with-qemu.html
qemu-system-x86_64 \
    -enable-kvm \
    -m 2048 \
    # -nic user,model=virtio \
    -drive file=/var/lib/libvirt/images/arch-test-vm.qcow2,media=disk \ #,if=virtio \
    -cdrom /var/lib/libvirt/isos/archlinux-x86_64.iso \
    -boot menu=on \
    -cpu host \
    -smp 2 \
    # -vga virtio
    -sdl \
    # -display sdl,gl=on \
    # Use this option for sway
    -vga qxl
