return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- WARN: THIS IS IRREPLACEABLE. DO NOT REMOVE.
      -- TODO: https://github.com/echasnovski/mini.ai/blob/main/lua/mini/ai.lua
      local spec_treesitter = require('mini.ai').gen_spec.treesitter
      require('mini.ai').setup {
        n_lines = 500,
        custom_textobjects = {
          F = spec_treesitter { a = '@function.outer', i = '@function.inner' },
          o = spec_treesitter {
            a = { '@conditional.outer', '@loop.outer' },
            i = { '@conditional.inner', '@loop.inner' },
          },
        },
      }

      require('mini.surround').setup { -- No need to copy this inside `setup()`. Will be used automatically.
        -- Add surroundings to be used on *top of builtin ones*.
        -- For more info + examples, see `:h MiniSurround.config`.
        custom_surroundings = {
          -- Saner defaults: for `text`, su< will <text> and su> will < text >
          ['('] = { output = { left = '(', right = ')' } },
          [')'] = { output = { left = '( ', right = ' )' } },
          ['<'] = { output = { left = '<', right = '>' } },
          ['>'] = { output = { left = '< ', right = ' >' } },
          ['{'] = { output = { left = '{', right = '}' } },
          ['}'] = { output = { left = '{ ', right = ' }' } },
          ['['] = { output = { left = '[', right = ']' } },
          [']'] = { output = { left = '[ ', right = ' ]' } },

          -- suh => surrounds target with [[...]], h for "header"
          ['h'] = {
            input = { '%[%[().-()%]%]' },
            output = { left = '[[ ', right = ' ]]' },
          },

          -- -- Use function to compute surrounding info
          -- ['*'] = {
          --   input = function()
          --     local n_star = MiniSurround.user_input 'Number of * to find'
          --     local many_star = string.rep('%*', tonumber(n_star) or 1)
          --     return { many_star .. '().-()' .. many_star }
          --   end,
          --   output = function()
          --     local n_star = MiniSurround.user_input 'Number of * to output'
          --     local many_star = string.rep('*', tonumber(n_star) or 1)
          --     return { left = many_star, right = many_star }
          --   end,
          -- },
        },

        custom_textobjects = nil,

        -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
        highlight_duration = 500,

        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          -- Main textobject prefixes
          around = 'a',
          inside = 'i',

          -- Next/last variants
          around_next = 'an',
          inside_next = 'in',
          around_last = 'al',
          inside_last = 'il',

          -- "Modifiers"
          add = 'su', -- Add surrounding in Normal and Visual modes
          delete = 'sd', -- Delete surrounding
          find = 'sf', -- Find surrounding (to the right)
          find_left = 'sF', -- Find surrounding (to the left)
          highlight = 'sh', -- Highlight surrounding
          replace = 'sr', -- Replace surrounding
          update_n_lines = 'sn', -- Update `n_lines`

          suffix_last = 'l', -- Suffix to search with "prev" method
          suffix_next = 'n', -- Suffix to search with "next" method
        },

        -- Number of lines within which surrounding is searched
        n_lines = 20,

        -- Whether to respect selection type:
        -- - Place surroundings on separate lines in linewise mode.
        -- - Place surroundings on each line in blockwise mode.
        respect_selection_type = false,

        -- How to search for surrounding (first inside current line, then inside
        -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
        -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
        -- see `:h MiniSurround.config`.
        -- search_method = 'cover',
        search_method = 'cover_or_next',

        -- Whether to disable showing non-error feedback
        silent = false,
      }

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin

      -- NOTE: COMMENTED OUT:
      -- local statusline = require 'mini.statusline'
      -- -- set use_icons to true if you have a Nerd Font
      -- statusline.setup { use_icons = vim.g.have_nerd_font }

      -- -- You can configure sections in the statusline by overriding their
      -- -- default behavior. For example, here we set the section for
      -- -- cursor location to LINE:COLUMN
      -- ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function()
      --   return '%2l:%-2v'
      -- end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
