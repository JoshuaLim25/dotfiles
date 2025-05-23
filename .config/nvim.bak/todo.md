# One day
- [ ] [`fzf` functions](https://github.com/junegunn/fzf/wiki/Examples-(vim))

```lua
-- Set general floating window options
vim.o.winblend = 10  -- transparency for floating windows
vim.o.pumblend = 10  -- transparency for popups
vim.api.nvim_set_hl(0, 'NormalFloat', {bg = 'None'})  -- remove background for floating windows

-- Customize border style for floating windows
vim.o.winborder = 'rounded'  -- Set 'rounded', 'single', 'double', etc.

-- Alternatively, for specific plugin floating windows:
vim.cmd([[autocmd FileType * setlocal winblend=15 pumblend=15]])
```
