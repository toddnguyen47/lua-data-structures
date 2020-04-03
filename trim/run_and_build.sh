#!/bin/bash

# Ref: https://stackoverflow.com/a/7069755
while test $# -gt 0; do
  case "$1" in
    clean)
      # Ref: https://stackoverflow.com/a/4325357
      find ./build -type f -not -name '.gitignore' -print0 | xargs -0 rm --
      shift
      ;;
    *)
      break
      ;;
  esac
done

mkdir -p build
cd build
cmake ../
cmake --build .
