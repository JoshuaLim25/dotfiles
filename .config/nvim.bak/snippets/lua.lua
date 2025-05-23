-----------
-- Links --
-----------
-- https://www.youtube.com/watch?v=FmHhonPjvvA
-- https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
-- see https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#lua
-- TJ: https://www.youtube.com/watch?v=KtQZRAkgLqo
-- https://www.youtube.com/playlist?list=PL0EgBggsoPCnZ3a6c0pZuQRMgS_Z8-Fnr
-----------
-- NOTES --
-----------
-- INFO: add_snippets("filetype", { table_of_snippets })
-- INFO: fmt("[[]]", { table_of_nodes })
-- INFO:: set ft or := vim.bo.filetype
-- a dynamic node's just a funtion returning a snippet.
-- [[
--     To insert a newline:
--     t({"line1", "line2"})
--     Each string in the array is a line.
--
--     To insert a newline with indentation:
--     t({"", " "})
--     "" = newline, " " = indentation on the new line.
-- ]]
local ls = require 'luasnip'
local extras = require 'luasnip.extras'
require('luasnip.session.snippet_collection').clear_snippets 'lua'
local rep = extras.rep
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta

local s = ls.snippet -- s(snippet_name, { snippet_body })
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node -- c(jump_num, { body }),
local d = ls.dynamic_node
local f = ls.function_node
-- local sn = ls.snippet_node -- NOTE: this is the snppet node itself, not a way to make it.
local sn = ls.sn -- NOTE: this is the snppet node itself, not a way to make it.

--

return {
  s(
    'req',
    fmt([[local {} = require "{}"]], {
      f(function(import_name)
        -- list of lines
        local parts = vim.split(import_name[1][1], '.', true)
        return parts[#parts] or ''
      end, { 1 }),
      i(1),
    })
  ),

  s(
    'setup',
    fmta(
      [[
  require("<>").setup({
    <>
  })
  ]],
      { i(1), i(2) }
    )
  ),
}
