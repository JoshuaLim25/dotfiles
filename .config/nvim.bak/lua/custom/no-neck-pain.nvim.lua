return {
  'shortcuts/no-neck-pain.nvim',
  config = function()
    require('no-neck-pain').setup {
      autocmds = {
        enableOnVimEnter = true,
        skipEnteringNoNeckPainBuffer = true, -- disable if you want scratchpad and stuff
      },
      width = 70, -- higher val means smaller buffers
      mappings = {
        enabled = true,
        toggle = '<Leader>tn',
        -- -- Sets a global mapping to Neovim, which allows you to toggle the each side buffer.
        -- toggleLeftSide = '<Leader>nql',
        -- toggleRightSide = '<Leader>nqr',
        -- -- Sets a global mapping to Neovim, which allows you to increase the width (+5) of the main window.
        -- widthUp = '<Leader>n=',
        -- -- Sets a global mapping to Neovim, which allows you to decrease the width (-5) of the main window.
        -- widthDown = '<Leader>n-',
        -- -- Sets a global mapping to Neovim, which allows you to toggle the scratchPad feature.
        -- scratchPad = '<Leader>ns',
      },
      buffers = {
        -- no buffer on the right
        right = {
          enabled = false,
        },

        colors = {
          blend = 0,
        },
        -- no eol chars
        wo = {
          fillchars = 'eob: ',
        },
        -- scratchPad = {
        --   -- set to `false` to disable auto-saving
        --   enabled = false,
        --   -- set to `nil` to default to current working directory
        --   location = '~/Documents/',
        -- },
        -- bo = {
        --   filetype = 'md',
        -- },
      },
      -- colors = {
      --   -- iff `backgroundColor` not present, darken side buffers
      --   blend = -0.2,
      -- },
    }
  end,
}
