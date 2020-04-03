#!/bin/bash

print_help() {
  printf "%s\n" "Compile and build cmake project."
  printf "\n"
  printf "%s\n" "OPTIONAL Commands:"
  printf "    %s\n" "clean    Clean the build folder"
  printf "\n"
  printf "%s\n" "Flags:"
  printf "    %s\n" "-h, --help    Print this help menu"
}

# Ref: https://stackoverflow.com/a/7069755
while test $# -gt 0; do
  case "$1" in
    -h|--help)
      print_help
      exit 0
      ;;
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
