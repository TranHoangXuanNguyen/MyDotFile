-- Preserve the current small gaps, square corners, and one-pass blur.
hl.config({
    general = {
        border_size = 2,
        gaps_in = 2,
        gaps_out = 4,
    },
    decoration = {
        rounding = 0,
        active_opacity = 1.0,
        inactive_opacity = 0.9,
        fullscreen_opacity = 1.0,
        dim_inactive = true,
        dim_strength = 0.1,
        dim_special = 0.8,
        shadow = {
            enabled = true,
            range = 3,
            render_power = 1,
        },
        blur = {
            enabled = true,
            size = 4,
            passes = 1,
            new_optimizations = true,
            xray = true,
            ignore_opacity = true,
            special = false,
            popups = false,
        },
    },
    group = {
    },
})
hypr_dots.apply_colors()
