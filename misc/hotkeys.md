# TMUX
- `<prefix>Y` : copy `$(pwd)`
- `<prefix>&` : kill window (with all the panes) 
- `<S-Left>`: move tmux window to left
- `<S-Right>`: move tmux window to right
- `<prefix>space`: freeze frame (modified)
- `<prefix>t`: toggle/switch layouts (modified)
maybe prefix V and H for copying cwd first

---

# VIM
Really been liking `xs` for stuff like `, `
- `q:`: open the "command line window," press enter on command. Up, down work.
- `@`: re-run the most recent command you entered

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
- `@t`: todo, on a newline it'll give you `- [ ] []()`

## PLUGIN-RELATED
### GIT
- `<leader>gj`: next git hunk (next change down)
- `<leader>gk`: prev git hunk (next change up)

---
