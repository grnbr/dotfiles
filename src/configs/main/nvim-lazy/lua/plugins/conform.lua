return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      scss = { "stylelint", "prettierd" },
      typescript = { "eslint_d", "prettierd", stop_after_first = false },
      typescriptreact = { "eslint_d", "prettierd", stop_after_first = false },
      javascript = { "eslint_d", "prettierd", stop_after_first = false },
      javascriptreact = { "eslint_d", "prettierd", stop_after_first = false },
      json = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}
