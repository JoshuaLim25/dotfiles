#!/usr/bin/env sh
# NOTE: bindkey alone displays or modifies key bindings in the current keymap.
# Using bindkey -M lets you specify which keymap you’re working with.

bindkey -v

# Restore some keymaps removed by vi keybind mode
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins "^a" beginning-of-line
bindkey -M vicmd "^a" beginning-of-line
bindkey -M viins "^e" end-of-line
bindkey -M vicmd "^e" end-of-line
bindkey -M viins "^d" delete-char-or-list
bindkey -M vicmd "^d" delete-char
bindkey '^f' autosuggest-accept
bindkey '^w' backward-kill-word
# Bind backspace to delete a character in vi insert mode
bindkey -M viins '^H' backward-delete-char
bindkey -M viins '^?' vi-backward-delete-char
# bindkey '^r' history-incremental-search-backward

# Go to prev directory
bindkey -s -M viins "^o" "popd -q\n"

# shift-tab to move backwards in the completion list
# bindkey '^[[Z' reverse-menu-complete
# bindkey '^p' reverse-menu-complete

# Yank to the system clipboard
# See: https://stackoverflow.com/questions/37398532/how-do-i-yank-into-the-system-register-from-v-imode
# function vi-yank-xclip {
#     zle vi-yank
#    echo "$CUTBUFFER" | xclip -i
# }
#
# zle -N vi-yank-xclip
# bindkey -M vicmd 'y' vi-yank-xclip
