#!/bin/bash

# Written by Sean Wareham on November 21, 2014
# This script resets source repositories to the HEAD of origin master

# Import constants
# NOTE: constants.bash must remain in the same directory as this file
. constants.bash

# ----Codec List-----
# Audio: libfaac, libfdk-aac, libvorbis, libopus, libmp3lame
# Video: libx264, libx265, libvpx, libxvid, libtheora
enterDir="$PWD"
cd "$BUILD_DIR"

# Given the path of a git repo, CleanUp it by pulling from origin master
gitDestroyChanges(){
    enter="$PWD"
    cd "$1"
    git clean -fd
    cd "$enter"
}

#NOTE: This does not remove untracked directories.
hgDestroyChanges(){
    enter="$PWD"
    cd "$1"
    hg status -un|xargs rm
    cd "$enter"
}
# Sourced from Richard Hansen at https://stackoverflow.com/questions/2803823/how-can-i-delete-all-unversioned-ignored-files-folders-in-my-working-copy
svnDestroyChanges(){
    enter="$PWD"
    cd "$1"
    svn status --no-ignore | grep '^[I?]' | cut -c 9- | while IFS= read -r f; do rm -rf "$f"; done
    cd "$enter"
}

# CleanUp ffmpeg
if [ -d "$BUILD_DIR/ffmpeg" ]; then
    gitDestroyChanges "$BUILD_DIR/ffmpeg" 
fi

# CleanUp libogg
if [ -d "$BUILD_DIR/ogg" ]; then
    gitDestroyChanges "$BUILD_DIR/ogg"
fi


# CleanUp libx264
if [ -d "$BUILD_DIR/x264" ]; then
    gitDestroyChanges "$BUILD_DIR/x264"
fi

# CleanUp libx265
if [ -d "$BUILD_DIR/x265" ]; then
    hgDestroyChanges "$BUILD_DIR/x265"
fi

# CleanUp libvpx
if [ -d "$BUILD_DIR/libvpx" ]; then
    gitDestroyChanges "$BUILD_DIR/libvpx"
fi

# CleanUp libxvid
if [ -d "$BUILD_DIR/xvidcore" ]; then
    svnDestroyChanges "$BUILD_DIR/xvidcore" 
fi

# CleanUp libtheora
if [ -d "$BUILD_DIR/theora" ]; then
    gitDestroyChanges "$BUILD_DIR/theora"
fi


# CleanUp libfdk-aac
if [ -d "$BUILD_DIR/fdk-aac" ]; then
    gitDestroyChanges "$BUILD_DIR/fdk-aac"
fi

# CleanUp libvorbis
if [ -d "$BUILD_DIR/vorbis" ]; then
    gitDestroyChanges "$BUILD_DIR/vorbis"
fi

# CleanUp libopus
if [ -d "$BUILD_DIR/opus" ]; then
    gitDestroyChanges "$BUILD_DIR/opus"
#alternative: git://git.opus-codec.org/opus.git
fi

# CleanUp libmp3lame
if [ -d "$BUILD_DIR/libmp3lame" ]; then
    gitDestroyChanges "$BUILD_DIR/libmp3lame"
#Alternatively using actual source (but tied to a version number):
# create dir, pipe downloaded tarball to stdout, untar to defined directory, prevent upper level subdirectory
# mkdir libmp3lame && wget -qO- http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz | tar -zxvf - -C libmp3lame --strip-components 1
fi

# CleanUp libfaac
# Not the best, but not really necessary
if [ -d "$BUILD_DIR/libfaac" ]; then
    enter="$PWD" 
    cd "$BUILD_DIR/libfaac"
    make clean
    cd "$enter"
fi

# Go back to wherever we came from
cd "$enterDir"
exit 0
