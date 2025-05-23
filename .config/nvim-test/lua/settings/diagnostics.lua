-- [[ DIAGNOSTICS ]] {{
-- :h vim.diagnostic
local keymap = vim.keymap.set
keymap('n', '<leader>dj', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
keymap('n', '<leader>dk', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
-- [[ TOGGLE DIAGNOSTICS ]]
keymap('n', '<leader>td', function()
    local new_config = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = '[T]oggle [D]iagnostic floating msg' })

vim.fn.sign_define('DiagnosticSignError', { text = '󰅚 ', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '󰀪 ', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '󰋽 ', texthl = 'DiagnosticSignHint' })

-- :h vim.diagnostic.Opts
vim.diagnostic.config {
    underline = { severity = vim.diagnostic.severity.ERROR },
    update_in_insert = false,
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '',
        },
    },
    virtual_text = {
        prefix = '■ ', -- Could be '●', '▎', 'x', '■', ,   ⚙ 🗝
        spacing = 2,
        -- format -- used to customize/filter diag text
    },
    float = {
        -- source = 'if_many'
        border = 'rounded',
        title = 'Diagnostics',
        title_pos = 'left',
        header = '',
    },
}

-- }}
