-- Native Hyprland Lua configuration (0.55+), verified with 0.56.2.
-- See README-Lua.md for the audit, usage and rollback instructions.
require("UserConfigs/01-UserDefaults")
require("configs/ENVariables")
require("UserConfigs/ENVariables")
hypr_dots = require("configs/Actions")

-- Load settings before bindings and personal overrides after vendor defaults.
require("configs/SystemSettings")
require("UserConfigs/UserDecorations")
require("UserConfigs/UserAnimations")
require("configs/WindowRules")
require("UserConfigs/WindowRules")
require("configs/Keybinds")
require("configs/Laptops")
require("UserConfigs/Laptops")
require("UserConfigs/UserKeybinds")
require("UserConfigs/UserSettings")

-- nwg-displays owns monitors.lua; preserve its current layout.
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
require("monitors")
require("workspaces")
require("UserConfigs/LaptopDisplay")
require("configs/Startup_Apps")
require("UserConfigs/Startup_Apps")
