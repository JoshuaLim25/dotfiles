syntax on
set number relativenumber
inoremap jk <Esc>

"Default clipboard = system keyboard
set clipboard=unnamedplus

" Set cursor to a block for normal, visual, and command-line modes
set guicursor=n-v-c:block

" Disable blinking
set guicursor+=a:blinkon0

"Sets correct tab size
set tabstop=4
set softtabstop=4
set shiftwidth=4


colorscheme desert

" https://stackoverflow.com/questions/61379318/how-to-copy-from-vim-to-system-clipboard-using-wayland-and-without-compiled-vim
nnoremap <C-@> :call system("wl-copy", @")<CR>

" https://stackoverflow.com/questions/4775088/vim-how-to-select-pasted-block
nnoremap <leader>p `[V`]
nnoremap <leader>[ `[V`]<
nnoremap <leader>] `[V`]>

" Will look in the current directory for "tags", and work up the tree towards
" root until one is found. IOW, you can be anywhere in your source tree
" instead of just the root of it.
" set tags=./tags;/

" let mapleader =" "
" xnoremap('<leader>p', '"_dP')

" src: https://github.com/morhetz/gruvbox/wiki/Terminal-specific#0-recommended-neovimvim-true-color-support
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX) && getenv('TERM_PROGRAM') != 'Apple_Terminal')
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
