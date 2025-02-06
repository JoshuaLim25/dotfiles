# Good refreshers:
https://wiki.archlinux.org/title/QEMU#Creating_new_virtualized_system
https://drewdevault.com/2018/09/10/Getting-started-with-qemu.html

- *Note*: If you store the hard disk images on a `btrfs` file system, you should consider disabling Copy-on-Write for the directory before creating any images.
  - Can be specified in option nocow for qcow2 format when creating image:
  `$ qemu-img create -f qcow2 image_file -o nocow=on 4G`

# Commands
- *Note*: `du -h file.qcow2` will show you the real occupied disk space 

```sh

# To create a virtual image use:
`qemu-img create -f qcow2 Image.img 10G`
# INFO: The create subcommand is to create an image, -f qcow2 sets the format to qcow2, Image.img is our final file and 10G is it's size

qemu-system-x86_64 \
    -enable-kvm \
    -m 2048 \ # Gives guest (the VM) 2048M of RAM (memory)
    -nic user,model=virtio \ # Use the `virtio` NIC model
    -drive file=alpine.qcow2,media=disk,if=virtio \ # Attach virtual disk to guest (storage)
    -cdrom alpine-standard-3.8.0-x86_64.iso \ # Connects virtual CD drive, load install media (OS)
    -sdl
# When you shut down the host, run qemu again without -cdrom to start the VM.

```
# Launching the VM:
`qemu-system-x86_64 -enable-kvm -cdrom OS_ISO.iso -boot menu=on -drive file=Image.img -m 2G`
(-enable-kvm enables KVM, -cdrom selects an iso to load as a cd, -boot menu=on enables a boot menu, -drive file= selects a file for the drive, -m sets the amount of dedicated RAM)
(Remember! Ctrl + Alt + G to exit capture, Ctrl + Alt + F to fullscreen!)

# Basic performance options

- `cpu host` (sets the CPU to the hosts' CPU):
- `smp 2` (sets the numbers of cores):

# Basic Graphics Acceleration
- the `-vga` option can be used to specify one of various vga card emulators:
    - "qxl" offers 2D acceleration but requires kernel modules "qxl" and "bochs_drm" to be enabled: `-vga qxl`
- "virtio" works much better and supports some 3D emulation: `-vga virtio -display sdl,gl=on`

# OS
- https://wiki.osdev.org/QEMU#Usage

```sh
qemu-system-i386                                 \
  -accel tcg,thread=single                       \
  -cpu core2duo                                  \
  -m 128                                         \
  -no-reboot                                     \
  -drive format=raw,media=cdrom,file=myos.iso    \
  -serial stdio                                  \
  -smp 1                                         \
  -usb                                           \
  -vga std
```
