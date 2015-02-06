#!/usr/bin/env bash
# Written by Sean Wareham on October 10, 2014

#------------File System Utils---------------
# Create a directory if needed
createDirIfNeeded() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
    fi
}
