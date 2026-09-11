local programs = require("modules.programs")

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + ALT + Escape", hl.dsp.exec_cmd("hyprlock"))

hl.bind(mainMod .. "+ M", function()
  local layouts   = { "dwindle", "monocle" }
  local workspace = hl.get_active_workspace()

  if hl.get_active_special_workspace() then
    workspace = hl.get_active_special_workspace()
  end

  if not workspace then
    return
  end

  local next_layout = "dwindle"

  for i = 1, #layouts do
    if layouts[i] == workspace.tiled_layout then
      next_layout = layouts[(i % #layouts) + 1]
      break
    end
  end

  if workspace.special then
    hl.workspace_rule({
      workspace = tostring(workspace.name),
      layout = next_layout,
    })
  else
    hl.workspace_rule({
      workspace = tostring(workspace.id),
      layout = next_layout,
    })
  end
end)


hl.bind("ALT + Tab", function()
  local workspace = hl.get_active_workspace()

  if not workspace then
    return
  end

  if workspace.tiled_layout == "monocle" then
    hl.dispatch(hl.dsp.layout("cyclenext"))
  else
    hl.dispatch(hl.dsp.window.cycle_next({ tiled = true }))
    hl.dispatch(hl.dsp.window.bring_to_top())
  end
end)

hl.bind("ALT + SHIFT + Tab", function()
  local workspace = hl.get_active_workspace()

  if not workspace then
    return
  end

  if workspace.tiled_layout == "monocle" then
    hl.dispatch(hl.dsp.layout("cycleprev"))
  else
    -- No cycle_prev() window dispatcher, so use cycle_next.
    hl.dispatch(hl.dsp.window.cycle_next({ tiled = true }))
    hl.dispatch(hl.dsp.window.bring_to_top())
  end
end)

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({
  mode = "fullscreen",
  action = "toggle",
}))

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(programs.terminal))
hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + ALT + Q",
  hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(programs.fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(programs.menu))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "prev" }))

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Pomodoro
-- hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("waybar-module-pomodoro toggle"))
-- hl.bind(mainMod .. " + CTRL + P", hl.dsp.exec_cmd("waybar-module-pomodoro reset"))
hl.bind("SUPER + P", hl.dsp.exec_cmd("~/.config/hypr/scripts/focustimer-toggle.sh"))
hl.bind("SUPER + CTRL + P",
  hl.dsp.exec_cmd(
    "gdbus call --session --dest io.github.focustimerhq.FocusTimer --object-path /io/github/focustimerhq/FocusTimer --method io.github.focustimerhq.FocusTimer.Timer.Reset"))
