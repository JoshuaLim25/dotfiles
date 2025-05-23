---@diagnostic disable: unused-local
--# selene: allow(unused_variable)
-- credits: https://github.com/wfxr/dotfiles/blob/master/vim/nvim/snippets/luasnip/sh.lua
local ls = require 'luasnip'
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require('luasnip.extras').lambda
local rep = require('luasnip.extras').rep
local p = require('luasnip.extras').partial
local m = require('luasnip.extras').match
local n = require('luasnip.extras').nonempty
local dl = require('luasnip.extras').dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt -- {} placeholders
local fmta = require('luasnip.extras.fmt').fmta -- <> placeholders
local types = require 'luasnip.util.types'
local conds = require 'luasnip.extras.conditions'
local conds_expand = require 'luasnip.extras.conditions.expand'

-- stylua: ignore
return {
  s("cmd?", fmt([[
   if ! command -v {} &>/dev/null; then 
     echo "{} not installed." 
     exit 42
   fi
  ]], { i(1), rep(1) } )),
  s("empty?", {
    t("if [[ -z ${"),
    i(1),
    t("} ]]; then"),
    t("\n", "    "),
    i(2),
    t("fi")
  }),

  s("input_yn", t({
    "input_yn() {",
    "  local -r prompt=\"${1:-Continue? (Y/n)}\"",
    "  local yn",
    "  # Read single character without field splitting (IFS=), no backslash escape (-r)",
    "  IFS= read -p $'\\e[31;1m'\"${prompt}: \"$'\\e[m ' -n 1 -r yn",
    "  echo >&2  # Ensure newline after prompt",
    "  ",
    "  yn=\"${yn:-Y}\"  # Default to Yes if empty",
    "  [[ \"$yn\" =~ ^[Yy]$ ]]  # Explicit regex match for Y/y (return code 0/1)",
    "}"
  })),

  -- s("input", t({
  --   "input() {",
  --   "  declare -r prompt=${1:-\"Confirm? (Y/n)\"}",
  --   "  IFS= read -p $'\\e[31;1m'\"${prompt}\"$' [Y/n] \\e[m' -n 1 -r yn",
  --   "  echo >&2",
  --   "  [[ $yn == [Yy] ]]",
  --   "}"
  -- })),

  s("unset?", fmta([[
   if [ -z ${<>+x} ]; then
     echo "${<>} is unset"; else echo "${<>} is set to '${<>}'"
   fi

  ]], { i(1, "var"), rep(1), rep(1), rep(1) })),

  s("setifempty", fmta([[
   "${<>:-"<>"}"
  ]], { i(1, "var"), i(2, "default") })),

  s("bash", {
    t { "#!/usr/bin/env bash", "" },
  }),
  s("sbash", {
    t { "#!/usr/bin/env bash", "" },
    t { "set -euo pipefail", "" },
    t { "IFS=$'\\n\\t'", "" },
  }),

  s("usage", {
    t { 'usage() { echo "Usage: $(basename "$0") <' }, i(1, "param"), t { '>" >&2; }' },
  }),

  s("sdir", {
    t { 'SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)' },
    i(0, ' && cd "$SDIR"'),
  }),

  s("hascmd", {
    t { "hash " }, i(1, "cmd"), t { " &>/dev/null " }, i(2, "&&"),
  }),

  s("tempdir", {
    t { 'trap \'command rm -rf "$' }, i(1, "temp_dir\""), t { '\' ' }, i(2, "EXIT INT TERM HUP"), t { '', '' },
    rep(1), t { '="$(mktemp -' }, i(3, "d"), t { 't ' }, i(4, '"$(basename "$0")"'), t { '.XXXXXX)"', '' },
  }),

  s("log", {
    t { 'info() { printf "' }, i(1, "$(date +%FT%T) "), t { [[%b[info]%b %s\n" ]] }, t { [['\e[0;32m\033[1m']] }, t { [[ '\e[0m' "$*" >&2; }]],  '' },
    t { 'warn() { printf "' }, rep(1),                  t { [[%b[warn]%b %s\n" ]] }, t { [['\e[0;33m\033[1m']] }, t { [[ '\e[0m' "$*" >&2; }]],  '' },
    t { 'erro() { printf "' }, rep(1),                  t { [[%b[erro]%b %s\n" ]] }, t { [['\e[0;31m\033[1m']] }, t { [[ '\e[0m' "$*" >&2; }]],  '' },
  }),

  s("shellcheck", {
    t { "# shellcheck disable=SC" }, i(1),
  }),

  -- https://github.com/kiyoon/dotfiles/blob/4a8254047225b1ebf956fbe96bc7546ca242f5ec/nvim/luasnippets/sh.lua
  s("waitp", {
    t {
      [[# wait for shell's child process to exit]],
      [[shell_pid=]],
    },
    i(1, "pid"),
    t {
      "",
      [[child_pid=$(ps -ef | awk -v shell_pid=$shell_pid '$3==shell_pid {print $2}')]],
      [[echo "child_pid: $child_pid"]],
      'while [[ -n "$child_pid" ]] && ps -p "$child_pid" > /dev/null; do',
      "\tsleep 1",
      [[done]],
      "",
    },
    i(0),
  }),

}
