return {
  "Wansmer/langmapper.nvim",
  enabled = false,
  lazy = false,
  priority = 1,
  config = function()
    require("langmapper").setup({
      hack_keymap = true,
      map_all_ctrl = true,
      ctrl_map_modes = { 'n', 'o', 'i', 'c', 't', 'v' },
      layouts = {
        ru = {
          id = '1', -- since we're now returning the index, not a name string
          layout = 'йцукенгшщзхъфывапролджэячсмитьбюЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ',
        },
      },
      os = {
        Linux = {
          get_current_layout_id = function()
            local handle = io.popen(
              "hyprctl devices -j | jq -r '.keyboards[] | select(.main==true) | .active_layout_index'")
            if handle then
              local result = vim.trim(handle:read("*a"))
              handle:close()
              return result
            end
            return nil
          end,
        },
      },
    })
  end,
}
