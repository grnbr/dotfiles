local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

local snips = {
  s("rootdir", {
    t({
      'ROOT_DIR="$(git -C "$(dirname "${BASH_SOURCE[0]}")" rev-parse --show-toplevel 2>/dev/null)" || {',
      '  echo "ERROR: not inside a git repo"',
      "  exit 1",
      "}",
    }),
  }),
  s("cwd", {
    t('CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"'),
  }),
}

ls.add_snippets("sh", snips)
