#!/bin/bash

# Ref: https://unix.stackexchange.com/a/12904
find . ! -name ".gitignore" ! -name "." ! -name "clean_build_directory.sh" -exec rm -rf {} +
