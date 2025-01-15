-- NOTE: for autocorrect, see ../../lua/keymaps.lua, `:220` ish
-- some ideas from: https://github.com/Piotr1215/youtube/blob/main/nvim-markdown/slides.md#use-ftplugin-for-configuration

-- [[ BASICS ]] {{
-- NOTE: as with any filetype-specific config files, this is local to Markdown
-- [[ SPELLING ]]
vim.cmd 'setlocal spell spelllang=en_us'

-- [[ QOL MD KEYBINDS ]]
vim.keymap.set('n', '<leader>l', '^I-<Space>[<Space>]<Space><Esc>', { remap = true, silent = false, desc = 'Markdown list' })

function MarkdownCodeBlock(outside)
  vim.cmd "call search('```', 'cb')"
  if outside then
    vim.cmd 'normal! Vo'
  else
    vim.cmd 'normal! j0Vo'
  end
  vim.cmd "call search('```')"
  if not outside then
    vim.cmd 'normal! k'
  end
end
-- }}
