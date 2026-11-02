local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local snip = {
  s("tsrafce", {
    t("import { FC } from 'react'"),
    t({ "", "", "import styles from './" }),
    f(function(_, snip)
      return snip.env.TM_FILENAME_BASE
    end, {}),
    t(".module.scss';"),
    t({ "", "", "type " }),
    f(function(_, snip)
      return snip.env.TM_FILENAME_BASE
    end, {}),
    t("Props = {}"),
    t({ "", "", "const " }),
    f(function(_, snip)
      return snip.env.TM_FILENAME_BASE
    end, {}),
    t(": FC<"),
    f(function(_, snip)
      return snip.env.TM_FILENAME_BASE
    end, {}),
    t("Props> = ({}) => {"),
    t({ "", "  return (", "    <div>" }),
    i(1, "first"),
    t({ "</div>", "  )", "}" }),
    t({ "", "", "export default " }),
    f(function(_, snip)
      return snip.env.TM_FILENAME_BASE
    end, {}),
  }),
  s("rafce", {
    t({ "import styles from './" }),
    f(function(_, snip)
      return snip.env.TM_FILENAME_BASE
    end, {}),
    t(".module.scss';"),
    t({ "", "", "const " }),
    f(function(_, snip)
      return snip.env.TM_FILENAME_BASE
    end, {}),
    t(" = () => {"),
    t({ "", "  return (", "    <div>" }),
    i(1, "first"),
    t({ "</div>", "  )", "}" }),
    t({ "", "", "export default " }),
    f(function(_, snip)
      return snip.env.TM_FILENAME_BASE
    end, {}),
  }),
  s("cn", {
    t("className={"),
    i(1),
    t("}"),
  }),
}

ls.add_snippets("typescriptreact", snip)
ls.add_snippets("tsx", snip)
