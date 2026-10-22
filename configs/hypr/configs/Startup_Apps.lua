-- Startup callbacks run once per session, never when reloading the config.
local d = require("UserConfigs/01-UserDefaults")
local wallpaper = require("UserConfigs/Wallpaper")
hl.on("hyprland.start", function()
    local function run(command) hl.exec_cmd(command) end
    local function shell_quote(value) return "'" .. value:gsub("'", "'\\''") .. "'" end
    local function optional(binary, args)
        run("command -v " .. binary .. " >/dev/null 2>&1 && " .. binary .. (args or ""))
    end
    run(d.root .. "/initial-boot.sh")
    if wallpaper.video then
        run("mpvpaper '*' -o 'load-scripts=no no-audio --loop' " .. shell_quote(wallpaper.video))
    else
        optional("swww-daemon", " --format xrgb")
    end
    -- Hyprland already exports session variables to systemd/dbus.
    run(d.scripts .. "/Polkit.sh")
    run("if command -v nm-applet >/dev/null 2>&1; then nm-applet --indicator; elif command -v nm-tray >/dev/null 2>&1; then nm-tray; fi")
    optional("swaync")
    optional("waybar")
    optional("qs", " -c overview")
    optional("hypridle")
    run(d.scripts .. "/Hyprsunset.sh init")
    optional("wl-paste", " --type text --watch cliphist store")
    optional("wl-paste", " --type image --watch cliphist store")
    optional("blueman-applet")
end)
