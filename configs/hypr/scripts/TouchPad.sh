#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# For disabling touchpad.
# Auto-detect the touchpad, or set TOUCHPAD_DEVICE to a name from hyprctl devices.
# source https://github.com/hyprwm/Hyprland/discussions/4283?sort=new#discussioncomment-8648109

set -euo pipefail

notif="$HOME/.config/swaync/images/ja.png"

touchpad_device="${TOUCHPAD_DEVICE:-}"
if [[ -z "$touchpad_device" ]]; then
    touchpad_device=$(hyprctl -j devices | jq -r '[.mice[] | select(.name | test("touchpad"; "i"))][0].name // empty')
fi

if [[ -z "$touchpad_device" ]]; then
    notify-send -u low -i "$notif" " Touchpad" " No touchpad detected (or set TOUCHPAD_DEVICE)"
    exit 1
fi

touchpad_keyword="${TOUCHPAD_KEYWORD:-device:${touchpad_device}:enabled}"
status_file="${XDG_RUNTIME_DIR:-/tmp}/touchpad-${UID}-${HYPRLAND_INSTANCE_SIGNATURE:-default}.status"

enable_touchpad() {
    notify-send -u low -i "$notif" " Enabling" " touchpad"
    hyprctl -r keyword "$touchpad_keyword" true
    printf "true" >"$status_file"
}

disable_touchpad() {
    notify-send -u low -i "$notif" " Disabling" " touchpad"
    hyprctl -r keyword "$touchpad_keyword" false
    printf "false" >"$status_file"
}

current_state="true"
if [[ -f "$status_file" ]]; then
    current_state="$(<"$status_file")"
fi

if [[ "$current_state" == "true" ]]; then
    disable_touchpad
else
    enable_touchpad
fi
