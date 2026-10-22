-- Runtime actions shared by keybinds, gestures, and the existing shell menus.
local d = require("UserConfigs/01-UserDefaults")
local actions = {}

function actions.zoom(factor)
    local current = hl.get_config("cursor.zoom_factor") or 1
    hl.config({ cursor = { zoom_factor = math.max(1, math.min(16, current * factor)) } })
end

function actions.toggle_layout()
    local layout = hl.get_config("general.layout") == "master" and "dwindle" or "master"
    hl.config({ general = { layout = layout } })
end

function actions.toggle_blur()
    hl.config({ decoration = { blur = { enabled = not hl.get_config("decoration.blur.enabled") } } })
end

function actions.float_workspace()
    local workspace = hl.get_active_workspace()
    if not workspace then return end
    local windows = hl.get_workspace_windows(workspace)
    local all_floating = #windows > 0
    for _, window in ipairs(windows) do
        all_floating = all_floating and window.floating
    end
    for _, window in ipairs(windows) do
        hl.dispatch(hl.dsp.window.float({ window = window, action = all_floating and "unset" or "set" }))
    end
end

-- Keep the existing wallust template as color data, without parsing Hyprlang.
-- WallustSwww.sh calls this again after a wallpaper change.
function actions.apply_colors()
    local colors = {
        color0 = "rgb(FFFFF7)", color10 = "rgb(8FBCCC)",
        color12 = "rgb(735E4D)", color15 = "rgb(030404)",
    }
    local file = io.open(d.root .. "/wallust/wallust-hyprland.conf", "r")
    if file then
        for line in file:lines() do
            local key, value = line:match("^%s*%$(color%d+)%s*=%s*(rgba?%(%x+%))")
            if key then colors[key] = value end
        end
        file:close()
    end
    hl.config({
        general = { col = { active_border = colors.color12, inactive_border = colors.color10 } },
        decoration = { shadow = { color = colors.color12, color_inactive = colors.color10 } },
        group = { col = { border_active = colors.color15 }, groupbar = { col = { active = colors.color0 } } },
    })
end

local game_restore
local game_rule
function actions.toggle_game_mode()
    if game_restore then
        hl.config(game_restore)
        game_rule:set_enabled(false)
        game_restore = nil
        return
    end
    game_restore = {
        animations = { enabled = hl.get_config("animations.enabled") },
        general = {
            gaps_in = hl.get_config("general.gaps_in"), gaps_out = hl.get_config("general.gaps_out"),
            border_size = hl.get_config("general.border_size"),
        },
        decoration = {
            shadow = { enabled = hl.get_config("decoration.shadow.enabled") },
            blur = { enabled = hl.get_config("decoration.blur.enabled") },
        },
    }
    hl.config({
        animations = { enabled = false },
        general = { gaps_in = 0, gaps_out = 0, border_size = 1 },
        decoration = { shadow = { enabled = false }, blur = { enabled = false } },
    })
    game_rule = hl.window_rule({ name = "dots-game-mode", match = { class = ".*" }, opacity = "1 override 1 override 1 override" })
end

return actions
