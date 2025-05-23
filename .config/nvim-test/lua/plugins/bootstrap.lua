-- MANDATORY READING: https://lazy.folke.io/spec
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim pkg manager
-- Core functionalities: (1) pull a repo with the code, and (2) add it to the rtp (a `;` delimited "$PATH")
-- sharing again: https://lazy.folke.io/spec
require("lazy").setup({
  spec = {
      -- Can EITHER:
    -- { "name/repo", config = function() blah end },  -- mainly for one-offs, prefer returning plugin specs (just a table of plugin-specific config data)
    -- { import = "some.plugin" },  -- looks for `lua/some/plugin/init.lua`, `lua/some/plugin.lua`, `lua/some/plugin/*.lua`
    -- NOTE: not recursive
    { import = "plugins.qol" },
    { import = "plugins.core.colorschemes" },
    { import = "plugins.core" },
  },
  -- install = { colorscheme = { "habamax" } }, -- colorscheme that'll be used when installing plugins.
  -- checker = { enabled = true }, -- automatically check for plugin updates
})
