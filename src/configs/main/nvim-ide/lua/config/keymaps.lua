local map = vim.keymap.set

-- Navigation
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Move lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Save / quit
map({ "n", "i", "x" }, "<C-s>", "<cmd>w<CR>")
map("n", "<leader>q", "<cmd>qa<CR>", { desc = "Quit" })

-- Select all
map("n", "<A-a>", "ggVG")

-- Clipboard
map({ "n", "v" }, "c", '"_c')
map({ "n", "v" }, "<A-c>", '"+c')
map({ "n", "v" }, "x", '"_x')
map({ "n", "x" }, "y", '"+y')
map({ "n", "x" }, "<A-y>", '""y')
map({ "n" }, "p", '""p')
map({ "n" }, "P", '""P')
map("x", "p", '"_d""p')
map("x", "P", '"_d""P')
map({ "n", "x" }, "<leader>p", '"+p')
map({ "n", "x" }, "<leader>P", '"+P')
map({ "n", "v" }, "<A-d>", '""d')
map({ "n", "x" }, "d", '"_d')
map({ "n", "x" }, "D", '"_D')

-- Yank utils
map("n", "<leader>ya", ":%y+<CR>", { desc = "Yank all" })
map("n", "<leader>yf", function()
	vim.fn.setreg("+", vim.fn.expand("%:t"))
end, { desc = "Yank filename" })
map("n", "<leader>y%", function()
	vim.fn.setreg("+", vim.fn.expand("%"))
end, { desc = "Yank relative path" })
map("n", "<leader>yp", function()
	vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { desc = "Yank full path" })

-- Viewport
map("n", "<leader>vh", "H", { desc = "Cursor viewport top" })
map("n", "<leader>vm", "M", { desc = "Cursor viewport middle" })
map("n", "<leader>vl", "L", { desc = "Cursor viewport bottom" })

-- LSP imports (no plugin needed)
map("n", "<A-i>", function()
	vim.lsp.buf.code_action({ apply = true, context = { only = { "source.addMissingImports.ts" }, diagnostics = {} } })
end, { desc = "Add Missing Imports" })
map("n", "<A-o>", function()
	vim.lsp.buf.code_action({ apply = true, context = { only = { "source.removeUnusedImports.ts" }, diagnostics = {} } })
end, { desc = "Remove Unused Imports" })

-- Buffers
map("n", "<A-w>", "<cmd>bd<CR>", { desc = "Close buffer" })

-- Tabs
map("n", "<leader><tab>c", "<cmd>tabclose<cr>", { desc = "Close tab" })
map("n", "g<tab>", function()
	vim.cmd("tab split")
	vim.lsp.buf.definition()
end, { desc = "Go to Definition in New Tab" })
map("n", "g|", function()
	vim.cmd("vsplit")
	vim.lsp.buf.definition()
end, { desc = "Go to Definition in VSplit" })
