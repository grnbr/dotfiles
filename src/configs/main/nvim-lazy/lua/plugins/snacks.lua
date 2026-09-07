return {
  "folke/snacks.nvim",
  opts = {
    scroll = { enabled = false },

    terminal = {
      win = {
        style = "terminal",
        on_win = function()
          vim.cmd("stopinsert")
        end,
      },
      auto_insert = false,
    },
  },
}
