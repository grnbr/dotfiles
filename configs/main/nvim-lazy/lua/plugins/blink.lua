return {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = {
    "jsongerber/nvim-px-to-rem",
    { "L3MON4D3/LuaSnip", version = "v2.*" },
  },
  opts = {
    sources = {
      default = { "nvim-px-to-rem", "lsp", "path", "snippets", "buffer", "lazydev" },
      providers = {
        -- snippets = {
        --   score_offset = 100,
        -- },
        ["nvim-px-to-rem"] = {
          module = "nvim-px-to-rem.integrations.blink",
          name = "nvim-px-to-rem",
        },
      },
    },
    snippets = {
      preset = "luasnip",
    },
    keymap = {
      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },
    },
    completion = {
      -- accept = { auto_brackets = { enabled = false } },
      trigger = {
        show_in_snippet = false,
        show_on_trigger_character = false,
        show_on_blocked_trigger_characters = { " ", "\n", "\t", "{", "[", "(" },
        show_on_x_blocked_trigger_characters = { "{", "[", "(", "'", '"' },
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
}
