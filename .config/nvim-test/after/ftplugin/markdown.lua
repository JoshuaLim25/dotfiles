-- NOTE: can just do `:e` to source after/ftplugin files
-- [[ **BOLD**/*ITALICIZE* SELECTION/WORD ]]
local keymap = vim.keymap.set
keymap('x', '<C-i>', 's*<C-r>"*<Esc>', { noremap = true, silent = true, desc = 'Italicize Selected Text' })
keymap('n', '<C-i>', 'diwi*<Esc>pa*<Esc>', { noremap = true, silent = true, desc = 'Italicize Word Cursor Hovers Over' })
keymap('x', '<C-b>', 's**<C-r>"**<Esc>', { noremap = true, silent = true, desc = 'Emphasize Selected Text' })
keymap('n', '<C-b>', 'diwi**<Esc>pa**<Esc>', { noremap = true, silent = true, desc = 'Emphasize Word Cursor Hovers Over' })

