#!/usr/bin/env bash
# Written by Sean Wareham on February 5, 2015
# This script is intended to contain desired post-processing after ffmpeg has been built
source constants.bash

# Function to take an input file, and rename it as /path/to/file.old
#params $1 Full path of file to rename
renameAsOldIfExists(){
    if [ -f "$1" ];then
        mv "$1" "$1.old"
    fi

}

# Function to take the output ffmpeg binary from ffmpeg-builder and copy it to a useful location
# (likely in the $PATH)
optionallyCopyBinary(){
	if [ "$COPY_FFMPEG_BINARY" -eq 1 ]; then
		# If we dont have a destination, default to ~/bin
		if [ ! "$FFMPEG_BINARY_DESTINATION" ]; then
			FFMPEG_BINARY_DESTINATION ="$HOME/bin"
		fi
		# Default assume don't need root
		if [ ! "$COPY_FFMPEG_NEEDS_ROOT" ]; then
			COPY_FFMPEG_NEEDS_ROOT=0
		fi
		if [ "$COPY_FFMPEG_NEEDS_ROOT" = 1 ]; then
			# Don't really want to incorporate privellage escalation into design...
			sudo mkdir -p "$FFMPEG_BINARY_DESTINATION"
			if [ -f "$FFMPEG_BINARY_DESTINATION/ffmpeg" ];then
                sudo mv "$1" "$1.old"
            fi
			sudo cp "$TARGET_DIR/bin/ffmpeg" "$FFMPEG_BINARY_DESTINATION"
		else
			createDirIfNeeded "$FFMPEG_BINARY_DESTINATION"
			renameAsOldIfExists "$FFMPEG_BINARY_DESTINATION/ffmpeg"
			cp "$TARGET_DIR/bin/ffmpeg" "$FFMPEG_BINARY_DESTINATION"
		fi
	fi
}

optionallyCopyBinary
