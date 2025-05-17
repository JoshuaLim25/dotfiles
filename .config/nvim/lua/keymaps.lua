-- NOTE: weird modes — vblock/`<C-v>` (x), term (t), cmd mode/`:` (c), visual (v), visual line (V)
-- o: "operator-pending" mode - when you wait for a motion after an operator like d, y, c (e.g., after pressing d but before a movement)

-- [[ ESSENTIAL ]] {{
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local autocmds = require 'autocommands'

-- [[ NORMAL MODE ]]
keymap('i', 'jk', '<esc>', opts)
keymap('i', 'kj', '<esc>', opts)
keymap('i', 'JK', '<esc>', opts)

-- [[ EASIER KEYBINDS FOR COMMON OPS ]]
keymap('n', 'cu', 'ct_', opts)
keymap('n', 'du', 'dt_', opts)
keymap({ 'n', 'v', 'x', 'o' }, 'H', '^', opts)
keymap({ 'n', 'v', 'x', 'o' }, 'L', '$', opts)
keymap({ 'n', 'v', 'x', 'o' }, '<C-e>', '$%', opts) -- WHY DIDNT I DO THIS EARLIER

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

-- [[ SENSIBLE BEHAVIOR ]]
keymap('n', 'J', 'mzJ`z')

-- [[ GLOBAL SUBSTITUTION ]]
keymap('n', '<leader>su', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)
-- TODO: https://github.com/sheerun/blog/blob/master/_posts/2014-03-21-how-to-boost-your-vim-productivity.markdown#iv-discover-text-search-object

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
-- keymap('x', '<leader>p', [["_dP]])

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
-- credits: TJ Devries
local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win_config = {
    relative = 'editor',
    border = 'rounded',
    style = 'minimal',
    width = width,
    height = height,
    col = col,
    row = row,
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)
  return { buf = buf, win = win }
end

local new_terminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= 'terminal' then
      vim.cmd.terminal()
    end
    -- Start float terminal in insert mode
    vim.api.nvim_set_current_win(state.floating.win)
    vim.cmd 'startinsert!'
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end
vim.api.nvim_create_user_command('NewTerm', new_terminal, {})
vim.keymap.set({ 'n', 't' }, '<space>nt', new_terminal)
-- NOTE: won't work w/tmux :/
-- vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>')
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
keymap('n', '<leader>dj', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
keymap('n', '<leader>dk', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })

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
  -- virtual_text = true, -- this is the floating errors
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}

-- [[ TOGGLE DIAGNOSTICS ]]
local diagnostics_active = true
vim.keymap.set('n', '<leader>td', function()
  diagnostics_active = not diagnostics_active
  -- this only eliminates some
  vim.diagnostic.config {
    virtual_text = diagnostics_active,
    underline = diagnostics_active,
  }
  -- if diagnostics_active then
  --   vim.diagnostic.enable(true)
  -- else
  --   -- vim.diagnostic.enable(false)
  --   vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  -- end
end)
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

-- [[ TEXT ]] {{
-- [[ **BOLD**/*ITALICIZE* SELECTION ]]
keymap('x', '<C-i>', 's*<C-r>"*<Esc>', { noremap = true, silent = true, desc = 'Italicize' })
keymap('x', '<C-b>', 's**<C-r>"**<Esc>', { noremap = true, silent = true, desc = 'Emphasize' })

-- [[ SPELLING ]]
-- TODO:
-- -- Set the keymap to toggle spell checking
-- keymap('n', '<leader>tsp', ':lua toggle_spell()<CR>', { noremap = true, silent = true, desc = '[T]oggle [S][P]ell' })
-- keymap('n', '<leader>tsp', '<cmd>set spell<CR>', { noremap = true, silent = true, desc = '[T]oggle [S][P]ell' })
-- keymap('n', '<leader>tsp', '<cmd>set nospell<CR>', { noremap = true, silent = true, desc = '[T]oggle [S][P]ell' })
keymap('n', '<leader>spc', 'z=', { noremap = true, silent = true, desc = '[S][P]ell auto[C]omplete possible words' })
keymap('n', '<leader>spa', 'zg', { noremap = true, silent = true, desc = '[S][P]ell [A]dd to dictionary' })
keymap('n', '<leader>spd', 'zw', { noremap = true, silent = true, desc = '[S][P]ell [D]elete from dictionary' })

-- [[ CORRECT SPELLING MISTAKES ]]
-- src: https://castel.dev/post/lecture-notes-1/#correcting-spelling-mistakes-on-the-fly
-- Used in conjuction w/builtin C-w
-- keymap('i', '<C-b>', '<c-g>u<Esc>[s1z=gi<c-g>u', opts)

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

-- [[ SET WORKDIR TO FILE YOU'RE EDITING ]]
keymap('n', '<leader>cd', autocmds.change_to_buf_dir, { noremap = true, silent = true, desc = '[C]hange [D]irectory to buffer path' })
-- vim: ts=2 sts=2 sw=2 et
