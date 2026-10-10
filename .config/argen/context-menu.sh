#!/usr/bin/env bash

declare -A ACTIONS=(
    ["Switch Contexts Interactively"]='
        argenctl context switch "$(argenctl context list | fuzzel -d --prompt "switch > ")"
    '

    ["Create New Context Interactively"]='
        set -eu
        prompt="$(fuzzel -d --prompt-only "new > ")"
        argenctl context new "$prompt"
    '
    
    ["Close Context Interactively"]='
        set -eu
        prompt="$(argenctl context list | fuzzel -d --prompt "close > ")"
        argenctl context close "$prompt"
    '
   
    ["Rename Current Context Interactively"]='
        set -eu
        prompt="$(fuzzel -d --prompt-only "rename > ")"
        argenctl context rename "$prompt"
    '

    ["Assign Focused Window To Be Toggled"]='
        set -eu
        id=$(argenctl window list --json | jq -r ".[] | select(.focused) | .id")
        argenctl binding set normal Super U window toggle "$id"
    '

    ["Attach Window Interactively"]='
        set -eu
        id=$(argenctl window list | fuzzel -d --with-nth 2 --accept-nth 1 --only-match)
        argenctl window attach "$id"
    '

    ["Adopt All Orphans"]='
        argenctl window list --json | jq -r ".[] | select(.contexts | length == 0) | .id" | while read -r id; do
        argenctl window attach "$id"
        done
    '
)

declare -A KEYBINDS=(
    ["Switch Contexts Interactively"]="Super Space"
    ["Create New Context Interactively"]="Super+Shift Space"
    ["Rename Current Context Interactively"]="Super+Control Space"
    ["Assign Focused Window To Be Toggled"]="Super+Shift U"
    ["Attach Window Interactively"]="Super+Shift D"
    ["Adopt All Orphans"]="Super+Control D"
    ["Close Context Interactively"]="(None)"
)

# Build the formatted menu list dynamically
MENU_ITEMS=()
declare -A MENU_MAP

for action in "${!ACTIONS[@]}"; do
    if [[ -n "${KEYBINDS[$action]:-}" ]]; then
        display_str="$action: ${KEYBINDS[$action]}"
    else
        display_str="$action"
    fi
    MENU_ITEMS+=("$display_str")
    MENU_MAP["$display_str"]="${ACTIONS[$action]}"
done

# Pass the formatted options to fuzzel
SELECTION=$(printf "%s\n" "${MENU_ITEMS[@]}" | fuzzel --dmenu --prompt="argen: ")

# Execute the command linked to the selected menu string
if [[ -n "$SELECTION" && -n "${MENU_MAP[$SELECTION]:-}" ]]; then
    eval "${MENU_MAP[$SELECTION]}"
fi
