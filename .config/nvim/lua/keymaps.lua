-- NOTE: weird modes — vblock (x), term (t), cmd mode (c), visual, meaning `v` and `V,` is (v)

-- [[ ESSENTIAL ]] {{
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- [[ NORMAL MODE ]]
keymap('i', 'jk', '<esc>', opts)
keymap('i', 'kj', '<esc>', opts)
keymap('i', 'JK', '<esc>', opts)

-- [[ EASIER KEYBINDS FOR COMMON OPS ]]
keymap('n', 'cu', 'ct_', opts)
keymap('n', 'du', 'dt_', opts)
keymap({ 'n', 'v', 'x', 'o' }, 'H', '^', opts)
keymap({ 'n', 'v', 'x', 'o' }, 'L', '$', opts)

-- [[ TOGGLE SEARCH HIGHLIGHTS ]]
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- [[ "WRITE NO FORMAT" ]]
keymap('n', '<leader>wnf', '<cmd>noautocmd w <CR>', { noremap = true, silent = true, desc = '[W]rite [N]o [F]ormat' })
-- }}

-- [[ QOL/COOL ]] {{
-- [[ MOVE VISUALLY SELECTED LINES/BLOCKS VERTICALLY ]]
keymap('v', 'J', ":m '>+1<CR>gv=gv", opts)
keymap('v', 'K', ":m '<-2<CR>gv=gv", opts)

-- [[ DUPLICATE A LINE, COMMENT OUT THE ORIGINAL LINE ]]
keymap('n', 'yc', 'yygccp', { remap = true }) -- NOTE: `remap = true` is required

-- [[ STAY IN INDENT MODE ]]
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- [[ INDENT THE RECENTLY PASTED BLOCK ]]
keymap('n', '<leader>]', '`[V`]>', opts)

-- [[ DE-INDENT THE RECENTLY PASTED BLOCK ]]
keymap('n', '<leader>[', '`[V`]<', opts)

-- [[ TYPE SHELL COMMANDS IN A FILE AND EXPAND THE OUTPUT ]]
keymap('n', '<leader>so', ':.!sh<cr>', { noremap = true, desc = '[S]hell [O]utput' })

-- [[ ANTI-TEXTWRAP ]]
keymap({ 'n', 'v' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap({ 'n', 'v' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ EDIT PASTE REGISTER ]]
keymap('n', '<leader>e"', ":<C-U><C-R><C-R>='let @'. v:register .' = '. string(getreg(v:register))<CR><C-F><left>", opts)

-- [[ VERTICAL MVMT ]]
keymap('n', '<C-d>', '<C-d>zz', opts)
keymap('n', '<C-u>', '<C-u>zz', opts)

-- [[ CENTER SEARCH RESULTS ]]
keymap('n', 'n', 'nzzzv', { silent = true })
keymap('n', 'N', 'Nzzzv', { silent = true })
keymap('n', '*', '*zz', { silent = true })
keymap('n', '#', '#zz', { silent = true })
keymap('n', 'g*', 'g*zz', { silent = true })

-- [[ "VERY MAGIC" (LESS ESCAPING NEEDED) REGEXES BY DEFAULT ]]
keymap('n', '?', '?\\v')
keymap('n', '/', '/\\v')
keymap('c', '%s/', '%sm/')
-- }}

-- [[ COPY/PASTE ]] {{
-- [[ KEEP PASTE BUFFER CLEAN ]]
keymap('x', 'p', [["_dP]])

-- [[ DELETE WITHOUT COPYING INTO REGISTER ]]
-- keymap('n', 'x', '"_x', opts) -- WHY: makes it hard to correct small typos (i.e., using `xp`)

-- [[ RE-SELECT MOST RECENT VISUAL HIGHLIGHTED ]]
keymap('n', '<leader>v', '`[V`]', opts)
-- WARN: select and move text: this dont work
-- keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", { opts, desc = 'Move Block Down' })
-- keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", { opts, desc = 'Move Block Up' })

-- [[ NEAT X CLIPBOARD INTEGRATION ]]
keymap('n', '<leader>p', '<cmd>read !wl-paste<cr>') -- paste clipboard into buffer
keymap('n', '<leader>cc', '<cmd>w !wl-copy<cr><cr>') -- copy entire buffer into clipboard

-- [[ EXPLICITLY YANK TO SYSTEM CLIPBOARD (HIGHLIGHTED AND ENTIRE ROW) ]]
-- vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
-- vim.keymap.set('n', '<leader>Y', [["+Y]])
-- }}

-- [[ BUILTIN TERMINAL ]] {{
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- keymap('t', '<leader><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
-- }}

-- [[ GIT STUFF ]] {{
-- nmap('<leader>fc', '/<<<<CR>', '[F]ind [C]onflicts')
-- nmap('<leader>gcu', 'dd/|||<CR>0v/>>><CR>$x', '[G]it [C]onflict Choose [U]pstream')
-- nmap('<leader>gcb', '0v/|||<CR>$x/====<CR>0v/>>><CR>$x', '[G]it [C]onflict Choose [B]ase')
-- nmap('<leader>gcs', '0v/====<CR>$x/>>><CR>dd', '[G]it [C]onflict Choose [S]tashed')

-- GIT HISTORY OF THE VISUAL SELECTION
keymap('v', '<leader>l', ":<c-u>exe ':term git log -L' line(\"'<\").','.line(\"'>\").':'.expand('%')<CR>", opts)

-- }}

-- [[ DIAGNOSTICS ]] {{
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
keymap('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show floating diagnostic [E]rror messages' })
keymap('n', '<leader>qq', vim.diagnostic.setloclist, { desc = '[Q]uickly show my [Q]uickfixes' })
keymap('n', '<leader>ql', vim.diagnostic.setqflist, { desc = 'Send diagnostics to [Q]uickfix [L]ist' })

vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
--    

vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
    linehl = {},
    numhl = {},
  },
  float = {
    source = true,
    border = vim.g.FloatBorders,
    title = 'Diagnostics',
    title_pos = 'left',
    header = '',
  },
  virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}

-- [[ TOGGLE DIAGNOSTICS ]]
local diagnostics_active = true
vim.keymap.set('n', '<leader>dd', function()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.enable(true)
  else
    -- vim.diagnostic.enable(false)
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
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
-- }}

-- [[ BUFFERS ]] {{
keymap('n', '<leader>j', ':bnext<enter>', { noremap = false })
keymap('n', '<leader>k', ':bprev<enter>', { noremap = false })
keymap('n', '<leader>bd', ':bdelete<enter>', { noremap = false })
keymap('n', '<leader>;', ':b#<CR>', { desc = 'Swap to most recently used buffer' }) -- NOTE: <C-6> by default, fuck that.

--  [[ WINDOW/SPLIT NAVIGATION ]]
keymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Switch focus to left window' })
keymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Switch focus to right window' })
keymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Switch focus to lower window' })
keymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Switch focus to upper window' })

-- [[ SELECT ENTIRE BUFFER ]]
keymap('n', 'gG', 'gg<S-v>G', { desc = 'Select all' })

-- [[ PREVENT ACCIDENTAL WRITES TO BUFFERS THAT SHOULDN'T BE EDITED ]]
vim.api.nvim_create_autocmd('BufRead', { pattern = '*.orig', command = 'set readonly' })
vim.api.nvim_create_autocmd('BufRead', { pattern = '*.pacnew', command = 'set readonly' })

-- [[ LEAVE PASTE MODE WHEN LEAVING INSERT MODE (IF IT WAS ON) ]]
vim.api.nvim_create_autocmd('InsertLeave', { pattern = '*', command = 'set nopaste' })

-- [[ FILETYPE DETECTION (ADD AS NEEDED) ]]
--vim.api.nvim_create_autocmd('BufRead', { pattern = '*.txt', command = 'set filetype=someft' })
-- }}

-- [[ SPELLING ]] {{
-- TODO:
-- -- Set the keymap to toggle spell checking
-- keymap('n', '<leader>tsp', ':lua toggle_spell()<CR>', { noremap = true, silent = true, desc = '[T]oggle [S][P]ell' })
-- keymap('n', '<leader>tsp', '<cmd>set spell<CR>', { noremap = true, silent = true, desc = '[T]oggle [S][P]ell' })
-- keymap('n', '<leader>tsp', '<cmd>set nospell<CR>', { noremap = true, silent = true, desc = '[T]oggle [S][P]ell' })
keymap('n', '<leader>spc', 'z=', { noremap = true, silent = true, desc = '[S][P]ell auto[C]omplete possible words' })
keymap('n', '<leader>spa', 'zg', { noremap = true, silent = true, desc = '[S][P]ell [A]dd to dictionary' })
keymap('n', '<leader>spd', 'zw', { noremap = true, silent = true, desc = '[S][P]ell [D]elete from dictionary' })

-- [[ AUTOCORRECT ]]
local abbreviations = {
  teh = 'the',
  recieve = 'receive',
  strcut = 'struct',
  cosnt = 'const',
  ['>>'] = '→',
  ['<<'] = '←',
  ['^^'] = '↑',
  VV = '↓',
}

for from, into in pairs(abbreviations) do
  vim.cmd(string.format('iabbrev %s %s', from, into))
end
-- }}

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
