virt-install \
    --name test \
    --disk path=/var/lib/libvirt/images/name.qcow2,size=8 \
    --vcpus 2 \
    --os-type linux \
    --os-variant generic \
    --console pty,target_type=serial \
    --cdrom /var/lib/libvirt/isos/ubuntu-24.04-live-server-amd64.iso
