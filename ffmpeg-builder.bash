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
. "$SCRIPT_DIR/updateSources.bash"

# Download sources to $BUILD_DIR
. "$SCRIPT_DIR/downloadSources.bash"

# Destroy anything in $BUILD_DIR subdirectories that are not from source
. "$PROJECT_DIR/cleanSources.bash"

# Compile our codecs! (and a container...)
. "$SCRIPT_DIR/compileCodecs.bash"

# Build ffmpeg with all of the bells and whistles
echo "-----Building ffmpeg-----"
export PKG_CONFIG_PATH=$TARGET_DIR/lib/pkgconfig:$PKG_CONFIG_PATH

# Yes, ogg is still not a Codec--but this name still makes sense

cd "$BUILD_DIR/ffmpeg"
# Set external flags
CODEC_FLAGS="--enable-libfaac --enable-libfdk-aac --enable-libmp3lame --enable-libopus --enable-libtheora --enable-libvorbis --enable-libx264 --enable-libx265 --enable-libxvid --enable-libvpx"
STATIC_FLAGS="--disable-shared --extra-cflags="-I$TARGET_DIR/include -static" --extra-ldflags="-L$TARGET_DIR/lib -lm -static" --extra-version=static --enable-static --extra-cflags=--static --pkg-config-flags=--static"
LICENSING_OPTIONS="--enable-gpl --enable-nonfree --enable-version3"
FFMPEG_OPTIONS="--disable-ffserver --enable-gray"

# Set internal flags
PKG_CONFIG_PATH=$TARGET_DIR/lib/pkgconfig:$PKG_CONFIG_PATH
CFLAGS="-I$TARGET_DIR/include"
LDFLAGS="-L$TARGET_DIR/lib -lm"

./configure --prefix=${OUTPUT_DIR:-$TARGET_DIR} $STATIC_FLAGS $LICENSING_OPTIONS $FFMPEG_OPTIONS $CODEC_FLAGS
make
make install
