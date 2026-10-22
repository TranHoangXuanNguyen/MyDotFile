#!/usr/bin/env bash
# Shared by shell menus; never source a Hyprland config as shell code.
term="${HYPR_DOTS_TERMINAL:-kitty}"
edit="${EDITOR:-nvim}"
files="${HYPR_DOTS_FILES:-dolphin}"
default_search_engine='https://www.google.com/search?q={}'
Search_Engine="${HYPR_DOTS_SEARCH_ENGINE:-$default_search_engine}"
if [[ "${HYPR_CONFIG_FORMAT:-}" != lua ]]; then
    defaults_file="$HOME/.config/hypr/UserConfigs/01-UserDefaults.conf"
    read_default() {
        awk -F= -v key="$1" '$1 ~ "^\\$" key "[[:space:]]*$" {
            sub(/^[^=]*=/, ""); sub(/[[:space:]]*#.*/, "");
            gsub(/^[[:space:]]+|[[:space:]]+$/, ""); gsub(/^"|"$/, ""); print; exit
        }' "$defaults_file"
    }
    term="$(read_default term)"
    files="$(read_default files)"
    files="${files:-dolphin}"
    Search_Engine="$(read_default Search_Engine)"
    term="${term:-kitty}"
    Search_Engine="${Search_Engine:-$default_search_engine}"
fi
