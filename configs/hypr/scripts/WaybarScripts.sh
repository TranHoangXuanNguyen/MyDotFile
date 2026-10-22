#!/usr/bin/env bash
# Use the same app defaults as the config, without evaluating config as shell.
source "$HOME/.config/hypr/scripts/UserDefaults.sh"

case "${1:-}" in
    --btop) $term --title btop -e btop ;;
    --nvtop) $term --title nvtop -e nvtop ;;
    --nmtui) $term -e nmtui ;;
    --term) $term & ;;
    --files) $files & ;;
    *) printf 'Usage: %s [--btop|--nvtop|--nmtui|--term|--files]\n' "$0"; exit 1 ;;
esac
