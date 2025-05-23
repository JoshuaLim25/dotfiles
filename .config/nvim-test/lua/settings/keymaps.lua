-- NOTE: weird modes — vblock/`<C-v>` (x), term (t), cmd mode/`:` (c), visual (v), visual line (V)
-- o: "operator-pending" mode - when you wait for a motion after an operator like d, y, c (e.g., after pressing d but before a movement)
-- INFO: vim.keymap.set({mode}, {lhs}, {rhs}, {opts}), `lhs` = input, `rhs` = cmd

-- [[ ESSENTIAL ]] {{
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local autocmds = require('settings.autocommands')

-- [[ NORMAL MODE ]]
keymap('i', 'jk', '<esc>', opts)
keymap('i', 'kj', '<esc>', opts)
keymap('i', 'JK', '<esc>', opts)

-- [[ EASIER KEYBINDS FOR COMMON OPS ]]
keymap('n', 'cu', 'ct_', opts)
keymap('n', 'du', 'dt_', opts)
keymap('x', ',', 't,', opts) -- TODO: get f, F behavior w/; and ,
keymap('x', '.', 't.', opts)
keymap({ 'n', 'v', 'x', 'o' }, 'H', '^', opts)
keymap({ 'n', 'v', 'x', 'o' }, 'L', '$', opts)
keymap({ 'n', 'v', 'x', 'o' }, '<C-e>', '$%', opts) -- WHY DIDNT I DO THIS EARLIER
keymap('n', '<leader>e', 'q:', { noremap = true, silent = true, desc = '[E]dit commands in cmd line window' })

-- [[ "WRITE NO FORMAT" ]]
keymap('n', '<leader>wnf', ':noautocmd w <CR>', { noremap = true, silent = true, desc = '[W]rite [N]o [F]ormat' })
-- }}

-- [[ QOL/COOL ]] {{
-- [[ QUICK ITERATIONS WHEN TESTING CONFIG ]]
vim.keymap.set('n', '<leader>S', ':source %<CR> | :lua print("Sourced")<CR>', { desc = '[R]eload file' })
-- Will refresh the buffer from disk, discarding any unsaved changes, or lets you make sure that you have the latest version of the file as saved on disk.
-- vim.keymap.set('n', '<leader>R', ':w<cr>:e!<cr>', { desc = '[R]efresh' })

-- [[ MOVE VISUALLY SELECTED LINES/BLOCKS VERTICALLY ]]
keymap('v', 'J', ":m '>+1<CR>gv=gv", opts)
keymap('v', 'K', ":m '<-2<CR>gv=gv", opts)

-- [[ DUPLICATE A LINE, COMMENT OUT THE ORIGINAL LINE ]]
keymap('n', 'yc', 'yygccp', { remap = true }) -- NOTE: `remap = true` is required

-- [[ SENSIBLE BEHAVIOR ]]
keymap('n', 'J', 'mzJ`z')
keymap('x', 'I', function()
  return vim.fn.mode() == 'V' and '^<C-v>I' or 'I'
end, { expr = true })
keymap('x', 'A', function()
  return vim.fn.mode() == 'V' and '$<C-v>A' or 'A'
end, { expr = true })

-- [[ GLOBAL SUBSTITUTION ]]
keymap('n', '<leader>su', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)
keymap('v', '<leader>_', ":<C-U>keeppatterns '<,'>s/\\%V[ -]/_/g<CR>", opts)

-- [[ SET WORKDIR TO FILE YOU'RE EDITING ]]
keymap('n', '<leader>cd', autocmds.change_to_buf_dir, { noremap = true, silent = true, desc = '[C]hange [D]irectory to current buffer path' })
-- keymap('n', '<leader>cd', ':lcd %:p:h<CR>:pwd<CR>', { desc = 'cd into directory of the currently open buffer' })

-- [[ DOCS AND TYPE INFO ]]
-- WARNING: GOATED
keymap('n', '<leader>fh', ':help <C-r><C-w><CR>', { desc = '[F]ind [H]elp for word under cursor' })
keymap('n', '<leader>i', ':Inspect<CR>', { desc = '[I]nspect word under cursor' })

-- TODO: https://github.com/sheerun/blog/blob/master/_posts/2014-03-21-how-to-boost-your-vim-productivity.markdown#iv-discover-text-search-object

-- [[ STAY IN INDENT MODE ]]
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

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

-- [[ NO MORE ESCAPING SPECIAL CHARS IN SEARCH ]]
-- INFO: `\V` (Very nomagic) treats almost everything as literal, whereas `\v` (very magic) treats almost everything as special (which is best for regex-heavy use).
keymap('n', '?', '?\\V')
keymap('n', '/', '/\\V')
keymap('c', '%s/', '%sm/') -- easier regexes

-- keymap('n', '?', '?\\v')
-- keymap('n', '/', '/\\v')
-- keymap('c', '%s/', '%sm/')

-- }}

-- [[ TOGGLES ]] {{
-- [[ TOGGLE SEARCH HIGHLIGHTS ]]
keymap('n', '<Esc>', ':nohlsearch<CR>', opts)

-- [[ TOGGLE ROOT FOR OPS ]]
-- TODO: fix search behavior
-- HELP: file-searching,
-- :help finddir and :help fnamemodify
local function get_git_root()
  local dot_git_path = vim.fn.finddir('.git', '.;')
  return vim.fn.fnamemodify(dot_git_path, ':h')
end
vim.keymap.set('n', '<leader>tr', function()
  local new = get_git_root()
  vim.api.nvim_set_current_dir(get_git_root())
  vim.notify(string.format('Changed root to: %s', new))
end, {})

-- vim.keymap.set('n', '<leader>tr', function()
--   vim.g.use_git_root = not vim.g.use_git_root
--   local cwd = vim.g.use_git_root and vim.fs.root(0, '.git') or vim.uv.cwd()
--   vim.notify(string.format('New root: %s', cwd))
-- end)

-- vim.keymap.set('n', '<leader>tr', function()
--   vim.g.use_git_root = not vim.g.use_git_root
--   local new_root = vim.g.use_git_root and vim.fs.root(0, '.git') or vim.uv.cwd()
--   if new_root then
--     vim.api.nvim_set_current_dir(new_root)
--     vim.notify(string.format('Changed root to: %s', new_root))
--   else
--     vim.notify('Could not find a viable `.git` root, aborting...', vim.log.levels.ERROR)
--   end
-- end)

-- -- Example of above root toggle for Telescope
-- require('telescope.builtin').find_files {
--   cwd = vim.g.use_git_root and vim.fs.dirname(git_root) or nil,
-- }

-- [[ TOGGLE FORMATTING ]]
vim.keymap.set('n', '<leader>tf', function()
  vim.b.disable_formatting = not vim.b.disable_formatting
  local res = vim.b.disable_formatting and 'Disabled' or 'Enabled'
  vim.notify(string.format('%s autoformat on save', res))
end, { desc = 'Format: Toggle format on save' })
-- }}

-- [[ COPY/PASTE ]] {{
-- [[ KEEP PASTE BUFFER CLEAN ]]
-- keymap('x', '<leader>p', [["_dP]])

-- [[ DELETE WITHOUT COPYING INTO REGISTER ]]
-- keymap('n', 'x', '"_x', opts) -- WHY: makes it hard to correct small typos (i.e., using `xp`)
-- TODO: from https://github.com/seblyng/dotfiles/blob/06f6ddf292da0f61636faf9d1f3c6e9e3f371e1f/nvim/lua/seblyng/keymaps.lua
-- vim.keymap.set({ "n", "x" }, "<leader>d", '"_d', { desc = "Delete into black hole register" })
-- vim.keymap.set({ "n", "x" }, "<leader>c", '"_c', { desc = "Change into black hole register" })

-- vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Delete into black hole register on visual paste" })

-- [[ RE-SELECT MOST RECENT VISUAL HIGHLIGHTED ]]
keymap('n', '<leader>v', '`[V`]', opts)

-- [[ NEAT X CLIPBOARD INTEGRATION ]]
keymap('n', '<leader>p', ':read !wl-paste<cr>') -- paste clipboard into buffer
keymap('n', '<leader>cc', ':w !wl-copy<cr><cr>') -- copy entire buffer into clipboard

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

local function create_floating_window(options)
  options = options or {}
  local width = options.width or math.floor(vim.o.columns * 0.8)
  local height = options.height or math.floor(vim.o.lines * 0.8)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf = nil
  if vim.api.nvim_buf_is_valid(options.buf) then
    buf = options.buf
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


-- [[ BUFFERS ]] {{
keymap('n', '<leader>j', ':bnext<enter>', { noremap = false, silent = true })
keymap('n', '<leader>k', ':bprev<enter>', { noremap = false, silent = true })
keymap('n', '<leader>bd', ':bdelete<enter>', { noremap = false, silent = true })
keymap('n', '<leader>;', ':b#<CR>', { silent = true, desc = 'Swap to most recently used buffer' }) -- NOTE: <C-6> by default, fuck that.

--  [[ WINDOW/SPLIT NAVIGATION ]]
keymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Switch focus to left window' })
keymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Switch focus to right window' })
keymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Switch focus to lower window' })
keymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Switch focus to upper window' })

-- [[ SELECT ENTIRE BUFFER ]]
keymap('n', 'gG', 'gg<S-v>G', { desc = 'Select all' })

-- [[ TEXT ]] {{
-- [[ SPELLING ]]
-- TODO:
-- -- Set the keymap to toggle spell checking
-- keymap('n', '<leader>tsp', ':lua toggle_spell()<CR>', { noremap = true, silent = true, desc = '[T]oggle [S][P]ell' })
-- keymap('n', '<leader>tsp', ':set spell<CR>', { noremap = true, silent = true, desc = '[T]oggle [S][P]ell' })
-- keymap('n', '<leader>tsp', ':set nospell<CR>', { noremap = true, silent = true, desc = '[T]oggle [S][P]ell' })
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
-- vim: ts=2 sts=2 sw=2 et
