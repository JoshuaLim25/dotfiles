-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

--  NOTE: shorthand
local o = vim.opt

-- Make line numbers default
o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
o.relativenumber = true

-- tab stuff
o.expandtab = true
o.tabstop = 4
o.shiftwidth = 4

-- visual block cool behavior
o.virtualedit = 'block'
-- "true color support" for terminals like kitty
o.termguicolors = true

-- Enable mouse mode, can be useful for resizing splits for example!
o.mouse = 'a'

-- Set highlight on search, but clear on pressing <Esc> in normal mode
o.hlsearch = true

-- Don't show the mode, since it's already in the status line
o.showmode = false

-- Sync clipboard between OS and Neovim.
--  See `:help 'clipboard'`
o.clipboard = 'unnamedplus'

-- Enable break indent
o.breakindent = true

-- Save undo history
o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
o.ignorecase = true
o.smartcase = true

-- Keep signcolumn on by default
o.signcolumn = 'yes'

-- Decrease update time
o.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
o.timeoutlen = 300

-- Configure how new splits should be opened
o.splitright = true
o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
o.list = true
o.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type
o.inccommand = 'split'

-- Show which line your cursor is on
o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
o.scrolloff = 999
-- was 10

-- Other QOL stuff
o.smartindent = true
o.swapfile = false
o.timeoutlen = 90 -- time to wait for a mapped sequence to complete (in milliseconds)
-- If this many milliseconds nothing is typed the swap file will be written to disk
o.updatetime = 100 -- faster completion (4000ms default)
o.numberwidth = 2 -- set number column width to 2 {default 4}

-- vim: ts=2 sts=2 sw=2 et
