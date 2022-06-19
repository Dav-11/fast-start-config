#!/bin/bash

# check if OS is Linux
if [[ "$OSTYPE" != "linux-gnu"* ]]; then
    echo "Unsupported OS: " "$OSTYPE"
fi

# check os Family

