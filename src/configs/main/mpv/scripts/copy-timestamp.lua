local function get_clipboard_cmd()
  local session_type = os.getenv("XDG_SESSION_TYPE")
  if session_type == "wayland" then
    return "wl-copy"
  else
    return "xclip -selection clipboard"
  end
end

local function copy_timestamp()
  local pos = mp.get_property_number("time-pos")
  if pos == nil then return end
  local formatted = mp.format_time(pos)
  local cmd = get_clipboard_cmd()
  local handle = io.popen(cmd, "w")
  handle:write(formatted)
  handle:close()
  mp.osd_message("Copied timestamp: " .. formatted)
end

mp.add_key_binding("c", "copy-timestamp", copy_timestamp)
