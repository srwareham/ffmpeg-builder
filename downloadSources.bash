#!/bin/bash

# Written by Sean Wareham on November 21, 2014
# This script downloads source code for everything needed to compile ffmpeg

# Import constants
# NOTE: constants.bash must remain in the same directory as this file
. constants.bash

# Import utils
. utils.bash

#-----Program List----
# ffmpeg

#-----Container List--
# libogg

# ----Codec List-----
# Audio: libfaac, libfdk-aac, libvorbis, libopus, libmp3lame
# Video: libx264, libx265, libvpx, libxvid, libtheora

# Create build dir if needed
createDirIfNeeded "$BUILD_DIR"

enterDir="$PWD"
cd "$BUILD_DIR"

#----Download Programs----

# Download ffmpeg
if [ ! -d "$BUILD_DIR/ffmpeg" ]; then
    git clone git://source.ffmpeg.org/ffmpeg.git ffmpeg 
fi

#----Download Containers--
if [ ! -d "$BUILD_DIR/ogg" ]; then
    git clone https://git.xiph.org/mirrors/ogg.git
fi

#----Download Codecs------

# Download libx264
if [ ! -d "$BUILD_DIR/x264" ]; then
    git clone git://git.videolan.org/x264.git
fi

# Download libx265
if [ ! -d "$BUILD_DIR/x265" ]; then
    hg clone https://bitbucket.org/multicoreware/x265
fi

# Download libvpx
if [ ! -d "$BUILD_DIR/libvpx" ]; then
    git clone https://chromium.googlesource.com/webm/libvpx
fi

# Download libxvid
if [ ! -d "$BUILD_DIR/xvidcore" ]; then
    svn checkout http://svn.xvid.org/trunk/xvidcore --username anonymous --password anything
fi

# Download libtheora
if [ ! -d "$BUILD_DIR/theora" ]; then
    git clone https://git.xiph.org/mirrors/theora.git 
fi


# Download libfdk-aac
if [ ! -d "$BUILD_DIR/fdk-aac" ]; then
    git clone https://github.com/mstorsjo/fdk-aac.git
fi

# Download libvorbis
if [ ! -d "$BUILD_DIR/vorbis" ]; then
    git clone https://git.xiph.org/mirrors/vorbis.git
fi

# Download libopus
if [ ! -d "$BUILD_DIR/opus" ]; then
    git clone https://git.xiph.org/opus.git
#alternative: git://git.opus-codec.org/opus.git
fi

# Download libmp3lame
if [ ! -d "$BUILD_DIR/libmp3lame" ]; then
    git clone https://github.com/gypified/libmp3lame.git
#Alternatively using actual source (but tied to a version number):
# create dir, pipe downloaded tarball to stdout, untar to defined directory, prevent upper level subdirectory
# mkdir libmp3lame && wget -qO- http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz | tar -zxvf - -C libmp3lame --strip-components 1
fi

# Download and unpack libfaac
# Not worried about new releases. Could find a fork on github if desired
if [ ! -d "$BUILD_DIR/libfaac" ]; then
    mkdir libfaac && wget -qO- http://downloads.sourceforge.net/project/faac/faac-src/faac-1.28/faac-1.28.tar.gz | tar -zxf - -C libfaac --strip-components 1
fi

# Go back to wherever we came from
cd "$enterDir"
exit 0
