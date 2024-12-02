return {
  'folke/trouble.nvim',

  -- vim.keymap.set('n', '<leader>tt', '<cmd>TroubleToggle<cr>'),
  -- vim.keymap.set('n', '<leader>tw', '<cmd>TroubleToggle workspace_diagnostics<cr><cmd>TroubleToggle workspace_diagnostics<cr>'),
  -- vim.keymap.set('n', '<leader>td', '<cmd>TroubleToggle workspace_diagnostics<cr><cmd>TroubleToggle document_diagnostics<cr>'),
  -- vim.keymap.set('n', '<leader>tq', '<cmd>TroubleToggle workspace_diagnostics<cr><cmd>TroubleToggle quickfix<cr>'),
  -- vim.keymap.set('n', '<leader>tl', '<cmd>TroubleToggle workspace_diagnostics<cr><cmd>TroubleToggle loclist<cr>'),
  -- vim.keymap.set('n', '<leader>tr', '<cmd>TroubleToggle workspace_diagnostics<cr><cmd>TroubleToggle lsp_references<cr>'),

  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = 'Trouble',
  keys = {
    {
      '<leader>xx',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>xX',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },
    {
      '<leader>cs',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Symbols (Trouble)',
    },
    {
      '<leader>cl',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'LSP Definitions / references / ... (Trouble)',
    },
    {
      '<leader>xL',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List (Trouble)',
    },
    {
      '<leader>xQ',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix List (Trouble)',
    },
  },
}
