-- [[ Basic Keymaps ]]
--  See `:help keymap()`
-- Weird modes: vblock (x), term (t), cmd mode (c), visual is (v)

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- toggle highlights on searches (`/`)
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- save file without auto-formatting
-- "write no format"
keymap('n', '<leader>wnf', '<cmd>noautocmd w <CR>', { noremap = true, silent = true, desc = '[W]rite [N]o [F]ormat' })

-- change indentation of pasted selection
-- src: https://stackoverflow.com/questions/4312664/is-there-a-vim-command-to-select-pasted-text
--
-- https://stackoverflow.com/questions/4775088/vim-how-to-select-pasted-block
-- nnoremap <leader>p `[V`]
keymap('n', 'gV', '`[V`]', opts)
-- de-indent the recently pasted block
keymap('n', '<leader>[', '`[V`]<', opts)
-- indent the recently pasted block
keymap('n', '<leader>]', '`[V`]>', opts)

-- normal mode switching
keymap('i', 'jk', '<esc>', opts)
keymap('i', 'kj', '<esc>', opts)
keymap('i', 'JK', '<esc>', opts)

keymap('n', 'cu', 'ct_', opts)
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
keymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

--

-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- anti-textwrap
-- keymap('n', 'j', 'gj')
-- keymap('n', 'k', 'gk')
keymap({ 'n', 'v' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap({ 'n', 'v' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- always center search results
keymap('n', 'n', 'nzzzv', { silent = true })
keymap('n', 'N', 'Nzzzv', { silent = true })
keymap('n', '*', '*zz', { silent = true })
keymap('n', '#', '#zz', { silent = true })
keymap('n', 'g*', 'g*zz', { silent = true })

-- center vertical mvmt
keymap('n', '<C-d>', '<C-d>zz', opts)
keymap('n', '<C-u>', '<C-u>zz', opts)

-- -- center search results
-- keymap('n', 'n', 'nzzzv')
-- keymap('n', 'N', 'Nzzzv')

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
--
-- Neat X clipboard integration
-- <leader>p will paste clipboard into buffer
-- <leader>c will copy entire buffer into clipboard
keymap('n', '<leader>p', '<cmd>read !wl-paste<cr>')
keymap('n', '<leader>cc', '<cmd>w !wl-copy<cr><cr>')

-- Save and load session
-- keymap('n', '<leader>ss', ':mksession! .session.vim<CR>', { noremap = true, silent = false })
-- keymap('n', '<leader>sl', ':source .session.vim<CR>', { noremap = true, silent = false })

-- DIAGNOSTICS:
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

-- highlight when yanking (copying) text
-- https://github.com/hendrikmi/dotfiles/blob/main/nvim/lua/core/snippets.lua
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- jump to last edit position on opening file
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
-- prevent accidental writes to buffers that shouldn't be edited
vim.api.nvim_create_autocmd('BufRead', { pattern = '*.orig', command = 'set readonly' })
vim.api.nvim_create_autocmd('BufRead', { pattern = '*.pacnew', command = 'set readonly' })
-- leave paste mode when leaving insert mode (if it was on)
vim.api.nvim_create_autocmd('InsertLeave', { pattern = '*', command = 'set nopaste' })
-- help filetype detection (add as needed)
--vim.api.nvim_create_autocmd('BufRead', { pattern = '*.ext', command = 'set filetype=someft' })

-- shorter columns in text because it reads better that way
local text = vim.api.nvim_create_augroup('text', { clear = true })
for _, pat in ipairs { 'text', 'markdown', 'mail', 'gitcommit' } do
  vim.api.nvim_create_autocmd('Filetype', {
    pattern = pat,
    group = text,
    -- command = 'setlocal spell tw=72 colorcolumn=73',
    command = 'setlocal spell',
  })
end

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
