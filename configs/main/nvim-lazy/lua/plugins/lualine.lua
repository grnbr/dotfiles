return {
  "nvim-lualine/lualine.nvim",
  opts = {
    sections = {
      lualine_c = {
        { "filename", path = 1, shorting_target = 0 }, -- 3 = absolute path
      },
      lualine_z = {
        { "datetime", style = "%I:%M %p" },
      },
    },
  },
}
