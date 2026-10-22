#!/usr/bin/env bash
# Toggle the layout while keeping J/K as global window cycling shortcuts.
set -euo pipefail
if [[ "${HYPR_CONFIG_FORMAT:-}" == lua ]]; then
    [[ "${1:-}" == init ]] && exit 0
    exec /usr/bin/hyprctl eval 'hypr_dots.toggle_layout()'
fi

layout=$(hyprctl -j getoption general:layout | jq -r '.str')
if [[ "${1:-}" != init ]]; then
    if [[ "$layout" == master ]]; then layout=dwindle; else layout=master; fi
    hyprctl keyword general:layout "$layout"
fi
hyprctl keyword unbind SUPER,J
hyprctl keyword unbind SUPER,K
hyprctl keyword unbind SUPER,O
hyprctl keyword bind SUPER,J,cyclenext
hyprctl keyword bind SUPER,K,cyclenext,prev
if [[ "$layout" == dwindle ]]; then
    hyprctl keyword bind SUPER,O,layoutmsg,togglesplit
else
    hyprctl keyword bind SUPER,O,layoutmsg,swapwithmaster
fi
if [[ "${1:-}" != init ]]; then
    notify-send -e -u low -i "$HOME/.config/swaync/images/ja.png" "$layout layout"
fi
