-- NOTE: YOU SHOULD HAVE THIS PLUGIN.
-- This is equivalent to the following Lua code for passing config opts:
--    require('gitsigns').setup({ ... })
return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '*' },
        untracked = { text = '?' },
        signs_staged_enable = true,
        sign_column = true, -- kinda ruins the pt setting to false lol
        word_diff = false,
        watch_gitdir = {
          follow_files = true,
        },
        auto_attach = true,
        preview_config = {
          style = 'minimal',
          relative = 'editor',
          border = 'rounded',
          width = 80,
          height = 12,
          focusable = true,
        },
      },

      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'
        local function map(mode, lhs, rhs, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- Actions
        map('v', '<leader>gs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage git hunk' })
        map('v', '<leader>gr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset git hunk' })
        map('n', '<leader>gj', gitsigns.next_hunk, { desc = 'Navigate to next hunk' })
        map('n', '<leader>gk', gitsigns.prev_hunk, { desc = 'Navigate to prev hunk' })
        map('n', '<leader>gs', gitsigns.stage_hunk, { desc = '[g]it [s]tage hunk' })
        map('n', '<leader>gS', gitsigns.stage_buffer, { desc = '[g]it [S]tage buffer' })
        map('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = '[g]it [u]ndo stage hunk' })
        -- map('n', '<leader>gd', gitsigns.preview_hunk, { desc = '[g]it preview hunk [d]iff' })
        map('n', '<leader>gd', gitsigns.preview_hunk_inline, { desc = '[g]it preview hunk [d]iff inline' })
        map('n', '<leader>gD', gitsigns.diffthis, { desc = '[g]it [d]iff against index' })
        map('n', '<leader>gr', gitsigns.reset_hunk, { desc = '[g]it [r]eset hunk' })
        map('n', '<leader>gR', gitsigns.reset_buffer, { desc = '[g]it [R]eset buffer' })
        map('n', '<leader>gb', gitsigns.blame_line, { desc = '[g]it [b]lame line' })
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
        map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
      end,
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
