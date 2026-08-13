-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

map("n", "<leader>z", ":PxToRemCursor<CR>", { noremap = true, silent = true })
map("v", "<leader>z", ":PxToRemLine<CR>", { noremap = true, silent = true })

map("n", "<leader>vh", "H", { silent = true, desc = "Cursor on Viewport top" })
map("n", "<leader>vm", "M", { silent = true, desc = "Cursor on Viewport middle" })
map("n", "<leader>vl", "L", { silent = true, desc = "Cursor on Viewport bottom" })
vim.keymap.set("n", "n", "nzzzv") -- keep cursor centered when searching
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- keep cursor centered when jumping
vim.keymap.set("n", "<C-u>", "<C-u>zz")

map({ "i", "s" }, "<Tab>", function()
  local ls = require("luasnip")
  if ls.expandable() then
    ls.expand()
  elseif ls.jumpable(1) then
    ls.jump(1)
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
  end
end)

vim.keymap.set({ "n", "v" }, "c", '"_c')
vim.keymap.set({ "n", "v" }, "<A-c>", '"+c')
vim.keymap.set({ "n", "v" }, "x", '"_x')
vim.keymap.set({ "n", "x" }, "y", '"+y')
vim.keymap.set({ "n", "x" }, "<A-y>", '""y')
vim.keymap.set("n", "<leader>yy", function()
  local path = vim.fn.expand("%:p")
  local content = table.concat(vim.fn.getline(1, "$"), "\n")
  vim.fn.setreg("+", path .. "\n\n" .. content)
end, { desc = "Yank full path + all content" })
vim.keymap.set("n", "<leader>ya", ":%y+<CR>", { desc = "Yank all" })
vim.keymap.set("n", "<leader>yf", function()
  vim.fn.setreg("+", vim.fn.expand("%:t"))
end, { desc = "Yank filename" })
vim.keymap.set("n", "<leader>y%", function()
  vim.fn.setreg("+", vim.fn.expand("%"))
end, { desc = "Yank relative path" })
vim.keymap.set("n", "<leader>yp", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { desc = "Yank full path" })

vim.keymap.set({ "n" }, "p", '""p')
vim.keymap.set({ "n" }, "P", '""P')
vim.keymap.set("x", "p", '"_d""p')
vim.keymap.set("x", "P", '"_d""P')
vim.keymap.set({ "n", "x" }, "<leader>P", '"+P')
vim.keymap.set({ "n", "x" }, "<leader>p", '"+p')
vim.keymap.set({ "n", "v" }, "<A-d>", '""d')
vim.keymap.set({ "n", "x" }, "d", '"_d')
vim.keymap.set({ "n", "x" }, "D", '"_D')

vim.keymap.set("n", "<A-a>", "ggVG")

vim.keymap.set("n", "<A-i>", function()
  vim.lsp.buf.code_action({
    apply = true,
    context = {
      only = { "source.addMissingImports.ts" },
      diagnostics = {},
    },
  })
end, { desc = "Add Missing Imports" })

vim.keymap.set("n", "<A-o>", function()
  vim.lsp.buf.code_action({
    apply = true,
    context = {
      only = { "source.removeUnusedImports.ts" },
      diagnostics = {},
    },
  })
end, { desc = "Remove Unused Imports" })

vim.keymap.set("n", "<leader><tab>d", function()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    if not vim.b[buf].snacks_pinned then
      Snacks.bufdelete(buf)
    end
  end
  vim.cmd("tabclose")
end, { desc = "Close Tab & Delete Buffers" })

vim.keymap.set("n", "g<tab>", function()
  vim.cmd("tab split")
  vim.lsp.buf.definition()
end, { desc = "Go to Definition in New Tab" })

vim.keymap.set("n", "g|", function()
  vim.cmd("vsplit")
  vim.lsp.buf.definition()
end, { desc = "Go to Definition in VSplit" })

vim.keymap.set("n", "<A-w>", function()
  Snacks.bufdelete()
end, { desc = "Close Buffer" })

-- Windows and Tabs control
local keys = { "q", "w", "e", "r" }

for i, key in ipairs(keys) do
  vim.keymap.set("n", "<leader>t" .. key, function()
    local wins = vim.api.nvim_tabpage_list_wins(0)
    if wins[i] then
      vim.api.nvim_set_current_win(wins[i])
    end
  end, { desc = "Focus window " .. i })
end
for i, key in ipairs(keys) do
  vim.keymap.set("n", "<leader><tab>" .. key, function()
    local tabs = vim.api.nvim_list_tabpages()
    if tabs[i] then
      vim.api.nvim_set_current_tabpage(tabs[i])
    end
  end, { desc = "Focus tab " .. i })
end

vim.keymap.set("n", "<leader><tab>c", "<cmd>tabclose<cr>", { desc = "Close tab" })

vim.keymap.set("n", "<leader>bZ", function()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_call(buf, function()
        vim.cmd("BufferLineTogglePin")
      end)
    end
  end
end, { desc = "Pin all buffers" })

-- local function wrap_wincmd(dir, wrap_dir)
--   local cur = vim.api.nvim_get_current_win()
--   vim.cmd("wincmd " .. dir)
--   if vim.api.nvim_get_current_win() == cur then
--     while true do
--       vim.cmd("wincmd " .. wrap_dir)
--       local w = vim.api.nvim_get_current_win()
--       vim.cmd("wincmd " .. wrap_dir)
--       if vim.api.nvim_get_current_win() == w then
--         break
--       end
--       vim.api.nvim_set_current_win(w)
--     end
--   end
-- end
--
-- map("n", "<C-h>", function()
--   wrap_wincmd("h", "l")
-- end)
-- map("n", "<C-j>", function()
--   wrap_wincmd("j", "k")
-- end)
-- map("n", "<C-k>", function()
--   wrap_wincmd("k", "j")
-- end)
-- map("n", "<C-l>", function()
--   wrap_wincmd("l", "h")
-- end)
