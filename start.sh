#!/bin/bash

export EFEMERIDES_TOKEN=$(cat efemeridesbot.token)

echo "Getting deps..."
mix deps.get

echo "Compiling..."
mix compile
if [ $? != 0 ]; then
    echo -e "\n\nCould not compile"
    exit 1
fi

echo "Running..."
mix run --no-halt
