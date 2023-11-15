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
'

# Execute the command specified in the docker run command
exec gosu user "$@"

