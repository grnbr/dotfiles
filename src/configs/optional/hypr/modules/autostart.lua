local programs = require("modules.programs")

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

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar & hyprpaper")
	setup_wallpaper()
	hl.dispatch(hl.dsp.focus({ workspace = "2" }))
	hl.exec_cmd(programs.terminal, { workspace = "2" })
	hl.exec_cmd("firefox", { workspace = "3 silent" })
	hl.exec_cmd("brave --incognito", { workspace = "1 silent" })
	hl.exec_cmd("Telegram", { workspace = "8 silent" })
	hl.exec_cmd("discord", { workspace = "8 silent" })
	hl.exec_cmd("steam -silent")
	hl.exec_cmd("nm-applet")
end)
