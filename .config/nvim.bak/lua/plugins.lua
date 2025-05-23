-- [[ BOOTSTRAP `lazy.nvim` PLUGIN MANAGER ]] {{
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
-- }}

-- [[ PLUGIN CONFIG AND INSTALL ]] {{
require('lazy').setup({
  -- NOTE: you can add in other plugins with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  -- INFO: can also add them using a table, with the first argument being the link
  -- and the following keys being used to configure plugin behavior/loading/etc.
  -- INFO: Use `opts = {}` to force a plugin to be loaded.
  -- This would be EQUIVALENT to `require('Comment').setup({})`
  { 'numToStr/Comment.nvim', opts = {} },

  -- Include plugin definition from file `lua/path/name.lua`
  require 'essential/plugins/gitsigns',
  require 'essential/plugins/telescope',
  require 'essential/plugins/lsp',
  require 'essential/plugins/conform',
  require 'essential/plugins/cmp',
  require 'essential/plugins/todo-comments',
  require 'essential/plugins/mini',
  require 'essential/plugins/treesitter',
  require 'essential/plugins/which-key',
  require 'essential/plugins/lint',
  require 'essential/plugins/autopairs',
  -- [[ COLORSCHEMES ]] {{
  -- require 'essential/plugins/colorschemes/kanagawa.lua',
  -- require 'essential/plugins/colorschemes/handmade-hybrid.lua',
  -- require 'essential/plugins/colorschemes/kanagawa-handmade.lua',
  -- require 'essential.plugins.colorschemes.kanagawa_main',
  require 'essential.plugins.colorschemes.sexy',
  -- }}
  -- NOTE: NOT USING CURRENTLY, but **remember to uncomment
  -- them after changing from .bak -> .lua**
  -- require 'essential.plugins.neo-tree',
  -- require 'essential.plugins.indent_line',
  -- require 'essential.plugins.debug',

  -- modularize everything
  { import = 'custom' },
}, {
  ui = {
    border = 'rounded', -- You can also try 'single', 'double', or 'solid'
  },
})
-- }}

-- vim: ts=2 sts=2 sw=2 et
