# Installation

## Arch Install Steps
```
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim
```

## Install External Dependencies

External Requirements:
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`), `ripgrep`
- Clipboard tool (xclip/xsel/win32yank or other depending on platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true
- Language Setup:
  - If want to write Typescript, you need `npm`
  - If want to write Golang, you will need `go`
  - etc.

> **NOTE**

Neovim's configurations are located under the following paths, depending on your OS:

| OS | PATH |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |

---

* What should I do with an already existing neovim configuration?
  * Remove your existing init.lua and the neovim files in `~/.local` with `rm -rf ~/.local/share/nvim/`
  * You can use [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME`
    to maintain multiple configurations. 
    ```
    # For instance, create
    `~/.config/nvim-config` and create an alias:
    alias nvim-config='NVIM_APPNAME="nvim-config" nvim'
    ```
    When you run Neovim using `nvim-config` alias it will use the alternative
    config directory and the matching local directory
    `~/.local/share/nvim-config`. You can apply this approach to any Neovim
    distribution that you would like to try out.
* What if I want to "uninstall" this configuration:

