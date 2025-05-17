# IMPORTANT NOTE
---
- This houses all of the configurations for the programs I use. I have spent lots and lots of time to make it grug simple to understand and navigate, but keep in mind that this is a configuration for **my personal use**, first and foremost. This is a living config, and things will not necessarily always look the same. Feel free to judge me for decisions you find janky or idiotic—unfortunately I do not care :(
- I hope this helps you in making your own configuration; config customization and management is a deep, deep rabbit hole and it's easy to get overwhelmed. Take things slow and remember to focus on tweaking the things that are actual hindrances to your workflow, rather than "oh this looks pretty I should spend the next few hours tinkering with this to get it working with everything instead of getting some shit i actually need to do done" (not speaking from experience).
- I have included references for anything I took from others' repositories. Taking a look at how other do things is absolutely a good idea for you as well.


# Dependencies, Post Install TODOs, and Notes
---
### Packages
- See `./dependencies.md`

### ZSH
- Run `chsh -s /usr/bin/zsh`, assuming `which zsh` returns that (and source it)

### Tmux
- Clone the `tpm` github repo, this should be put in `~/.config/tmux/plugins/tpm`
- Run `tmux source ~/.config/tmux/tmux.conf`
- `<Prefix+I>`

## Install AUR Helper:

- `yay` or `paru` (AUR helper, automates the manual pkgbuild process)
- Clone the associate git repo, `cd` into it, and run `makepkg -si`
- `sudo chown -R  josh:users yay`
- `sudo git clone https://aur.archlinux.org/yay.git`


#### AUR Packages

- Install these with `yay -S <pkg>`:
- `shellcheck-bin`


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


## SSH
- Ensure you have the requisite programs, `openssh`
- Enable `sshd.service`

### To automate the ssh-agent process
- See: [SO post](https://stackoverflow.com/questions/18880024/start-ssh-agent-on-login)
- See: [wiki page](https://wiki.archlinux.org/title/SSH_keys#Start_ssh-agent_with_systemd_user)
- `systemd` service, put in ~/.config/systemd/user/ssh-agent.service

```sh
[Unit]
Description=SSH key agent

[Service]
Type=simple
Environment=SSH_AUTH_SOCK=%t/ssh-agent.socket
ExecStart=/usr/bin/ssh-agent -D -a $SSH_AUTH_SOCK
Restart=on-failure

[Install]
WantedBy=default.target
```

# GNU Stow
---
- Moved, see `./automated_setup.md`

# Symlinks
- These are ones I manually set up, no good solution yet
- `ln -s ~/.dotfiles/scripts ~/.local/bin/scripts`
- `ln -s ~/Documents/ObsidianNotes/002_Areas/Lessons/Reminders.md ~/misc/reminders.md`
In `.dotfiles`, `stow misc`

