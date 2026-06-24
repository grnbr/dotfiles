return {
  {
    "sainnhe/everforest",
    lazy = false,      -- load at startup
    priority = 1000,   -- load before other UI plugins
    config = function()
      -- Optional configuration
      vim.g.everforest_background = "soft"        -- "soft" | "medium" | "hard"
      vim.g.everforest_enable_italic = 1         -- enable italic keywords
      vim.g.everforest_disable_italic_comment = 1 -- optional: disable italic for comments
      vim.g.everforest_better_performance = 1    -- faster load

      -- Apply the colorscheme
      vim.cmd.colorscheme("everforest")
    end,
  },
}
