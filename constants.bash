#!/usr/bin/env bash

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

#Options
# Use GNU Parallel to compile codecs; makes setup *much* faster on multicore machines
USE_PARALLEL=1
# Whether or not to copy ffmpeg binary from target/bin  
COPY_FFMPEG_BINARY=1
# Only relevant if COPY_FFMPEG_BINARY=1; if destination not given, defaults to ~/bin
FFMPEG_BINARY_DESTINATION="$HOME/bin"
# Whether or not copying the binary needs root. Only really useful when the binary 
# needs to be in a privileged area. DO NOT use this if not necessary
#COPY_FFMPEG_NEEDS_ROOT=1
