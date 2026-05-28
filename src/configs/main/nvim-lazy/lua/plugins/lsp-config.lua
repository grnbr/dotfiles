return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      eslint = {},
      cssls = {},
      somesass_ls = {
        settings = {
          somesass = {
            workspace = {
              loadPaths = { "src" },
            },
            scss = {
              completion = {
                suggestFromUseOnly = true,
              },
            },
          },
        },
      },
      css_variables = {
        filetypes = { "css", "scss" }, -- remove scss/sass/less
      },
    },
    setup = {
      eslint = function()
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
          callback = function()
            vim.lsp.buf.format({ name = "eslint", async = false })
          end,
        })

        Snacks.util.lsp.on(function(buf, client)
          client.server_capabilities.documentFormattingProvider = client.name == "eslint"
          client.server_capabilities.documentRangeFormattingProvider = client.name == "eslint"
        end)
      end,
    },
  },
}
