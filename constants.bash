#!/bin/bash

# Written by Sean Wareham on November 21, 2014
# This script holds the constants used to build ffmpeg

# Great one liner sourced from https://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
# Gives us the directory of this script
PROJECT_DIR="$HOME/Software/ffmpeg"
BUILD_DIR="${BUILD_DIR:-$PROJECT_DIR/build}"
#NOTE: many of the underlying tools to build sources do not support directories
# with whitespace in them.  TARGET_DIR must not contain whitespace.
#(the binaries can easily be moved afterwards, however)
TARGET_DIR="${TARGET_DIR:-$PROJECT_DIR/target}"