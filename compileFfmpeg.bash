#!/usr/bin/env bash
. constants.bash

# Build ffmpeg with all of the bells and whistles
echo "-----Compiling ffmpeg-----"
cd "$BUILD_DIR/ffmpeg"
# Set external flags
# Yes, ogg is still not a Codec--but this name still makes sense
CODEC_FLAGS="--enable-libfaac --enable-libfdk-aac --enable-libmp3lame --enable-libopus --enable-libtheora --enable-libvorbis --enable-libx264 --enable-libx265 --enable-libxvid --enable-libvpx"
STATIC_FLAGS="--disable-shared --extra-version=static --enable-static --extra-cflags=--static --pkg-config-flags=--static"
LICENSING_OPTIONS="--enable-gpl --enable-nonfree --enable-version3"
FFMPEG_OPTIONS="--disable-ffserver --enable-gray"

# Set internal flags
export PKG_CONFIG_PATH=$TARGET_DIR/lib/pkgconfig:$PKG_CONFIG_PATH
CFLAGS="-I$TARGET_DIR/include"
LDFLAGS="-L$TARGET_DIR/lib -lm"

./configure --prefix=${OUTPUT_DIR:-$TARGET_DIR} --extra-cflags="-I$TARGET_DIR/include -static" --extra-ldflags="-L$TARGET_DIR/lib -lm -static" $STATIC_FLAGS $LICENSING_OPTIONS $FFMPEG_OPTIONS $CODEC_FLAGS
make
make install
exit 0
