local M = {}

local function read_file(path)
	local f = io.open(path, "r")
	if not f then
		return nil
	end
	local content = f:read("*a")
	f:close()
	return content
end

local function detect()
	-- Manual override: HYPR_DEVICE=laptop|desktop
	local override = os.getenv("HYPR_DEVICE")
	if override == "laptop" or override == "desktop" then
		return override
	end

	-- DMI chassis type: 8 Portable, 9 Laptop, 10 Notebook, 11 Handheld,
	-- 14 Sub Notebook, 30 Tablet, 31 Convertible, 32 Detachable
	local chassis = tonumber((read_file("/sys/class/dmi/id/chassis_type") or ""):match("%d+"))
	local laptop_chassis =
		{ [8] = true, [9] = true, [10] = true, [11] = true, [14] = true, [30] = true, [31] = true, [32] = true }
	if chassis and laptop_chassis[chassis] then
		return "laptop"
	end

	-- Fallback: a battery means laptop
	for _, bat in ipairs({ "BAT0", "BAT1" }) do
		if read_file("/sys/class/power_supply/" .. bat .. "/type") then
			return "laptop"
		end
	end

	return "desktop"
end

M.name = detect()
M.is_laptop = M.name == "laptop"
M.is_desktop = not M.is_laptop

return M
