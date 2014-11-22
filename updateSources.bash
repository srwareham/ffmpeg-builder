#!/bin/bash

# Written by Sean Wareham on November 21, 2014
# This script updates any existing versioning control repos of sources needed to compile ffmpeg

# If no build dir has been defined, use the location of this script
if [ -z "$BUILD_DIR" ]
then
BUILD_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi

# ----Codec List-----
# Audio: libfaac, libfdk-aac, libvorbis, libopus, libmp3lame
# Video: libx264, libx265, libvpx, libxvid, libtheora
enterDir="$PWD"
cd "$BUILD_DIR"

# Given the path of a git repo, update it by pulling from origin master
gitUpdate(){
    enter="$PWD"
    cd "$1"
    git pull origin master
    cd "$enter"
}

hgUpdate(){
    enter="$PWD"
    cd "$1"
    hg pull
    cd "$enter"
}

svnUpdate(){
    enter="$PWD"
    cd "$1"
    svn up
    cd "$enter"
}

#-----Check Programs for Updates-----
# Update ffmpeg
if [ -d "$BUILD_DIR/ffmpeg" ]; then
    echo "Checking ffmpeg git repo for updates"
    gitUpdate "$BUILD_DIR/ffmpeg" 
fi

#-----Check Containers for Updates---

# Update libogg
if [ -d "$BUILD_DIR/ogg" ]; then
    echo "Checking libogg git repo for updates"
    gitUpdate "$BUILD_DIR/ogg"
fi

#-----Check Codecs for Updates-------
#--Video Codecs--
# Update libx264
if [ -d "$BUILD_DIR/x264" ]; then
    echo "Checking libx264 git repo for updates"
    gitUpdate "$BUILD_DIR/x264"
fi

# Update libx265
if [ -d "$BUILD_DIR/x265" ]; then
    echo "Checking libx265 hg repo for updates"
    hgUpdate "$BUILD_DIR/x265"
fi

# Update libvpx
if [ -d "$BUILD_DIR/libvpx" ]; then
    echo "Checking libvpx git repo for updates"
    gitUpdate "$BUILD_DIR/libvpx"
fi

# Update libxvid
if [ -d "$BUILD_DIR/xvidcore" ]; then
    echo "Checking libxvid svn repo for updates"
    svnUpdate "$BUILD_DIR/xvidcore" 
fi

# Update libtheora
if [ -d "$BUILD_DIR/theora" ]; then
    echo "Checking theora git repo for updates"
    gitUpdate "$BUILD_DIR/theora"
fi

#--Audio Codecs--
# Update libfdk-aac
if [ -d "$BUILD_DIR/fdk-aac" ]; then
    echo "Checking libfdk-aac git repo for updates"
    gitUpdate "$BUILD_DIR/fdk-aac"
fi

# Update libvorbis
if [ -d "$BUILD_DIR/vorbis" ]; then
    echo "Checking vorbis git repo for updates"
    gitUpdate "$BUILD_DIR/vorbis"
fi

# Update libopus
if [ -d "$BUILD_DIR/opus" ]; then
    echo "Checking opus git repo for updates"
    gitUpdate "$BUILD_DIR/opus"
#alternative: git://git.opus-codec.org/opus.git
fi

# Update libmp3lame
if [ -d "$BUILD_DIR/libmp3lame" ]; then
    echo "Checking libmp3lame git repo for updates"
    gitUpdate "$BUILD_DIR/libmp3lame"
#Alternatively using actual source (but tied to a version number):
# create dir, pipe downloaded tarball to stdout, untar to defined directory, prevent upper level subdirectory
# mkdir libmp3lame && wget -qO- http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz | tar -zxvf - -C libmp3lame --strip-components 1
fi

# Update libfaac
# No foreseeable updates.
# Could probably make an algorithm to check latest at sourceforge


# Go back to wherever we came from
cd "$enterDir"