#!/usr/bin/env bash

ORIGINAL_COMMAND="$1"
DIRECTORY="$2"

get_tmux_identifiers() {
    local session_id_raw=$(tmux display-message -p "#{session_id}")
    local session_id=${session_id_raw#\$}
    local window_index=$(tmux display-message -p "#{window_index}")
    local pane_index=$(tmux display-message -p "#{pane_index}")
    echo "${session_id}-${window_index}-${pane_index}"
}

nvim_session_file_exists_for_identifiers() {
    local identifiers=$(get_tmux_identifiers)
    [ -e "${DIRECTORY}/.TmuxNvimSession-${identifiers}.vim" ]
}

nvim_session_file_exists() {
    [ -e "${DIRECTORY}/Session.vim" ]
}

original_command_contains_session_flag() {
    [[ "$ORIGINAL_COMMAND" =~ "-S" ]]
}

main() {
    if nvim_session_file_exists_for_identifiers; then
        local identifiers=$(get_tmux_identifiers)
        echo "nvim -S ${DIRECTORY}/.TmuxNvimSession-${identifiers}.vim"
    elif nvim_session_file_exists; then
        echo "nvim -S"
    elif original_command_contains_session_flag; then
        echo "nvim"
    else
        echo "$ORIGINAL_COMMAND"
    fi
}
main
