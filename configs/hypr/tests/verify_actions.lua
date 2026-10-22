-- Executed only by --verify-config through check-lua.py; no desktop processes.
local function same(a, b)
    if type(a) ~= type(b) then return false end
    if type(a) ~= "table" then return a == b end
    for key, value in pairs(a) do if not same(value, b[key]) then return false end end
    for key in pairs(b) do if a[key] == nil then return false end end
    return true
end
local function value(key) return hl.get_config(key) end
local original_layout = value("general.layout")
hypr_dots.toggle_layout()
assert(value("general.layout") ~= original_layout, "layout did not change")
hypr_dots.toggle_layout()
assert(value("general.layout") == original_layout, "layout did not restore")

local original_blur = value("decoration.blur.enabled")
hypr_dots.toggle_blur()
assert(value("decoration.blur.enabled") ~= original_blur, "blur did not change")
hypr_dots.toggle_blur()
assert(value("decoration.blur.enabled") == original_blur, "blur did not restore")

hypr_dots.zoom(0.0001)
assert(value("cursor.zoom_factor") == 1, "zoom fell below 1")
hypr_dots.zoom(1000)
assert(value("cursor.zoom_factor") == 16, "zoom exceeded 16")
hypr_dots.zoom(1 / 16)

-- Use non-default values to catch restore routines that hard-code defaults.
hl.config({
    general = { gaps_in = { top = 3, right = 5, bottom = 7, left = 9 }, border_size = 3 },
    decoration = { blur = { enabled = false } }, animations = { enabled = false },
})
local keys = { "general.gaps_in", "general.gaps_out", "general.border_size", "decoration.blur.enabled", "decoration.shadow.enabled", "animations.enabled" }
local before = {}
for _, key in ipairs(keys) do before[key] = value(key) end
for _ = 1, 2 do
    hypr_dots.toggle_game_mode()
    assert(value("decoration.blur.enabled") == false)
    assert(value("decoration.shadow.enabled") == false)
    assert(value("animations.enabled") == false)
    assert(value("general.border_size") == 1)
    hypr_dots.toggle_game_mode()
    for _, key in ipairs(keys) do assert(same(value(key), before[key]), "game mode did not restore " .. key) end
end
hypr_dots.apply_colors()
