return {
  'mbbill/undotree',
  -- See https://github.com/mbbill/undotree?tab=readme-ov-file#usage
  -- map('<leader>u', vim.cmd.UndoTreeToggle, 'UndoTreeToggle')
  vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { noremap = true, silent = true }),
}
