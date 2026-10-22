#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# searchable enabled keybinds using rofi (supports bindd descriptions)

# kill yad to not interfere with this binds
pkill yad || true

# check if rofi is already running
if pidof rofi > /dev/null; then
  pkill rofi
fi

# define the config files
keybinds_conf="$HOME/.config/hypr/configs/Keybinds.conf"
user_keybinds_conf="$HOME/.config/hypr/UserConfigs/UserKeybinds.conf"
laptop_conf="$HOME/.config/hypr/UserConfigs/Laptops.conf"
rofi_theme="$HOME/.config/rofi/config-keybinds.rasi"
msg='☣️ NOTE ☣️: Clicking with Mouse or Pressing ENTER will have NO function'

# collect raw bind lines (strip end-of-line comments) from available files
files=("$keybinds_conf" "$HOME/.config/hypr/configs/Laptops.conf" "$laptop_conf" "$user_keybinds_conf")

# Parse binds using the python script for speed
# The last argument must be the user config for override logic to work correctly
if [[ "${HYPR_CONFIG_FORMAT:-}" == lua ]]; then
  display_keybinds=$(hyprctl -j binds | python3 -c '
import json, sys
for bind in json.load(sys.stdin):
    mods = [name for bit, name in [(64, "SUPER"), (4, "CTRL"), (8, "ALT"), (1, "SHIFT")] if bind.get("modmask", 0) & bit]
    key = bind.get("key") or ("code:" + str(bind.get("keycode", "")))
    print("+".join(mods + [key]) + " — " + (bind.get("description") or bind.get("dispatcher", "")))
')
else
  display_keybinds=$("$HOME/.config/hypr/scripts/keybinds_parser.py" "${files[@]}")
fi

# Check for suggestions file created by python script
if [[ -f "/tmp/hypr_keybind_suggestions_file" ]]; then
  suggestions_file=$(cat "/tmp/hypr_keybind_suggestions_file")
  rm "/tmp/hypr_keybind_suggestions_file"
  if [[ -n "$suggestions_file" && -f "$suggestions_file" ]]; then
     count=$(wc -l < "$suggestions_file")
     msg="$msg | Overrides missing unbind: $count (suggestions: $suggestions_file)"
  fi
fi

# use rofi to display the keybinds
printf '%s\n' "$display_keybinds" | rofi -dmenu -i -config "$rofi_theme" -mesg "$msg"
