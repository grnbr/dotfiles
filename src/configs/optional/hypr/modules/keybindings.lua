-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
--
local programs = require("modules.programs")

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- ── System ────────────────────────────────────────────────
hl.bind(
	mainMod .. " + ALT + ESCAPE",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(mainMod .. " + ALT + Escape", hl.dsp.exec_cmd("hyprlock"))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- ── Windows ────────────────────────────────────────────────
local directions = {
	left = { "left", "h" },
	down = { "down", "j" },
	up = { "up", "k" },
	right = { "right", "l" },
}

local function bind_directions(modifier, dispatcher)
	for direction, keys in pairs(directions) do
		for _, key in ipairs(keys) do
			local prefix = mainMod

			if modifier then
				prefix = prefix .. " + " .. modifier
			end

			hl.bind(prefix .. " + " .. key, dispatcher(direction))
		end
	end
end

-- ── Focus
bind_directions(nil, function(direction)
	return hl.dsp.focus({ direction = direction })
end)

-- ── Move window
bind_directions("SHIFT", function(direction)
	return hl.dsp.window.move({ direction = direction })
end)

-- ── Swap window
bind_directions("ALT + SHIFT", function(direction)
	return hl.dsp.window.swap({ direction = direction })
end)

local directions = {
	left = { "left", "h" },
	down = { "down", "j" },
	up = { "up", "k" },
	right = { "right", "l" },
}

local function bind_directions(modifier, dispatcher)
	for direction, keys in pairs(directions) do
		for _, key in ipairs(keys) do
			local prefix = mainMod

			if modifier then
				prefix = prefix .. " + " .. modifier
			end

			hl.bind(prefix .. " + " .. key, dispatcher(direction))
		end
	end
end

-- ── Focus
bind_directions(nil, function(direction)
	return hl.dsp.focus({ direction = direction })
end)

-- ── Move window
bind_directions("SHIFT", function(direction)
	return hl.dsp.window.move({ direction = direction })
end)

-- ── Swap window
bind_directions("ALT + SHIFT", function(direction)
	return hl.dsp.window.swap({ direction = direction })
end)

local resize_step = 40

local resize_deltas = {
	left = { x = -resize_step, y = 0 },
	right = { x = resize_step, y = 0 },
	up = { x = 0, y = -resize_step },
	down = { x = 0, y = resize_step },
}

-- ── Resize window
for direction, keys in pairs(directions) do
	for _, key in ipairs(keys) do
		local delta = resize_deltas[direction]
		hl.bind(
			mainMod .. " + ALT + " .. key,
			hl.dsp.window.resize({
				x = delta.x,
				y = delta.y,
				relative = true,
			}),
			{ repeating = true }
		)
	end
end

hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + ALT + W", hl.dsp.window.kill())

hl.bind(
	mainMod .. " + F",
	hl.dsp.window.fullscreen({
		mode = "fullscreen",
		action = "toggle",
	})
)
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + CTRL + Y", hl.dsp.window.pin())
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only

hl.bind(mainMod .. "+ M", function()
	local layouts = { "dwindle", "monocle" }
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

-- Next floating window
hl.bind(
	"ALT + grave",
	hl.dsp.window.cycle_next({
		floating = true,
		next = true,
	})
)

-- Previous floating window
hl.bind(
	"ALT + SHIFT + grave",
	hl.dsp.window.cycle_next({
		floating = true,
		next = false,
	})
)

-- ── Workspaces ────────────────────────────────────────────────
-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
	hl.bind(mainMod .. " + CTRL + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "prev" }))

-- Example special workspace (scratchpad)
-- hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ── Apps ────────────────────────────────────────────────
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(programs.terminal))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd(programs.terminal .. " --class floating-terminal"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(programs.fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(programs.menu))

-- ── Misc ────────────────────────────────────────────────
-- Pomodoro
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("~/.config/hypr/scripts/focustimer-toggle.sh"))
hl.bind(
	mainMod .. " + CTRL + P",
	hl.dsp.exec_cmd(
		"gdbus call --session --dest io.github.focustimerhq.FocusTimer --object-path /io/github/focustimerhq/FocusTimer --method io.github.focustimerhq.FocusTimer.Timer.Reset"
	)
)

-- Screenshot
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp)" -t ppm - | satty --filename -'))

hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("grim -t ppm - | satty --filename -"))

-- Edit clipboard
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd("~/.local/bin/satty-edit-clipboard"))
