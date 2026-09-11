hl.config({
  general = {
    gaps_in           = 5,
    gaps_out          = 20,

    border_size       = 5,

    col               = {
      active_border = {
        colors = {
          "rgba(a7c080ff)",
          "rgba(83c092ff)",
        },
        angle = 45,
      },
      inactive_border = "rgba(343f44ff)",
    },

    -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
    resize_on_border  = false,

    -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
    allow_tearing     = false,
    no_focus_fallback = true,

    layout            = "dwindle",
  },

  decoration = {
    rounding         = 10,
    rounding_power   = 2,

    -- Change transparency of focused and unfocused windows
    active_opacity   = 0.97,
    inactive_opacity = 0.93,

    shadow           = {
      enabled      = true,
      range        = 4,
      render_power = 3,
      color        = 0xee1a1a1a,
    },

    blur             = {
      enabled  = true,
      size     = 6,
      passes   = 1,
      vibrancy = 0.1696,
    },
  },

  animations = {
    enabled = false,
  },
})
