hl.config({
  misc = {
    --allow_session_lock_restore = true,
    force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
    disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
    --float_force_onscreen    = 1,
    font_family             = "Inter",
    key_press_enables_dpms  = true,
    mouse_move_enables_dpms = true,
    --initial_workspace_tracking = 2,
    vrr                     = 2,
  },
  binds = {
  },
  cursor = {
    warp_on_change_workspace = 1,
  }
})
