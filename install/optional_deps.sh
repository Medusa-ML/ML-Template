#!/bin/bash
if [ "$OPTIONAL_INSTALLS" = "true" ]; then
    pip install --pre torchtext -f https://download.pytorch.org/whl/nightly/cpu/torch_nightly.html
fi
