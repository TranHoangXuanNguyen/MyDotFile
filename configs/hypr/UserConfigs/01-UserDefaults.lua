-- Shared defaults for native config and desktop helper scripts.
local home = assert(os.getenv("HOME"), "HOME is not set")
local root = (os.getenv("XDG_CONFIG_HOME") or (home .. "/.config")) .. "/hypr"
local defaults = {
    root = root,
    scripts = root .. "/scripts",
    user_scripts = root .. "/UserScripts",
    user_configs = root .. "/UserConfigs",
    terminal = "kitty",
    files = "dolphin",
    editor = "nvim",
    search_engine = "https://www.google.com/search?q={}",
}
hl.env("EDITOR", defaults.editor)
hl.env("HYPR_DOTS_TERMINAL", defaults.terminal)
hl.env("HYPR_DOTS_FILES", defaults.files)
hl.env("HYPR_DOTS_SEARCH_ENGINE", defaults.search_engine)
return defaults
