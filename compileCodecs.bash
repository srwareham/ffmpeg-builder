#!/bin/bash

# Written by Sean Wareham on November 21, 2014
# This script compiles many of the codes / containers used in ffmpeg

#NOTE: TARGET_DIR is not escaped to serve as a reminder that it cannot contain whitespace

# If no build dir has been defined, use the location of this script/build
if [ -z "$BUILD_DIR" ]; then
    thisDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    BUILD_DIR="$thisDir/build"
    mkdir -p  "$BUILD_DIR"
fi


# Compile ogg before vorbis
echo "-----Compiling libogg-----"
cd "$BUILD_DIR/ogg"
./autogen.sh
./configure --prefix=$TARGET_DIR --enable-static --disable-shared
make
make install

# Compile vorbis before theora
echo "-----Compiling libvorbis--"
cd "$BUILD_DIR/vorbis"
./autogen.sh
./configure --prefix=$TARGET_DIR --enable-static --disable-shared
make
make install

echo "-----Compiling libtheora--"
cd "$BUILD_DIR/theora"
./autogen.sh
./configure --prefix=$TARGET_DIR --enable-static --disable-shared
make
make install

echo "-----Compiling libvpx-----"
cd "$BUILD_DIR/libvpx"
./configure --prefix=$TARGET_DIR --disable-shared
make
make install

echo "-----Compiling libfaac----"
cd "$BUILD_DIR/libfaac"
./configure --prefix=$TARGET_DIR --enable-static --disable-shared
make
make install

echo "-----Compiling libfdk-aac----"
cd "$BUILD_DIR/fdk-aac"
./autogen.sh
./configure --prefix=$TARGET_DIR --enable-static --disable-shared
make
make install

echo "-----Compiling libx264----"
cd "$BUILD_DIR/x264"
./configure --prefix=$TARGET_DIR --enable-static --disable-shared
make
make install

#Note: the make x265-static CMakeLists.txt call is broken. Have to build shared too :(
echo "-----Compiling libx265----"
cd "$BUILD_DIR/x265"
cmake -DCMAKE_INSTALL_PREFIX:PATH=$TARGET_DIR \
-DLIBRARY_OUTPUT_PATH:PATH=$TARGET_DIR/lib \
-DBIN_INSTALL_DIR:PATH=$TARGET_DIR/bin \
-DBUILD_SHARED_LIBS:BOOL=OFF \
-DCMAKE_C_CREATE_STATIC_LIBRARY:BOOL=ON \
 source
make
make install

echo "-----Compiling xvidcore---"
cd "$BUILD_DIR/xvidcore/build/generic"
./bootstrap.sh
./configure --prefix=$TARGET_DIR --enable-static --disable-shared
make -j $jval
make install

echo "-----Compiling libmp3lame--"
cd "$BUILD_DIR/libmp3lame"
./configure --prefix=$TARGET_DIR --enable-static --disable-shared
make
make install

echo "-----Compiling libopus-----"
cd "$BUILD_DIR/opus"
./autogen.sh
./configure --prefix=$TARGET_DIR --enable-static --disable-shared
make
make install