#!/bin/bash
set -e

# Create a group and user with specified UID and GID
groupadd -g $GID usergroup
useradd -m -s /bin/bash -u $UID -g $GID user

# Update PATH globally
export PATH="/home/user/.local/bin:${PATH}"

# Run as the created user for the next commands
export HOME=/home/user
gosu user sh -c '
    # Check if open-interpreter is already installed
    if ! pip list | grep -q open-interpreter; then
        echo "Installing open-interpreter..."
        pip install --user open-interpreter
    fi

    # Ensure the conversations directory exists
    mkdir -p "/home/user/.config/Open Interpreter/conversations"
'

echo -e "\033[1;93m==========================================\033[0m"
echo -e "\033[1;93m= \033[1;96mWelcome to Open Interpreter\033[0m \033[1;93m=\033[0m"
echo -e "\033[1;93m==========================================\033[0m"
echo -e "\033[1;36mType:\033[0m \033[1;33minterpreter\033[0m"
echo -e "To run \033[1;32mopen-interpreter\033[0m,"
echo -e "See \033[4;34mhttps://docs.openinterpreter.com/usage/terminal/\033[0m"
echo -e "for a \033[1;35musage guide\033[0m."
echo -e "\033[1;93m==========================================\033[0m"


# Background file copy script
LOG_DIR="/home/user/.config/Open Interpreter/conversations"; DEST_DIR="/workspace/chats"; inotifywait -m -e close_write --format '%w%f' "${LOG_DIR}" | while read file; do cp "${file}" "${DEST_DIR}"; done &


# Execute the command specified in the docker run command
exec gosu user "$@"

