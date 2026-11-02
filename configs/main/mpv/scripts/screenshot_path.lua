local mp = require("mp")
local utils = require("mp.utils")

local home = os.getenv("HOME")

local primary = "/mnt/store/Media/Images/Screenshots"
local pictures1 = home .. "/Pictures"
local pictures2 = home .. "/pictures"

local function dir_exists(path)
	local info = utils.file_info(path)
	return info and info.is_dir
end

local function ensure_dir(path)
	os.execute('mkdir -p "' .. path .. '"')
end

local function set_screenshot_dir()
	local current = mp.get_property("screenshot-directory")

	-- 0. If already using primary, do nothing
	if current == primary then
		mp.msg.info("Already using primary screenshot dir")
		return
	end

	-- 1. Try primary path
	if dir_exists(primary) then
		mp.set_property("screenshot-directory", primary)
		mp.msg.info("Using primary: " .. primary)
		return
	end

	-- 2. Decide fallback base safely
	local base

	if dir_exists(pictures1) then
		base = pictures1
	elseif dir_exists(pictures2) then
		base = pictures2
	else
		base = pictures1
	end

	-- 3. Ensure directory exists
	ensure_dir(base)

	-- 4. mpv subfolder
	local mpv_dir = base .. "/mpv"
	ensure_dir(mpv_dir)

	mp.set_property("screenshot-directory", mpv_dir)
	mp.msg.info("Using fallback: " .. mpv_dir)
end

mp.register_event("file-loaded", set_screenshot_dir)
