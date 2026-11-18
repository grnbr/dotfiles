local step = 50

local function bind(keys, fn)
	for _, key in ipairs(keys) do
		swayimg.viewer.on_key(key, fn)
	end
end

local function sh_quote(s)
	return "'" .. (s:gsub("'", "'\\''")) .. "'"
end

local function quit()
	swayimg.exit()
end

local function fit_width()
	swayimg.viewer.set_fix_scale("width")
end

local function move(dx, dy)
	return function()
		local pos = swayimg.viewer.get_position()
		swayimg.viewer.set_abs_position(pos.x + dx, pos.y + dy)
	end
end

local function copy_image()
	local image = swayimg.viewer.get_image()
	if not image or not image.path then
		return
	end
	local p = sh_quote(image.path)
	os.execute('wl-copy --type "$(file -b --mime-type ' .. p .. ')" < ' .. p .. " &")
end

bind({ "q", "Cyrillic_shorti" }, quit)
bind({ "w", "Cyrillic_tse" }, fit_width)
bind({ "h", "Cyrillic_er" }, move(step, 0))
bind({ "l", "Cyrillic_de" }, move(-step, 0))
bind({ "k", "Cyrillic_el" }, move(0, step))
bind({ "j", "Cyrillic_o" }, move(0, -step))
bind({ "c", "Cyrillic_es" }, copy_image)
