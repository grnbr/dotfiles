hl.config({
  input = {
    kb_layout                   = "us, ru",
    kb_variant                  = "",
    kb_model                    = "",
    kb_options                  = "grp:win_space_toggle",
    kb_rules                    = "",
    repeat_rate                 = 35,
    repeat_delay                = 200,

    follow_mouse                = 2,
    float_switch_override_focus = 0,

    sensitivity                 = 0, -- -1.0 - 1.0, 0 means no modification.

    touchpad                    = {
      natural_scroll = false,
    },
  },
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace"
})

hl.device({
  name        = "epic-mouse-v1",
  sensitivity = -0.5,
})
