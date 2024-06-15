virt-install \
    --name arch-test-vm \
    --ram 2048 \
    --disk path=/var/lib/libvirt/images/arch-test.qcow2,size=8 \
    --vcpus 2 \
    --os-variant archlinux \
    --console pty,target_type=serial \
    --cdrom /var/lib/libvirt/isos/archlinux-x86_64.iso
