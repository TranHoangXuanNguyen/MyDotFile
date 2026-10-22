#!/usr/bin/env bash
# Native Lua sessions use the same action as the keybinding.
if [[ "${HYPR_CONFIG_FORMAT:-}" == lua ]]; then
    [[ "${1:-}" == init ]] && exit 0
    exec /usr/bin/hyprctl eval 'hypr_dots.toggle_blur()'
fi
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for changing blurs on the fly

notif="$HOME/.config/swaync/images"

STATE=$(hyprctl -j getoption decoration:blur:passes | jq ".int")

if [ "${STATE}" == "2" ]; then
	hyprctl keyword decoration:blur:size 2
	hyprctl keyword decoration:blur:passes 1
 	notify-send -e -u low -i "$notif/note.png" " Less Blur"
else
	hyprctl keyword decoration:blur:size 5
	hyprctl keyword decoration:blur:passes 2
  	notify-send -e -u low -i "$notif/ja.png" " Normal Blur"
fi
