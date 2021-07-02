#!/bin/bash/

find . -name '*.gyb' |                                                                          \
    while read file; do                                                                         \
        gyb --line-directive '' -o "../generated/$(basename "${file%.gyb}")" "$file";           \
    done
