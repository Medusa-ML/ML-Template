#!/bin/bash

# Check if the setup for the custom entrypoint is enabled
if [ "$SETUP_ENTRYPOINT" = "true" ]; then
    chmod +x /install_interpreter.sh
    exec /install_interpreter.sh "$@"
else
    # Default command or shell
    exec "$@"
fi
