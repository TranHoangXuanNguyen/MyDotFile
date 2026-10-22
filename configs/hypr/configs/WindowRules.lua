-- Native window and layer rules; tags are registered before effects.
hl.window_rule({
    name = "dots-window-001",
    match = {
        class = "^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr|[Ff]irefox-bin)$",
    },
    tag = "+browser",
})
hl.window_rule({
    name = "dots-window-002",
    match = {
        class = "^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$",
    },
    tag = "+browser",
})
hl.window_rule({
    name = "dots-window-003",
    match = {
        class = "^(chrome-.+-Default)$",
    },
    tag = "+browser",
})
hl.window_rule({
    name = "dots-window-004",
    match = {
        class = "^([Cc]hromium)$",
    },
    tag = "+browser",
})
hl.window_rule({
    name = "dots-window-005",
    match = {
        class = "^([Mm]icrosoft-edge(-stable|-beta|-dev|-unstable))$",
    },
    tag = "+browser",
})
hl.window_rule({
    name = "dots-window-006",
    match = {
        class = "^(Brave-browser(-beta|-dev|-unstable)?)$",
    },
    tag = "+browser",
})
hl.window_rule({
    name = "dots-window-007",
    match = {
        class = "^([Tt]horium-browser|[Cc]achy-browser)$",
    },
    tag = "+browser",
})
hl.window_rule({
    name = "dots-window-008",
    match = {
        class = "^(zen-alpha|zen)$",
    },
    tag = "+browser",
})
hl.window_rule({
    name = "dots-window-009",
    match = {
        class = "^(swaync-control-center|swaync-notification-window|swaync-client|class)$",
    },
    tag = "+notif",
})
hl.window_rule({
    name = "dots-window-010",
    match = {
        title = "^(KooL Quick Cheat Sheet)$",
    },
    tag = "+KooL_Cheat",
})
hl.window_rule({
    name = "dots-window-011",
    match = {
        title = "^(KooL Hyprland Settings)$",
    },
    tag = "+KooL_Settings",
})
hl.window_rule({
    name = "dots-window-012",
    match = {
        class = "^(nwg-displays|nwg-look)$",
    },
    tag = "+KooL-Settings",
})
hl.window_rule({
    name = "dots-window-013",
    match = {
        class = "^(Alacritty|kitty|kitty-dropterm)$",
    },
    tag = "+terminal",
})
hl.window_rule({
    name = "dots-window-014",
    match = {
        class = "^([Tt]hunderbird|org.mozilla.Thunderbird)$",
    },
    tag = "+email",
})
hl.window_rule({
    name = "dots-window-015",
    match = {
        class = "^(eu.betterbird.Betterbird)$",
    },
    tag = "+email",
})
hl.window_rule({
    name = "dots-window-016",
    match = {
        class = "^(org.gnome.Evolution)$",
    },
    tag = "+email",
})
hl.window_rule({
    name = "dots-window-017",
    match = {
        class = "^(codium|codium-url-handler|VSCodium)$",
    },
    tag = "+projects",
})
hl.window_rule({
    name = "dots-window-018",
    match = {
        class = "^(VSCode|code|code-url-handler)$",
    },
    tag = "+projects",
})
hl.window_rule({
    name = "dots-window-019",
    match = {
        class = "^(jetbrains-.+)$",
    },
    tag = "+projects",
})
hl.window_rule({
    name = "dots-window-020",
    match = {
        class = "^(dev.zed.Zed|antigravity)$",
    },
    tag = "+projects",
})
hl.window_rule({
    name = "dots-window-021",
    match = {
        class = "^(com.obsproject.Studio)$",
    },
    tag = "+screenshare",
})
hl.window_rule({
    name = "dots-window-022",
    match = {
        class = "^([Dd]iscord|[Ww]ebCord|[Vv]esktop)$",
    },
    tag = "+im",
})
hl.window_rule({
    name = "dots-window-023",
    match = {
        class = "^([Ff]erdium)$",
    },
    tag = "+im",
})
hl.window_rule({
    name = "dots-window-024",
    match = {
        class = "^([Ww]hatsapp-for-linux)$",
    },
    tag = "+im",
})
hl.window_rule({
    name = "dots-window-025",
    match = {
        class = "^(org.telegram.desktop|io.github.tdesktop_x64.TDesktop)$",
    },
    tag = "+im",
})
hl.window_rule({
    name = "dots-window-026",
    match = {
        class = "^(teams-for-linux)$",
    },
    tag = "+im",
})
hl.window_rule({
    name = "dots-window-027",
    match = {
        class = "^(im.riot.Riot|Element)$",
    },
    tag = "+im",
})
hl.window_rule({
    name = "dots-window-028",
    match = {
        class = "^(gamescope)$",
    },
    tag = "+games",
})
hl.window_rule({
    name = "dots-window-029",
    match = {
        class = "^(steam_app_[0-9]+)$",
    },
    tag = "+games",
})
hl.window_rule({
    name = "dots-window-030",
    match = {
        class = "^([Ss]team)$",
    },
    tag = "+gamestore",
})
hl.window_rule({
    name = "dots-window-031",
    match = {
        title = "^([Ll]utris)$",
    },
    tag = "+gamestore",
})
hl.window_rule({
    name = "dots-window-032",
    match = {
        class = "^(com.heroicgameslauncher.hgl)$",
    },
    tag = "+gamestore",
})
hl.window_rule({
    name = "dots-window-033",
    match = {
        class = "^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt|org.kde.dolphin)$",
    },
    tag = "+file-manager",
})
hl.window_rule({
    name = "dots-window-034",
    match = {
        class = "^(app.drey.Warp)$",
    },
    tag = "+file-manager",
})
hl.window_rule({
    name = "dots-window-035",
    match = {
        class = "^([Ww]aytrogen)$",
    },
    tag = "+wallpaper",
})
hl.window_rule({
    name = "dots-window-036",
    match = {
        class = "^([Aa]udacious)$",
    },
    tag = "+multimedia",
})
hl.window_rule({
    name = "dots-window-037",
    match = {
        class = "^([Mm]pv|vlc)$",
    },
    tag = "+multimedia_video",
})
hl.window_rule({
    name = "dots-window-038",
    match = {
        title = "^(ROG Control)$",
    },
    tag = "+settings",
})
hl.window_rule({
    name = "dots-window-039",
    match = {
        class = "^(wihotspot(-gui)?)$",
    },
    tag = "+settings",
})
hl.window_rule({
    name = "dots-window-040",
    match = {
        class = "^([Bb]aobab|org.gnome.[Bb]aobab)$",
    },
    tag = "+settings",
})
hl.window_rule({
    name = "dots-window-041",
    match = {
        class = "^(gnome-disks|wihotspot(-gui)?)$",
    },
    tag = "+settings",
})
hl.window_rule({
    name = "dots-window-042",
    match = {
        title = "(Kvantum Manager)",
    },
    tag = "+settings",
})
hl.window_rule({
    name = "dots-window-043",
    match = {
        class = "^(file-roller|org.gnome.FileRoller)$",
    },
    tag = "+settings",
})
hl.window_rule({
    name = "dots-window-044",
    match = {
        class = "^(nm-applet|nm-connection-editor|blueman-manager)$",
    },
    tag = "+settings",
})
hl.window_rule({
    name = "dots-window-045",
    match = {
        class = "^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$",
    },
    tag = "+settings",
})
hl.window_rule({
    name = "dots-window-046",
    match = {
        class = "^(qt5ct|qt6ct)$",
    },
    tag = "+settings",
})
hl.window_rule({
    name = "dots-window-047",
    match = {
        class = "(xdg-desktop-portal-gtk)",
    },
    tag = "+settings",
})
hl.window_rule({
    name = "dots-window-048",
    match = {
        class = "^(org.kde.polkit-kde-authentication-agent-1)$",
    },
    tag = "+settings",
})
hl.window_rule({
    name = "dots-window-049",
    match = {
        class = "^([Rr]ofi)$",
    },
    tag = "+settings",
})
hl.window_rule({
    name = "dots-window-050",
    match = {
        class = "^(btrfs-assistant)$",
    },
    tag = "+settings",
})
hl.window_rule({
    name = "dots-window-051",
    match = {
        class = "^(timeshift-gtk)$",
    },
    tag = "+settings",
})
hl.window_rule({
    name = "dots-window-052",
    match = {
        class = "^(gnome-system-monitor|org.gnome.SystemMonitor|io.missioncenter.MissionCenter)$",
    },
    tag = "+viewer",
})
hl.window_rule({
    name = "dots-window-053",
    match = {
        class = "^(evince)$",
    },
    tag = "+viewer",
})
hl.window_rule({
    name = "dots-window-054",
    match = {
        class = "^(eog|org.gnome.Loupe)$",
    },
    tag = "+viewer",
})
hl.window_rule({
    name = "dots-window-055",
    match = {
        tag = "multimedia_video",
    },
    no_blur = true,
})
hl.window_rule({
    name = "dots-window-056",
    match = {
        tag = "multimedia_video",
    },
    opacity = "1.0",
})
hl.window_rule({
    name = "dots-window-057",
    match = {
        tag = "multimedia",
    },
    no_blur = true,
})
hl.window_rule({
    name = "dots-window-058",
    match = {
        tag = "multimedia",
    },
    opacity = "1.0",
})
hl.window_rule({
    name = "dots-window-059",
    match = {
        tag = "KooL_Cheat",
    },
    center = true,
})
hl.window_rule({
    name = "dots-window-060",
    match = {
        tag = "KooL-Settings",
    },
    center = true,
})
hl.window_rule({
    name = "dots-window-061",
    match = {
        title = "^(ROG Control)$",
    },
    center = true,
})
hl.window_rule({
    name = "dots-window-062",
    match = {
        title = "^(Keybindings)$",
    },
    center = true,
})
hl.window_rule({
    name = "dots-window-063",
    match = {
        class = "^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$",
    },
    center = true,
})
hl.window_rule({
    name = "dots-window-064",
    match = {
        class = "^([Ff]erdium)$",
    },
    center = true,
})
hl.window_rule({
    name = "dots-window-069",
    match = {
        tag = "KooL_Cheat",
    },
    float = true,
})
hl.window_rule({
    name = "dots-window-070",
    match = {
        tag = "wallpaper",
    },
    float = true,
    center = true,
})
hl.window_rule({
    name = "dots-window-071",
    match = {
        tag = "settings",
    },
    float = true,
    center = true,
})
hl.window_rule({
    name = "dots-window-072",
    match = {
        tag = "viewer",
    },
    float = true,
    center = true,
})
hl.window_rule({
    name = "dots-window-073",
    match = {
        tag = "KooL-Settings",
    },
    float = true,
    center = true,
})
hl.window_rule({
    name = "dots-window-074",
    match = {
        class = "([Zz]oom|onedriver|onedriver-launcher)",
    },
    float = true,
})
hl.window_rule({
    name = "dots-window-075",
    match = {
        class = "(org.gnome.Calculator|qalculate-gtk)",
    },
    float = true,
})
hl.window_rule({
    name = "dots-window-076",
    match = {
        class = "^(mpv|com.github.rafostar.Clapper)$",
    },
    float = true,
})
hl.window_rule({
    name = "dots-window-077",
    match = {
        class = "^([Qq]alculate-gtk)$",
    },
    float = true,
})
hl.window_rule({
    name = "dots-window-078",
    match = {
        class = "^([Ff]erdium)$",
    },
    float = true,
})
hl.window_rule({
    name = "dots-window-079",
    match = {
        title = "^(Authentication Required)$",
    },
    float = true,
    center = true,
})
hl.window_rule({
    name = "dots-window-080",
    match = {
        class = "(codium|codium-url-handler|VSCodium)",
        title = "negative:(.*codium.*|.*VSCodium.*)",
    },
    float = true,
})
hl.window_rule({
    name = "dots-window-081",
    match = {
        class = "^(com.heroicgameslauncher.hgl)$",
        title = "negative:(Heroic Games Launcher)",
    },
    float = true,
})
hl.window_rule({
    name = "dots-window-082",
    match = {
        class = "^([Ss]team)$",
        title = "negative:^([Ss]team)$",
    },
    float = true,
})
hl.window_rule({
    name = "dots-window-083",
    match = {
        title = "^(Add Folder to Workspace)$",
    },
    float = true,
    size = "(monitor_w*0.7) (monitor_h*0.6)",
    center = true,
})
hl.window_rule({
    name = "dots-window-084",
    match = {
        title = "^(Save As)$",
    },
    float = true,
    size = "(monitor_w*0.7) (monitor_h*0.6)",
    center = true,
})
hl.window_rule({
    name = "dots-window-085",
    match = {
        initial_title = "(Open Files)",
    },
    float = true,
    size = "(monitor_w*0.7) (monitor_h*0.6)",
})
hl.window_rule({
    name = "dots-window-086",
    match = {
        title = "^(SDDM Background)$",
    },
    float = true,
    center = true,
    size = "(monitor_w*0.16) (monitor_h*0.12)",
})
hl.window_rule({
    name = "dots-window-087",
    match = {
        class = "^(yad)$",
    },
    float = true,
    center = true,
    size = "(monitor_w*0.2) (monitor_h*0.2)",
})
hl.window_rule({
    name = "dots-window-088",
    match = {
        class = "^(hyprland-donate-screen)$",
    },
    float = true,
    center = true,
})
hl.window_rule({
    name = "dots-window-089",
    match = {
        tag = "browser",
    },
    opacity = "0.99 0.8",
})
hl.window_rule({
    name = "dots-window-090",
    match = {
        tag = "projects",
    },
    opacity = "0.9 0.8",
})
hl.window_rule({
    name = "dots-window-091",
    match = {
        tag = "im",
    },
    opacity = "0.94 0.86",
})
hl.window_rule({
    name = "dots-window-092",
    match = {
        tag = "multimedia",
    },
    opacity = "0.94 0.86",
})
hl.window_rule({
    name = "dots-window-093",
    match = {
        tag = "file-manager",
    },
    opacity = "0.9 0.8",
})
hl.window_rule({
    name = "dots-window-094",
    match = {
        tag = "terminal",
    },
    opacity = "0.9 0.7",
})
hl.window_rule({
    name = "dots-window-095",
    match = {
        tag = "settings",
    },
    opacity = "0.8 0.7",
})
hl.window_rule({
    name = "dots-window-096",
    match = {
        tag = "viewer",
    },
    opacity = "0.82 0.75",
})
hl.window_rule({
    name = "dots-window-097",
    match = {
        tag = "wallpaper",
    },
    opacity = "0.9 0.7",
})
hl.window_rule({
    name = "dots-window-098",
    match = {
        class = "^(gedit|org.gnome.TextEditor|mousepad)$",
    },
    opacity = "0.8 0.7",
})
hl.window_rule({
    name = "dots-window-099",
    match = {
        class = "^(deluge)$",
    },
    opacity = "0.9 0.8",
})
hl.window_rule({
    name = "dots-window-100",
    match = {
        class = "^(seahorse)$",
    },
    opacity = "0.9 0.8",
})
hl.window_rule({
    name = "dots-window-101",
    match = {
        title = "^(Picture-in-Picture)$",
    },
    opacity = "0.95 0.75",
})
hl.window_rule({
    name = "dots-window-102",
    match = {
        tag = "KooL_Cheat",
    },
    size = "(monitor_w*0.65) (monitor_h*0.9)",
})
hl.window_rule({
    name = "dots-window-103",
    match = {
        tag = "wallpaper",
    },
    size = "(monitor_w*0.7) (monitor_h*0.7)",
})
hl.window_rule({
    name = "dots-window-104",
    match = {
        tag = "settings",
    },
    size = "(monitor_w*0.7) (monitor_h*0.7)",
})
hl.window_rule({
    name = "dots-window-105",
    match = {
        class = "^([Ff]erdium)$",
    },
    size = "(monitor_w*0.6) (monitor_h*0.7)",
})
hl.window_rule({
    name = "dots-window-106",
    match = {
        tag = "games",
    },
    no_blur = true,
    fullscreen = true,
})
hl.window_rule({
    name = "dots-window-108",
    match = {
        class = "^(jetbrains-.*)$",
    },
    no_initial_focus = true,
})
hl.window_rule({
    name = "dots-window-109",
    match = {
        title = "^(wind.*)$",
    },
    no_initial_focus = true,
})
hl.layer_rule({
    name = "dots-layer-110",
    match = {
        namespace = "rofi",
    },
    blur = true,
})
hl.layer_rule({
    name = "dots-layer-111",
    match = {
        namespace = "notifications",
    },
    blur = true,
})
hl.layer_rule({
    name = "dots-layer-112",
    match = {
        namespace = "quickshell:overview",
    },
    blur = true,
})
hl.layer_rule({
    name = "dots-layer-113",
    match = {
        namespace = "quickshell:overview",
    },
    ignore_alpha = 0.5,
})
hl.window_rule({
    name = "Whatsapp-zapzap",
    match = {
        class = "^([Ww]hatsapp-for-linux|ZapZap|com.rtosta.zapzap)$",
    },
    size = "(monitor_w*0.6) (monitor_h*0.7)",
    center = true,
})
hl.window_rule({
    name = "Picture-in-Picture",
    match = {
        title = "^(Picture-in-Picture)$",
    },
    float = true,
    move = "72% 7%",
    opacity = "0.95 0.75",
    pin = true,
    keep_aspect_ratio = true,
    size = "(monitor_w*0.3) (monitor_h*0.3)",
})
hl.window_rule({
    name = "Thunar-Progress-bar",
    match = {
        class = "^(thunar)$",
        title = "^(File Operation Progress)$",
    },
    float = true,
    center = true,
    size = "(monitor_w*0.26) (monitor_h*0.18)",
})
hl.window_rule({ name = "fullscreen-idle", match = { fullscreen = true }, idle_inhibit = "fullscreen" })
