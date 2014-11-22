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

# Update sources already present in $BUILD_DIR
. "$SCRIPT_DIR/updateSources.bash"

# Download sources to $BUILD_DIR
. "$SCRIPT_DIR/downloadSources.bash"

# Destroy anything in $BUILD_DIR subdirectories that are not from source
. "$PROJECT_DIR/cleanSources.bash"

. "$SCRIPT_DIR/compileCodecs.bash"

# Build ffmpeg with all of the bells and whistles
echo "-----Building ffmpeg-----"
export PKG_CONFIG_PATH=$TARGET_DIR/lib/pkgconfig:$PKG_CONFIG_PATH
cd "$BUILD_DIR/ffmpeg"
CFLAGS="-I$TARGET_DIR/include" LDFLAGS="-L$TARGET_DIR/lib -lm" ./configure --prefix=${OUTPUT_DIR:-$TARGET_DIR} --extra-cflags="-I$TARGET_DIR/include -static" --extra-ldflags="-L$TARGET_DIR/lib -lm -static" --extra-version=static --disable-shared --enable-static --extra-cflags=--static --pkg-config-flags=--static --disable-ffserver --disable-doc --enable-gpl --enable-pthreads --enable-postproc --enable-gray --enable-runtime-cpudetect --enable-libfaac --enable-libfdk-aac --enable-libmp3lame --enable-libopus --enable-libtheora --enable-libvorbis --enable-libx264 --enable-libx265 --enable-libxvid --enable-bzlib --enable-zlib --enable-nonfree --enable-version3 --enable-libvpx --disable-devices
make
make install