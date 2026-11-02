local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local events = require("luasnip.util.events")

local use_directives = {
  variables = "@use 'styles/utils/variables' as v;",
  tokens = "@use 'styles/utils/tokens' as t;",
  mixins = "@use 'styles/utils/mixins' as m;",
  functions = "@use 'styles/utils/functions' as f;",
}

local function ensure_use_at_top(directive)
  local buf_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  for _, line in ipairs(buf_lines) do
    if line == directive then
      return
    end
  end
  vim.api.nvim_buf_set_lines(0, 0, 0, false, { directive })
end

local function make_snip(trigger, nodes, directive_key)
  return s(trigger, nodes, {
    callbacks = {
      [-1] = {
        [events.enter] = function()
          ensure_use_at_top(use_directives[directive_key])
        end,
      },
    },
  })
end

local snips = {
  make_snip("medmax", {
    t("@include m.media-max(mobile"),
    i(1),
    t({ ") {", "\t" }),
    i(0),
    t({ "", "}" }),
  }, "mixins"),

  make_snip("medmin", {
    t("@include m.media-min(mobile"),
    i(1),
    t({ ") {", "\t" }),
    i(0),
    t({ "", "}" }),
  }, "mixins"),

  make_snip("vars", { t("v.$"), i(1) }, "variables"),
  make_snip("toks", { t("t.$"), i(1) }, "tokens"),
  make_snip("inmix", { t("@include m."), i(1) }, "mixins"),
  make_snip("fun", { t("f."), i(1) }, "functions"),
}

ls.add_snippets("scss", snips)
