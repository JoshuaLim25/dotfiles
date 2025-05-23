return {
    'nvim-treesitter/nvim-treesitter',
    build = { ":TSUpdate" },
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
        require('nvim-treesitter.install').prefer_git = true,
        -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#modules
        require'nvim-treesitter.configs'.setup {
            ensure_installed = { "go", "bash", "cpp", "diff", "c", "lua", "vim", "vimdoc", "markdown", "markdown_inline", "gitcommit", "git_rebase", "gitattributes", "gitignore", "rust", "python", "html", "css", "yaml", "json", "toml", "dockerfile", "make", "sql" },
            sync_install = false,
            auto_install = false,
            -- ignore_install = { "javascript" },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<leader>ss", -- set to `false` to disable one of the mappings
                    node_incremental = "<leader>si",
                    node_decremental = "<leader>sd",
                    -- scope_incremental = "grc",
                },
            },
            highlight = {
                enable = true,  -- set to false disables entire extension (so don't)
                -- https://github.com/kiyoon/dotfiles/blob/master/nvim/lua/kiyoon/treesitter.lua#L93
                -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
                -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
                -- the name of the parser)
                -- disable = { "python", "lua" }, -- list of languages that will be disabled
                -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
                disable = function(lang, buf)
                    local disable_langs = { "python", "javascript", "typescript" }
                    -- For python etc. disable treesitter highlighting in favour of LSP semantic highlighting.
                    -- However, we still want treesitter syntax highlighting for floating windows and injections.
                    if vim.list_contains(disable_langs, lang) then

                        -- if the buffer is a floating window, enable treesitter
                        if vim.bo[buf].buftype == "nofile" then
                            return false
                        end

                        -- -- if the file extension is .ju.py, enable treesitter
                        -- if vim.api.nvim_buf_get_name(buf):match("%.ju%.py$") then
                        --     return false
                        -- end

                        return true
                    end
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                additional_vim_regex_highlighting = { "gitcommit", "ruby" },
            },
            indent = {
                -- enable = false,
                enable = true,
                disable = { 'yaml' }
            },
            matchup = {
                enable = true,
            },

            -- TEXTOBJS
            -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects?tab=readme-ov-file#text-objects-select
            -- keys are treated as targets for operator-pending or visual mode commands, meaning doing stuff like dap and vap (native textobjects would be aw, iw, ap, etc). Treesitter just adds semantic-aware ones.
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        -- https://github.com/kiyoon/dotfiles/blob/4a8254047225b1ebf956fbe96bc7546ca242f5ec/nvim/lua/kiyoon/treesitter.lua#L140
                        -- Just do <leader>i on a word or :InspectTree
                        -- this stuff is fucking crazy. you can make your own ones
                        -- based on what treesitter knows too: https://github.com/nvim-treesitter/nvim-treesitter-textobjects?tab=readme-ov-file#overriding-or-extending-textobjects
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["aF"] = "@call.outer",
                        ["iF"] = "@call.inner",
                        ["ia"] = { query = "@parameter.inner", desc = "I love life" },
                        ["a/"] = "@comment.outer",
                        ["in"] = "@number.inner",
                        ["aa"] = "@parameter.outer",
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                        ["ik"] = "@block.inner",  -- dik
                        ["ak"] = "@block.outer",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        -- ["i="] = "@assignment.inner",
                        -- ["a="] = "@assignment.outer",
                        ["as"] = { query = "@scope", query_group = "locals", desc = "Select big ass language scope" }
                    },
                    include_surrounding_whitespace = true,
                },
                swap = {
                    enable = true,
                    swap_next = {
                        [")m"] = "@function.outer",
                        [")a"] = "@parameter.inner", --
                        [")c"] = "@comment.outer",
                        [")b"] = "@block.outer",
                        [")l"] = "@class.outer",
                        [")s"] = "@statement.outer",
                        [")A"] = "@attribute.outer",
                    },
                    swap_previous = {
                        ["(m"] = "@function.outer",
                        ["(a"] = "@parameter.inner",
                        ["(c"] = "@comment.outer",
                        ["(b"] = "@block.outer",
                        ["(l"] = "@class.outer",
                        ["(s"] = "@statement.outer",
                        ["(A"] = "@attribute.outer",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]f"] = "@function.outer",
                        -- ["]c"] = "@class.outer",
                        -- ["]k"] = "@block.outer",
                        -- ["]a"] = "@parameter.inner",
                        -- ["]s"] = { query = "@scope", query_group = "locals"},
                    },
                    goto_next_end = {
                        ["]F"] = "@function.outer",
                        -- ["]C"] = "@class.outer",
                        -- ["]K"] = "@block.outer",
                        -- ["]A"] = "@parameter.inner",
                        -- ["]S"] = { query = "@scope", query_group = "locals"},
                    },
                    goto_previous_start = {
                        ["[f"] = "@function.outer",
                        -- ["[c"] = "@class.outer",
                        -- ["[k"] = "@class.outer",
                        -- ["[a"] = "@parameter.inner",
                        -- ["[s"] = { query = "@scope", query_group = "locals"},
                    },
                    goto_previous_end = {
                        ["[F"] = "@function.outer",
                        -- ["[C"] = "@class.outer",
                        -- ["[K"] = "@class.outer",
                        -- ["[A"] = "@parameter.inner",
                        -- ["[S"] = { query = "@scope", query_group = "locals"},
                    },
                },
            },  -- TEXTOBJS
        } -- setup
    end,
    opts = {},
}

--  @block.inner
--  @block.outer
--  @call.inner
--  @call.outer
--  @class.inner
--  @class.outer
--  @comment.outer
--  @conditional.inner
--  @conditional.outer
--  @frame.inner
--  @frame.outer
--  @function.inner
--  @function.outer
--  @loop.inner
--  @loop.outer
--  @parameter.inner
--  @parameter.outer
--  @scopename.inner
--  @statement.outer
