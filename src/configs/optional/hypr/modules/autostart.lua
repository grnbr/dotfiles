local programs = require("modules.programs")
local device = require("libs.device")

local function setup_wallpaper()
	hl.exec_cmd([[
    if command -v darkman >/dev/null 2>&1; then
      systemctl --user start darkman

      until hyprctl hyprpaper listactive >/dev/null 2>&1; do
        sleep 0.05
      done

      ~/.local/share/darkman/handler.sh "$(darkman get)"
    else
      hyprctl hyprpaper wallpaper ',~/Pictures/Wallpapers/light.jpg'
    fi
  ]])
end

local function start_hypridle()
	local conf = os.getenv("HOME") .. "/.config/hypr/idle/hypridle-" .. device.name .. ".conf"
	hl.exec_cmd("hypridle -c " .. conf)
end

-- Apps started on every machine
local function start_common()
	hl.exec_cmd("waybar")
	hl.exec_cmd("hyprpaper")
	start_hypridle()
	setup_wallpaper()
	hl.dispatch(hl.dsp.focus({ workspace = "2" }))
	hl.exec_cmd(programs.terminal, { workspace = "2" })
	hl.exec_cmd("firefox", { workspace = "3 silent" })
	hl.exec_cmd("brave --incognito", { workspace = "1 silent" })
	hl.exec_cmd("Telegram", { workspace = "8 silent" })
	hl.exec_cmd("discord", { workspace = "8 silent" })
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("~/.config/hypr/scripts/focustimer-toggle.sh")
end

local function start_desktop()
	hl.exec_cmd("steam -silent")
end

local function start_laptop()
	-- Laptop-only extras, add what you use:
	-- hl.exec_cmd("blueman-applet")
	-- hl.exec_cmd("poweralertd")
end

hl.on("hyprland.start", function()
	start_common()
	if device.is_laptop then
		start_laptop()
	else
		start_desktop()
	end
end)
