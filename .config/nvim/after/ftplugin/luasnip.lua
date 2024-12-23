-- https://www.youtube.com/watch?v=FmHhonPjvvA
-- https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
-- see https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#lua
local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- `add_snippets` accepts (filetype, { table_of_snippets })
-- use `:set filetype` to show you what kind of file you're in
-- snippet table also takes two params: (snippet_name, { snippet_body })
-- [[ LUA-SPECIFIC SNIPPETS ]]
ls.add_snippets('lua', {
  -- [[ TEST ]] {{
  s('hello', {
    t 'print("hello ',
    i(1),
    t ' world")',
  }),
  -- }}
})
