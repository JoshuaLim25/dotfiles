-- Relevant help pages - `:help vim.opt`, `:help option-list`
--  NOTE: shorthand
local o = vim.opt

-- [[ ESSENTIAL ]] {{
-- sync os clipboard with nvim
o.clipboard = 'unnamedplus'
-- visual block mode cool behavior
o.virtualedit = 'block'
-- "true color support" (24-bit color instead of 16) for terminals like kitty
o.termguicolors = true
-- never ever make my terminal beep
o.vb = true
-- enable mouse mode
o.mouse = 'a'
-- already in the status line
o.showmode = false
o.backspace = 'indent,eol,start' -- allow backspace on
o.pumheight = 10 -- pop up menu height
o.conceallevel = 0 -- so that `` is visible in markdown files
-- o.fileencoding = 'utf-8' -- the encoding written to a file
-- o.autoindent = true -- copy indent from current line when starting new one
-- o.formatoptions:remove { 'c', 'r', 'o' } -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
-- }}

-- [[ LINE NUMBERS ]] {{
o.number = true
o.relativenumber = true
-- }}

-- [[ TAB STUFF ]] {{
o.expandtab = true -- tabs -> spaces
o.numberwidth = 1 -- set number column width to 2 {default 4}
o.shiftwidth = 4 -- the number of spaces inserted for each indentation
o.tabstop = 4 -- insert n spaces for a tab
o.softtabstop = 4 -- Number of spaces that a tab counts for while performing editing operations
-- }}

-- [[ LINE WRAP ]] {{
o.wrap = true -- false makes long long lines go offscreen
-- o.sidescrolloff = 8 -- minimal number of screen columns either side of cursor (if wrap is `false`)
o.linebreak = true -- companion to wrap, don't split words
o.breakindent = true -- enabling will ,keep lines visually indented (same amount of space as the beginning of that line), thus preserving horizontal blocks of text.
-- o.whichwrap = 'bs<>[]hl' -- which "horizontal" keys you allow to goto prev/next line
-- }}

-- [[ MORE USEFUL DIFFS ]] {{
--- by ignoring whitespace
o.diffopt:append 'iwhite'
--- and using a smarter algorithm
--- https://vimways.org/2018/the-power-of-diff/
--- https://stackoverflow.com/questions/32365271/whats-the-difference-between-git-diff-patience-and-git-diff-histogram
--- https://luppeng.wordpress.com/2020/10/10/when-to-use-each-of-the-git-diff-algorithms/
o.diffopt:append 'algorithm:histogram'
o.diffopt:append 'indent-heuristic'
-- }}

-- [[ SEARCHING ]] {{
-- highlight on search, clear on pressing <Esc> in normal mode
o.hlsearch = true
-- case-insensitive searching unless \C or one or more capital letters in the search term
o.ignorecase = true
o.smartcase = true
-- preview substitutions live, as you type
o.inccommand = 'split'
o.iskeyword:append '-' -- hyphenated words recognized by searches
-- }}

-- [[ FILES, BUFFERS ]] {{
o.swapfile = false
-- decrease update time (for swap file to be written to disk, default 4000ms)
-- o.updatetime = 250
o.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
o.splitright = true
o.splitbelow = true
-- save undo history
o.undofile = true -- NOTE: default undodir in `~/.local/state/nvim/undo/` or `~/.local/share/nvim/undo/`
-- }}

-- [[ VISUAL STUFF ]] {{
-- keep signcolumn on by default
o.signcolumn = 'yes'
-- show which line your cursor is on
o.cursorline = true
-- minimal number of screen lines to keep above and below the cursor (default 0, was 10 before)
o.scrolloff = 999
-- sets how neovim will display certain whitespace characters in the editor.
o.list = true
o.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
-- }}

-- [[ QOL ]] {{
o.smartindent = true
-- this opt changes the hanging jk, lower values (~100)
-- means you need to be faster but it's not annoying
o.timeoutlen = 150 -- time to wait for a mapped sequence to complete (in milliseconds)
-- o.timeoutlen = 125 -- time to wait for a mapped sequence to complete (in milliseconds)
o.updatetime = 100 -- faster completion (4000ms default)
o.completeopt = 'menuone,noselect' -- better completion
-- }}

-- [[ SET BORDER STYLE FOR FLOATING WINDOWS (GLOBAL) ]] {{
-- vim.o.winborder = 'rounded' -- Can be 'none', 'single', 'double', 'rounded', etc.
-- vim.o.pumblend = 10 -- Set transparency for popup menu
-- vim.o.winblend = 10 -- Set transparency for floating windows
-- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'None' }) -- Make background transparent
-- }}

-- vim: ts=2 sts=2 sw=2 et
