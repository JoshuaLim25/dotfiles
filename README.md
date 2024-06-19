# Dependencies

## Arch-specific

- `base-devel`
- `git`
- `nvim`
- `vim`
- `linux`
- `zsh`
- `kitty` (or term of choice)
- `man`
- `grub`
- `os-prober`
- `coreutils`
- `efibootmgr`
- `firefox`
- `wpa_supplicant`
- `gcc`
- `make`
- `cmake`
- `ctags`
- `clang`
- `npm`
- `ripgrep`
- `unzip`
- `stow`
- `jq`
- `sof-firmware`
- `ttf-jetbrains-mono`
- `ttf-jetbrains-mono-nerd`
- `ttf-roboto`
- `ttf-roboto-mono`
- `ttf-font-awesome`
- `ttf-hack`
- `ttf-inconsolata`
- `ttf-opensans`
- `ttf-dejavu`
- `gnu-free-fonts`
- `intel-ucode` (amd is the other microcode, install yours)
- `tlp`
- `tlp-rdw`
- `pipewire`
- `pipewire-alsa`
- `pipewire-audio`
- `pipewire-pulse`
- `obsidian`
- `openssh`
- `reflector`
- `qemu` (see the octetz vid, `bridge-utils` is a biggie)
- `pacman-contrib` (for cache cleaning, look it up)
- `xclip`
- `xbindkeys`
- `xorg-xhost`
- `docker`
- `docker-compose`
- `grim`
- `slurp`
- `bemenu`
- `dunst`
- `alsa-utils`
- `evtest` (for tracking keyboard inputs)

## Sway

- `wayland`
- `xorg-xwayland`
- `sway`
- `swaybg`
- `swayidle`
- `swaylock`
- `swayimg`
- `wl-clipboard`
- `wlroots`
- `wofi`
- `wlr-randr`
- `wayland-protocols`
- `ly`

# Post Install TODOs:

- Run `chsh -s /usr/bin/zsh`, assuming `which zsh` returns that (and source it)
- clone the `tpm` github repo, this should be put in `~/.config/tmux/plugins/tpm`

## Install AUR Helper:

- `yay` or `paru` (AUR helper, automates the manual pkgbuild process)
- Clone the associate git repo, `cd` into it, and run `makepkg -si`
- `sudo chown -R  josh:users yay`
- `sudo git clone https://aur.archlinux.org/yay.git`

## Ly

- `/etc/ly/config.ini` contains config
- Run `sudo systemctl enable ly.service`
- `sudoedit /lib/systemd/system/ly.service` to change colors:

```
[Unit]
Description=TUI display manager
After=systemd-user-sessions.service plymouth-quit-wait.service
After=getty@tty2.service

[Service]
Type=idle
ExecStartPre=/usr/bin/printf '%%b' '\e]P018191E\e]P7F4BB44\ec'
ExecStart=/usr/bin/ly-dm
StandardInput=tty
TTYPath=/dev/tty2
TTYReset=yes
TTYVHangup=yes

[Install]
Alias=display-manager.service
```

## Reflector
`sudoedit /etc/xdg/reflector/reflector.conf`

```
# Reflector configuration file for the systemd service.
#
# Empty lines and lines beginning with "#" are ignored.  All other lines should
# contain valid reflector command-line arguments. The lines are parsed with
# Python's shlex modules so standard shell syntax should work. All arguments are
# collected into a single argument list.
#
# See "reflector --help" for details.

# Recommended Options

# Set the output path where the mirrorlist will be saved (--save).
--save /etc/pacman.d/mirrorlist

# Select the transfer protocol (--protocol).
--protocol https

# Select the country (--country).
# Consult the list of available countries with "reflector --list-countries" and
# select the countries nearest to you or the ones that you trust. For example:
# --country France,Germany
--country "United States"

# Use only the  most recently synchronized mirrors (--latest).
--latest 5

# Sort the mirrors by synchronization time (--sort).
--sort age
```

Afterwards, enable `reflector.service` to run on boot


## Docker
- Enable `docker.socket` (only starts docker service on usage)
- Note that docker.service starts the service on boot, whereas docker.socket starts docker on first usage which can decrease boot times
