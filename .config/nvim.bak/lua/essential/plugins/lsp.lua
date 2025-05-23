return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependents
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          --
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>dt', require('telescope.builtin').lsp_type_definitions, '[D]efinition of [T]ype ')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>cap', vim.lsp.buf.code_action, '[C]ode [A]ction [P]ick')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap.
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('<leader>da', vim.lsp.buf.declaration, 'Goto [D]eclar[a]tion')
          map('<leader>de', vim.lsp.buf.definition, 'Goto [D][e]finition')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following autocommand is used to enable inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map('<leader>th', function()
              local bufnr = vim.api.nvim_get_current_buf() -- Get the current buffer number
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
            end, '[T]oggle Inlay [H]ints')

            -- if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            -- map('<leader>th', function()
            --   vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            -- end, '[T]oggle Inlay [H]ints')
          end

          -- [[ Disable LSP semantic token highlighting ]] {{
          -- client.server_capabilities.semanticTokensProvider = nil
          -- NOTE: Prevent LSP from overwriting treesitter color settings
          -- https://github.com/NvChad/NvChad/issues/1907
          vim.highlight.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level
          -- }}

          -- [[ Hover window with rounded borders ]] {{
          vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
          -- }}

          -- [[ Toggle LSP Diagnostics ]] {{
          -- BUG: something's fishy, use <leader>dd, in ../../keymaps.lua
          -- local diagnostics_active = true
          -- vim.keymap.set('n', '<leader>td', function()
          --   diagnostics_active = not diagnostics_active
          --   if diagnostics_active then
          --     vim.diagnostic.show()
          --   else
          --     vim.diagnostic.hide()
          --   end
          -- end)
          -- }}

          -- vim.keymap.set('n', keys, func, { desc = desc })
          vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = '[W]orkspace [A]dd Folder' })
          vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = '[W]orkspace [R]emove Folder' })
          vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, { desc = '[W]orkspace [L]ist Folders' })

          vim.keymap.set('n', '<leader>R', '<cmd>w<cr><cmd>e!<cr>', { desc = '[R]efresh' })

          -- [[ RUFF ALONGSIDE ANOTHER LSP ]]
          -- https://docs.astral.sh/ruff/editors/setup/#neovim
          vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
            callback = function(args)
              local ruff_client = vim.lsp.get_client_by_id(args.data.client_id)
              if ruff_client == nil then
                return
              end
              if ruff_client.name == 'ruff' then
                -- Disable hover in favor of Pyright
                ruff_client.server_capabilities.hoverProvider = false
              end
            end,
            desc = 'LSP: Disable hover capability from Ruff',
          })

          -- NOTE: i found this too incessant
          -- -- [[ LSP SIGNATURE HELP ]]
          -- vim.api.nvim_create_autocmd('CursorMovedI', {
          --   buffer = event.buf,
          --   callback = function()
          --     vim.lsp.buf.signature_help()
          --   end,
          -- })

          -- NOTE: END OF AUTOCOMMANDS
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      --  Available override configuration keys in the following tables:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --  - other options for LSP, like `lua_ls`: https://luals.github.io/wiki/settings/
      local servers = {
        clangd = {},
        -- rust_analyzer = { cmd = { 'rustup', 'run', 'stable', 'rust-analyzer' } },
        rust_analyzer = {
          -- cmd = { '/home/josh/.cargo/bin/rust-analyzer' }, -- Path to the system-installed rust-analyzer
          filetypes = { 'rust' },
          cargo = {
            allFeatures = true,
          },
          imports = {
            group = {
              enable = false,
            },
          },
          completion = {
            postfix = {
              enable = false,
            },
          },
          check = {
            command = 'clippy',
          },
        },
        -- [[ PYTHON ]] {{
        -- https://www.reddit.com/r/neovim/comments/1cpkeqd/help_needed_with_python_lsp/
        -- pyright = {},
        basedpyright = {
          enabled = true,
          settings = {
            disableOrganizeImports = true,
            basedpyright = {
              analysis = {
                -- ignore = { "*" },
                typeCheckingMode = 'standard',
                -- diagnosticMode = 'openFilesOnly',
                diagnosticMode = 'workspace',
                useLibraryCodeForTypes = true,
                autoSearchPaths = true,
              },
            },
          },
        },
        -- pylsp = {
        --   settings = {
        --     pylsp = {
        --       plugins = {
        --         pyflakes = { enabled = false },
        --         pycodestyle = { enabled = false },
        --         autopep8 = { enabled = false },
        --         yapf = { enabled = false },
        --         mccabe = { enabled = false },
        --         pylsp_mypy = { enabled = false },
        --         pylsp_black = { enabled = false },
        --         pylsp_isort = { enabled = false },
        --       },
        --     },
        --   },
        -- },
        mypy = {},
        ruff = {},
        -- }}

        bashls = {}, -- `bash-language-server` for mason, nvim uses greyed-out name
        dockerls = {},
        gopls = {},
        -- jdtls = {},

        -- tsserver = {},
        -- NOTE: useful to look at - https://github.com/pmizio/typescript-tools.nvim

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
        'clangd',
        -- 'rust_analyzer',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        -- { PATH = 'append' },
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
