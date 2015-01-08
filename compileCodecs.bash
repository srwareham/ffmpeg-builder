#!/bin/bash

# Written by Sean Wareham on November 21, 2014
# This script compiles many of the codes / containers used in ffmpeg

# Import constants
# NOTE: constants.bash must remain in the same directory as this file
. constants.bash

# NOTE: SHELL for this script *must* be bash due to GNU parallel implementation.
# See https://stackoverflow.com/questions/23814360/gnu-parallel-and-bash-functions-how-to-run-the-simple-example-from-the-manual for further detail.
export SHELL=$(type -p bash)

#NOTE: TARGET_DIR is not escaped to serve as a reminder that it cannot contain whitespace (thanks old build tools)

# Need ogg before vorbis
buildOgg(){
    # annoyingly need to import constants every time because of GNU parallel
    . constants.bash
    echo "-----Compiling libogg-----"
    cd "$BUILD_DIR/ogg"
    ./autogen.sh
    ./configure --prefix=$TARGET_DIR --enable-static --disable-shared
    make
    make install
}
export -f buildOgg

# Need vorbis before theora
buildVorbis(){
    . constants.bash
    echo "-----Compiling libvorbis--"
    cd "$BUILD_DIR/vorbis"
    ./autogen.sh
    ./configure --prefix=$TARGET_DIR --enable-static --disable-shared
    make
    make install
}
export -f buildVorbis

buildTheora(){
    . constants.bash
    echo "-----Compiling libtheora--"
    cd "$BUILD_DIR/theora"
    ./autogen.sh
    ./configure --prefix=$TARGET_DIR --enable-static --disable-shared
    make
    make install
}
export -f buildTheora

buildOggVorbisTheora(){
    buildOgg
    buildVorbis
    buildTheora
}
export -f buildOggVorbisTheora

buildVpx(){
    . constants.bash
    echo "-----Compiling libvpx-----"
    cd "$BUILD_DIR/libvpx"
    ./configure --prefix=$TARGET_DIR --disable-shared
    make
    make install
}
export -f buildVpx

buildFaac(){
    . constants.bash
    echo "-----Compiling libfaac----"
    cd "$BUILD_DIR/libfaac"
    ./configure --prefix=$TARGET_DIR --enable-static --disable-shared
    make
    make install
}
export -f buildFaac

buildFdkaac(){
    . constants.bash
    echo "-----Compiling libfdk-aac----"
    cd "$BUILD_DIR/fdk-aac"
    ./autogen.sh
    ./configure --prefix=$TARGET_DIR --enable-static --disable-shared
    make
    make install
}
export -f buildFdkaac

buildX264(){
    . constants.bash
    echo "-----Compiling libx264----"
    cd "$BUILD_DIR/x264"
    ./configure --prefix=$TARGET_DIR --enable-static --disable-shared
    make
    make install
}
export -f buildX264

#Note: the make x265-static CMakeLists.txt call is broken. Have to build shared too :(
buildX265(){
    . constants.bash
    echo "-----Compiling libx265----"
    cd "$BUILD_DIR/x265"
    cmake -DCMAKE_INSTALL_PREFIX:PATH=$TARGET_DIR \
    -DLIBRARY_OUTPUT_PATH:PATH=$TARGET_DIR/lib \
    -DBIN_INSTALL_DIR:PATH=$TARGET_DIR/bin \
    -DBUILD_SHARED_LIBS:BOOL=OFF \
     source
    make
    make install
}
export -f buildX265

buildXvid(){
    . constants.bash
    echo "-----Compiling xvidcore---"
    cd "$BUILD_DIR/xvidcore/build/generic"
    ./bootstrap.sh
    ./configure --prefix=$TARGET_DIR --enable-static --disable-shared
    make
    make install
}
export -f buildXvid

buildLame(){
    . constants.bash
    echo "-----Compiling libmp3lame--"
    cd "$BUILD_DIR/libmp3lame"
    ./configure --prefix=$TARGET_DIR --enable-static --disable-shared
    make
    make install
}
export -f buildLame

buildOpus(){
    . constants.bash
    echo "-----Compiling libopus-----"
    cd "$BUILD_DIR/opus"
    ./autogen.sh
    ./configure --prefix=$TARGET_DIR --enable-static --disable-shared
    make
    make install
}
export -f buildOpus

parallel ::: buildOggVorbisTheora buildVpx buildFaac buildFdkaac buildX264 buildX265 buildXvid buildLame buildOpus
exit 0
