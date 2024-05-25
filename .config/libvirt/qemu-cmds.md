# Warning

If you store the hard disk images on a Btrfs file system, you should consider disabling Copy-on-Write for the directory before creating any images.
Can be specified in option nocow for qcow2 format when creating image:
`$ qemu-img create -f qcow2 image_file -o nocow=on 4G`
