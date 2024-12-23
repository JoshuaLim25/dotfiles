# TMUX
- `<prefix>Y` : copy `$(pwd)`
- `<prefix>&` : kill window (with all the panes) 
- `<S-Left>`: move tmux window to left
- `<S-Right>`: move tmux window to right

---

# VIM
- `yc`: "yank copy"
- `<leader>so`: shell output
- `<leader>;`: for the back and forth
- `<leader>v`: select last paste, last yank otherwise

## NAVIGATION
- `<leader>j`: next buffer
- `<leader>k`: prev buffer
- `<leader>db`: delete buffer

## MACROS
- `@f`: formatter, "stuff" -> "- `stuff`"
- *Note*: two below use `gcc`, so comment is required for macro and based on `ft`
- `@h`: config block header, "-- header" -> "-- [[ HEADER ]] {{"
- `@s`: config block subheadings," -- subheader" -> "-- [[ SUBHEADER ]] " 
- `@c`: checklist
    - *Note*: can't actually use insert mode `<C-l>` because of snippet expansion

## PLUGIN-RELATED
### GIT
- `<leader>gj`: next git hunk (next change down)
- `<leader>gk`: prev git hunk (next change up)

---
