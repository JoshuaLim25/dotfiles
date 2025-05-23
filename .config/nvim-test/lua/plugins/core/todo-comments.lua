  return {
    "folke/todo-comments.nvim",
    opts = {
      -- Show todo comments in the sign column but don't highlight the text
      highlight = {
        -- keyword = '',
        after = '',
      },
      signs = false, -- in sign column
      keywords = {
        FIX = {
          icon = " ",
          color = "error",
          alt = { "FIXME", "FIXIT", "BUG", "ISSUE", "DEBUG" },
        },
        TODO = { icon = " ", color = "info", },
        INFO = { icon = " ", color = "info", alt = { } },
        NOTE = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", color = "hint", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        SAFETY = { icon = "󰌾 ", color = "info", alt = { "SECURITY", "SECURE" } },
      },
    },
  }
