vim.keymap.set("n", "<C-d>", "<C-d>zz") -- keep cursor centered when jumping
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv") -- keep cursor centered when searching

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- move selected line down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- move selected line up

vim.keymap.set({ "n", "i", "x" }, "<C-s>", "<cmd>w<CR>")
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>")
vim.keymap.set("n", "<C-h>", "<C-w>h") -- move to left split
vim.keymap.set("n", "<C-j>", "<C-w>j") -- move to bottom split
vim.keymap.set("n", "<C-k>", "<C-w>k") -- move to top split
vim.keymap.set("n", "<C-l>", "<C-w>l") -- move to right split

vim.keymap.set({ "n", "v" }, "c", '"_c')
vim.keymap.set({ "n", "v" }, "<A-c>", '"+c')
vim.keymap.set({ "n", "v" }, "x", '"_x')
vim.keymap.set({ "n", "x" }, "y", '"+y')
vim.keymap.set({ "n", "x" }, "<A-y>", '""y')
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
vim.keymap.set({ "n", "v" }, "<A-d>", '"+d')
vim.keymap.set({ "n", "v" }, "<A-d>", '""d')
vim.keymap.set({ "n", "x" }, "d", '"_d')
vim.keymap.set({ "n", "x" }, "D", '"_D')

vim.keymap.set("n", "<A-a>", "ggVG")
