return {
  { "mg979/vim-visual-multi" },
  {
    "olrtg/nvim-emmet",
    config = function()
      vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation)
    end,
  },
  {
    "Goose97/timber.nvim",
    version = "*",
    event = "VeryLazy",
    config = true,
  },
  {
    "jsongerber/nvim-px-to-rem",
    config = true,
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        manual_mode = false,
        detection_methods = { "pattern" }, -- remove lsp
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile" },
      })
    end,
  },
}
