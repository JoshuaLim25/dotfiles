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
