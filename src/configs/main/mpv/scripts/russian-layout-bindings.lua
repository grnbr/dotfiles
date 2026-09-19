--[[
Russian keyboard layout support for mpv.

mpv does not natively support shortcuts independent of the keyboard
layout, so this script duplicates active English-layout bindings for
the Russian (ЙЦУКЕН) layout.

The script waits briefly for other scripts/plugins to load, reads
the currently active bindings, translates English key names to their
Russian-layout equivalents, and registers the translated bindings.

Known limitation:
mpv does not expose whether an input.conf binding was automatically
detected as repeatable. Therefore, translated bindings are considered
repeatable only when the command contains the "repeatable" modifier.

If a binding should be repeatable in its translated form, explicitly
use:

    repeatable <command>

in input.conf.
]]

local mp = require("mp")

-- English keyboard -> Russian keyboard
local key_mapping = {
  q = "й",
  w = "ц",
  e = "у",
  r = "к",
  t = "е",
  y = "н",
  u = "г",
  i = "ш",
  o = "щ",
  p = "з",

  a = "ф",
  s = "ы",
  d = "в",
  f = "а",
  g = "п",
  h = "р",
  j = "о",
  k = "л",
  l = "д",

  z = "я",
  x = "ч",
  c = "с",
  v = "м",
  b = "и",
  n = "т",
  m = "ь",

  Q = "Й",
  W = "Ц",
  E = "У",
  R = "К",
  T = "Е",
  Y = "Н",
  U = "Г",
  I = "Ш",
  O = "Щ",
  P = "З",

  A = "Ф",
  S = "Ы",
  D = "В",
  F = "А",
  G = "П",
  H = "Р",
  J = "О",
  K = "Л",
  L = "Д",

  Z = "Я",
  X = "Ч",
  C = "С",
  V = "М",
  B = "И",
  N = "Т",
  M = "Ь",

  [","] = "б",
  ["."] = "ю",
  ["`"] = "ё",
  ["["] = "х",
  ["]"] = "ъ",
}

local function split(input, separator)
  local result = {}

  for part in string.gmatch(input, "([^" .. separator .. "]+)") do
    table.insert(result, part)
  end

  return result
end

local function is_repeatable(cmd)
  for part in string.gmatch(cmd, "%S+") do
    if part == "repeatable" then
      return true
    end
  end

  return false
end

local function translate_key(key)
  local parts = split(key, "+")
  local translated = {}
  local changed = false

  for _, part in ipairs(parts) do
    local mapped = key_mapping[part]

    if mapped then
      table.insert(translated, mapped)
      changed = true
    else
      table.insert(translated, part)
    end
  end

  if not changed then
    return nil
  end

  return table.concat(translated, "+")
end


-- Wait for other mpv scripts/plugins to finish loading.
mp.add_timeout(0.5, function()
  local bindings = mp.get_property_native("input-bindings")

  for _, binding in ipairs(bindings) do
    local translated_key = translate_key(binding.key)

    if translated_key then
      mp.add_key_binding(
        translated_key,
        nil,
        function()
          mp.command(binding.cmd)
        end,
        {
          repeatable = is_repeatable(binding.cmd),
        }
      )
    end
  end
end)
