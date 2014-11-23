#!/bin/bash

# Written by Sean Wareham on November 21, 2014
# This script aims to provide a one-press solution to installing ffmpeg
# with most the most popular codecs up-to-date 


# Great one liner sourced from https://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
# Gives us the directory of this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Load Constants
. "$SCRIPT_DIR/constants.bash" 

# Load Utils
. "$SCRIPT_DIR/utils.bash"

createDirIfNeeded "$PROJECT_DIR"
createDirIfNeeded "$BUILD_DIR"
createDirIfNeeded "$TARGET_DIR"

# Install prerequisites if needed
"$SCRIPT_DIR/checkAndInstallPrereqs.bash"

# Update sources already present in $BUILD_DIR
"$SCRIPT_DIR/updateSources.bash"

# Download sources to $BUILD_DIR
"$SCRIPT_DIR/downloadSources.bash"

# Destroy anything in $BUILD_DIR subdirectories that are not from source
"$SCRIPT_DIR/cleanSources.bash"

# Compile our codecs! (and a container...)
"$SCRIPT_DIR/compileCodecs.bash"

# Compile ffmpeg with all of the bells and whistles
"$SCRIPT_DIR/compileFfmpeg.bash"
exit
