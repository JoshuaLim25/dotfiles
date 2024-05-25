-- Setting up keymaps specific to Rust files
local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set('n', '<leader>rr', function()
  vim.cmd.RustLsp 'runnables' -- Run tasks from rust-analyzer
end, { buffer = bufnr, silent = true, noremap = true, desc = '[R]ust [R]unnables' })

vim.keymap.set('n', '<leader>cae', function()
  vim.cmd.RustLsp 'explainError' -- Display examples of ur fuckup
end, { buffer = bufnr, silent = true, noremap = true, desc = '[C]ode [A]ction [E]xamples' })

-- This is shitty `run <bin>` from <leader>rr
-- This should be solved by
-- vim.keymap.set('n', '<leader>ra', function()
--   vim.cmd.RustLsp 'codeAction' -- Use rust-analyzer's grouped code actions
-- end, { buffer = bufnr, silent = true, noremap = true })
--
--
-- This is <leader>cap but ugly
-- vim.keymap.set('n', '<leader>car', function()
--   vim.cmd.RustLsp 'codeAction' -- supports rust-analyzer's grouping
--   -- vim.lsp.buf.codeAction() -- if you don't want grouping.
-- end, { silent = true, buffer = bufnr, desc = '[C]ode [A]ction [R]ust' })
