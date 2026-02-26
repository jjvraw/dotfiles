#!/usr/bin/env bash
ORIGINAL_COMMAND="$1"
DIRECTORY="$2"
SESSION_DIR="$HOME/.local/share/nvim/tmux-sessions"

get_tmux_identifiers() {
    local session_id_raw=$(tmux display-message -p "#{session_id}")
    local session_id=${session_id_raw#\$}
    local window_index=$(tmux display-message -p "#{window_index}")
    local pane_index=$(tmux display-message -p "#{pane_index}")
    echo "${session_id}-${window_index}-${pane_index}"
}

get_session_file() {
    local identifiers=$(get_tmux_identifiers)
    local cwd_hash=$(echo "$DIRECTORY" | sed 's|/|_|g')
    echo "${SESSION_DIR}/${cwd_hash}-${identifiers}.vim"
}

nvim_session_file_exists_for_identifiers() {
    local session_file=$(get_session_file)
    [ -e "$session_file" ]
}

nvim_session_file_exists() {
    [ -e "${DIRECTORY}/Session.vim" ]
}

original_command_contains_session_flag() {
    [[ "$ORIGINAL_COMMAND" =~ "-S" ]]
}

main() {
    if nvim_session_file_exists_for_identifiers; then
        local session_file=$(get_session_file)
        echo "nvim -S ${session_file}"
    elif original_command_contains_session_flag; then
        echo "nvim"
    else
        echo "$ORIGINAL_COMMAND"
    fi
}
main
