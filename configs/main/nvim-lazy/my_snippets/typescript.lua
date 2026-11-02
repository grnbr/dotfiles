local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local function fn(_, snip)
  return snip.env.TM_FILENAME_BASE
end

local function fn_cap(_, snip)
  local name = snip.env.TM_FILENAME_BASE
  return name:sub(1, 1):upper() .. name:sub(2)
end

local snips = {
  s("eslint no-console", {
    t("//eslint-disable-next-line no-console"),
  }),
  s("unusedvar", {
    t("const unusedVariable = '"),
    i(1),
    t(" below'"),
  }),
  s("ustr", {
    t("const { t } = useTranslation"),
    i(1),
    t("();"),
  }),
  s("rafche", {
    t("const "),
    f(fn, {}),
    t({ " = () => {", "  " }),
    i(1),
    t({ "", "", "  return {}", "}", "", "export default " }),
    f(fn, {}),
  }),
  s("tsrafche", {
    t("type "),
    f(fn_cap, {}),
    t({ "Props = {}", "", "const " }),
    f(fn, {}),
    t(" = ({}: "),
    f(fn, {}),
    t({ "Props) => {", "  " }),
    i(1),
    t({ "", "", "  return {}", "}", "", "export default " }),
    f(fn, {}),
  }),
  s("exdf", {
    t("export default function "),
    f(fn, {}),
    t("("),
    i(1),
    t({ ") {", "\t" }),
    i(2),
    t({ "", "}", "", "" }),
    i(0),
  }),
  s("exf", {
    t("export const "),
    i(1),
    t(" = ("),
    i(2),
    t({ ") => {", "\t" }),
    i(3),
    t({ "", "}", "", "" }),
    i(0),
  }),
  s("dsct", {
    t("const { "),
    i(2),
    t(" } = "),
    i(1),
    t(";"),
  }),
  s("clg", {
    t("console.log("),
    i(1),
    t(");"),
    i(0),
  }),
}
ls.add_snippets("typescript", snips)
ls.add_snippets("typescriptreact", snips)
