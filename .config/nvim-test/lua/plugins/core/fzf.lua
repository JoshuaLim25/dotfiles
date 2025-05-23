return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    opts = {
        -- ONLY plugin config goes here
        -- winopts = {
        --     height = 0.85,
        --     width = 0.80,
        -- },
    },
    -- https://github.com/ibhagwan/fzf-lua?tab=readme-ov-file#customization
    -- fzf_opts = { ...  },    -- Fzf CLI flags
    -- https://github.com/ibhagwan/fzf-lua?tab=readme-ov-file#insert-mode-completion
    -- TODO: trouble interop - https://github.com/folke/trouble.nvim?tab=readme-ov-file#fzf-lua
    config = function(_, opts)
        local fzf = require("fzf-lua")
        fzf.setup(opts) -- apply the options

        -- helper functions / keymaps
        local keymap = vim.keymap.set
        keymap({ "n", "v", "i" }, "<C-f>", function() fzf.complete_path() end)
        keymap("n", "<leader>ff", function() fzf.files() end, { desc = "[F]ind [F]iles in project directory" })
        keymap("n", "<leader>fg", function() fzf.live_grep() end, { desc = "[F]ind via [G]rep in project directory" })
        keymap("n", "<leader>fH", fzf.helptags, { desc = "[F]ind neovim [H]elp docs" })
        keymap("n", "<leader>fk", fzf.keymaps, { desc = "[F]ind [K]eymaps" })
        keymap("n", "<leader>fb", fzf.builtin, { desc = "[F]ind [B]uiltins offered by fzf" })
        keymap("n", "<leader>fw", fzf.grep_cword, { desc = "[F]ind occurrences of [W]ord on cursor" })
        keymap("n", "<leader>fW", fzf.grep_cWORD, { desc = "[F]ind occurrences of [W]ORD on cursor" })
        keymap("n", "<leader>fd", fzf.diagnostics_document, { desc = "[F]ind [D]iagnostics" })
        keymap("n", "<leader>fr", fzf.resume, { desc = "[F]ind [R]esume" })
        keymap("n", "<leader>fo", fzf.oldfiles, { desc = "[F]ind [O]ld Files" })
        keymap("n", "<leader><leader>", fzf.buffers, { desc = "See existing buffers" })
        keymap("n", "<leader>/", fzf.lgrep_curbuf, { desc = "Grep in current buffer" })
        keymap("n", "<leader>fn", ":FzfDots<CR>", { desc = "Find in dotfiles" })
        keymap("n", "<leader>fN", function() fzf.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find in Neovim config" })

        -- helper commands can go here too
        vim.api.nvim_create_user_command("FzfDots", function()
            fzf.files({ cwd = "$HOME/.dotfiles" })
        end, {})
    end,
}
