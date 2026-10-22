#!/usr/bin/env bash
# Lua binds are recreated by the config itself on every reload.
[[ "${HYPR_CONFIG_FORMAT:-}" == lua ]] && exit 0
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Initialize J/K keybinds so they always cycle windows globally (no layout-specific behavior)
# This avoids double-actions when layouts change.

set -euo pipefail

# Always reset and bind SUPER+J/K the same way on startup
hyprctl keyword unbind SUPER,J || true
hyprctl keyword unbind SUPER,K || true

# Cycle windows globally: J = next, K = previous
hyprctl keyword bind SUPER,J,cyclenext
hyprctl keyword bind SUPER,K,cyclenext,prev
