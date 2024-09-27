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

" Will look in the current directory for "tags", and work up the tree towards
" root until one is found. IOW, you can be anywhere in your source tree
" instead of just the root of it.
" set tags=./tags;/

" let mapleader =" "
" xnoremap('<leader>p', '"_dP')
