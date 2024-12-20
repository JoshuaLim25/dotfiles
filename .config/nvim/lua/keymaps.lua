-- NOTE: weird modes — vblock (x), term (t), cmd mode (c), visual, meaning `v` and `V,` is (v)

-- [[ ESSENTIAL ]] {{
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Normal mode
keymap('i', 'jk', '<esc>', opts)
keymap('i', 'kj', '<esc>', opts)
keymap('i', 'JK', '<esc>', opts)

-- Easier keybinds for common ops
keymap('n', 'cu', 'ct_', opts)
keymap('n', 'du', 'dt_', opts)
keymap({ 'n', 'v', 'x', 'o' }, 'H', '^', opts)
keymap({ 'n', 'v', 'x', 'o' }, 'L', '$', opts)

-- Toggle search highlights
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- "Write no format"
keymap('n', '<leader>wnf', '<cmd>noautocmd w <CR>', { noremap = true, silent = true, desc = '[W]rite [N]o [F]ormat' })
-- }}

-- [[ QOL/COOL ]] {{
-- Move lines/blocks in visual mode vertically
keymap('v', 'J', ":m '>+1<CR>gv=gv", opts)
keymap('v', 'K', ":m '<-2<CR>gv=gv", opts)
-- Duplicate a line, comment out the original line
keymap('n', 'yc', 'yygccp', { remap = true }) -- NOTE: `remap = true` is required
-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)
-- Switching to last recently-opened buffer
keymap('n', '<leader>;', ':b#<CR>', { desc = 'Previous buffer' })

-- change indentation of pasted selection
-- src1: https://stackoverflow.com/questions/4312664/is-there-a-vim-command-to-select-pasted-text
-- src2: https://stackoverflow.com/questions/4775088/vim-how-to-select-pasted-block
-- nnoremap <leader>p `[V`]

-- Re-select most recent visual highlighted
keymap('n', '<leader>v', '`[V`]', opts)

-- Select entire buffer
keymap('n', 'gG', 'gg<S-v>G', { desc = 'Select all' })

-- Indent the recently pasted block
keymap('n', '<leader>]', '`[V`]>', opts)

-- De-indent the recently pasted block
keymap('n', '<leader>[', '`[V`]<', opts)

-- Lets you type shell commands in a file and get the output there
keymap('n', '<leader>so', ':.!sh<cr>', { noremap = true, desc = '[S]hell [O]utput' })
-- }}

-- [[ POTENTIALLY HELPFUL STUFF ]] {{
-- From the Vim wiki: https://bit.ly/4eLAARp
-- Search and replace word under the cursor
-- mostly for places w/o LSP
-- vim.keymap.set("n", "<Leader>r", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]])

-- Example of a "mini-snippet," maybe
-- look into utilizing more insert mode keymaps
-- vim.keymap.set('i', '<C-l>', '<space>=><space>')

-- Literal search and replace
-- vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- IDEA:
-- <leader>co and <leader>cr. co enters the command line, runs the command g++ {filename}.cpp -o temp. cr opens command line, splits the window, enters bash terminal and echos ./temp, i do A LOT with C++ so it's my favorite little thing I made.

-- -- Quick notes
-- keymap('<leader>ww', function()
--   local year = vim.fn.strftime('%Y')
--   vim.fn.execute('cd $HOME/notes')
--   vim.fn.execute(('e %s-daylog.md'):format(year))
-- end, { desc = 'We have wiki at home' })

-- https://www.reddit.com/r/neovim/comments/1h7f0bz/share_your_coolest_keymap/
-- vim.cmd([[ function! MoveByWord(flag)
--   if mode() == 'v' | execute "norm! gv" | endif
--   for n in range(v:count1)
--     call search('\v(\w|_|-)+', a:flag, line('.'))
--   endfor
-- endfunction ]])

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- keymap('t', '<leader><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Save and load session
-- keymap('n', '<leader>ss', ':mksession! .session.vim<CR>', { noremap = true, silent = false })
-- keymap('n', '<leader>sl', ':source .session.vim<CR>', { noremap = true, silent = false })
--  }}

-- [[ NAVIGATION ]] {{
--  Use Ctl + <hjkl> to switch between windows/splits
keymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Switch focus to left window' })
keymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Switch focus to right window' })
keymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Switch focus to lower window' })
keymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Switch focus to upper window' })
--
-- Anti-textwrap
keymap({ 'n', 'v' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap({ 'n', 'v' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- }}

-- [[ CENTERING/FOCUS ]] {{
-- Search results
keymap('n', 'n', 'nzzzv', { silent = true })
keymap('n', 'N', 'Nzzzv', { silent = true })
keymap('n', '*', '*zz', { silent = true })
keymap('n', '#', '#zz', { silent = true })
keymap('n', 'g*', 'g*zz', { silent = true })

-- vertical mvmt
keymap('n', '<C-d>', '<C-d>zz', opts)
keymap('n', '<C-u>', '<C-u>zz', opts)
-- }}

-- [[ COPY/PASTE ]] {{{
-- Keep paste buffer clean
keymap('x', 'p', [["_dP]])
--- delete single character without copying into register
-- keymap('n', 'x', '"_x', opts)

-- WARN: select and move text: this dont work
keymap('v', '<A-j>', ':m .+1<CR>==', opts)
keymap('v', '<A-k>', ':m .-2<CR>==', opts)
-- keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", { opts, desc = 'Move Block Down' })
-- keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", { opts, desc = 'Move Block Up' })

-- Explicitly yank to system clipboard (highlighted and entire row)
-- vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
-- vim.keymap.set('n', '<leader>Y', [["+Y]])

-- Neat X clipboard integration
-- <leader>p will paste clipboard into buffer
-- <leader>c will copy entire buffer into clipboard
keymap('n', '<leader>p', '<cmd>read !wl-paste<cr>')
keymap('n', '<leader>cc', '<cmd>w !wl-copy<cr><cr>')
-- }}}

-- [[ GIT STUFF ]] {{
-- nmap('<leader>fc', '/<<<<CR>', '[F]ind [C]onflicts')
-- nmap('<leader>gcu', 'dd/|||<CR>0v/>>><CR>$x', '[G]it [C]onflict Choose [U]pstream')
-- nmap('<leader>gcb', '0v/|||<CR>$x/====<CR>0v/>>><CR>$x', '[G]it [C]onflict Choose [B]ase')
-- nmap('<leader>gcs', '0v/====<CR>$x/>>><CR>dd', '[G]it [C]onflict Choose [S]tashed')

-- Gets the git history of the visual selection
keymap('v', '<leader>l', ":<c-u>exe ':term git log -L' line(\"'<\").','.line(\"'>\").':'.expand('%')<CR>", opts)
-- }}

-- [[ DIAGNOSTICS ]] {{
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
keymap('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show floating diagnostic [E]rror messages' })
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Show diagnostic [Q]uickfix list' })

-- Toggle diagnostics
local diagnostics_active = true
vim.keymap.set('n', '<leader>dd', function()
  diagnostics_active = not diagnostics_active

  if diagnostics_active then
    vim.diagnostic.enable(0)
  else
    vim.diagnostic.disable(0)
  end
end)
-- }}

-- [[ AUTOCOMMANDS ]] {{
-- [[ HIGHLIGHT YANKED TEXT ]]
-- https://github.com/hendrikmi/dotfiles/blob/main/nvim/lua/core/snippets.lua
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ JUMP TO LAST EDIT POSITION IN FILE ]]
-- https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.lua
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function(ev)
    if vim.fn.line '\'"' > 1 and vim.fn.line '\'"' <= vim.fn.line '$' then
      -- except for in git commit messages
      -- https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
      if not vim.fn.expand('%:p'):find('.git', 1, true) then
        vim.cmd 'exe "normal! g\'\\""'
      end
    end
  end,
})

-- [[ PREVENT ACCIDENTAL WRITES TO BUFFERS THAT SHOULDN'T BE EDITED ]]
vim.api.nvim_create_autocmd('BufRead', { pattern = '*.orig', command = 'set readonly' })
vim.api.nvim_create_autocmd('BufRead', { pattern = '*.pacnew', command = 'set readonly' })
-- leave paste mode when leaving insert mode (if it was on)
vim.api.nvim_create_autocmd('InsertLeave', { pattern = '*', command = 'set nopaste' })
-- help filetype detection (add as needed)
--vim.api.nvim_create_autocmd('BufRead', { pattern = '*.txt', command = 'set filetype=someft' })

-- -- shorter columns in text because it reads better that way
-- local text = vim.api.nvim_create_augroup('text', { clear = true })
-- for _, pat in ipairs { 'text', 'markdown', 'mail', 'gitcommit' } do
--   vim.api.nvim_create_autocmd('Filetype', {
--     pattern = pat,
--     group = text,
--     -- command = 'setlocal spell tw=72 colorcolumn=73',
--     command = 'setlocal spell',
--   })
-- end
-- }}

-- vim.cmd [[
-- nnoremap <A-j> :m .+1<CR>==
-- nnoremap <A-k> :m .-2<CR>==
-- inoremap <A-j> <Esc>:m .+1<CR>==gi
-- inoremap <A-k> <Esc>:m .-2<CR>==gi
-- vnoremap <A-j> :m '>+1<CR>gv=gv
-- vnoremap <A-k> :m '<-2<CR>gv=gv
--
-- tnoremap <esc><esc> <C-\><C-n>
--
-- "Move from shell to other buffer
-- tnoremap <C-w>h <C-\><C-n><C-w>h<CR>
-- tnoremap <C-w>k <C-\><C-n><C-w>k<CR>
-- tnoremap <C-w>j <C-\><C-n><C-w>j<CR>
-- tnoremap <C-w>l <C-\><C-n><C-w>l<CR>
-- tnoremap <C-h> <C-\><C-n><C-w>h<CR>
-- ]]

-- vim: ts=2 sts=2 sw=2 et
