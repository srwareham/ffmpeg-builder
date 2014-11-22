ffmpeg-builder
==============

Scripts to build ffmpeg along with most desirable codecs on linux systems.

This script creates a statically compiled binary of ffmpeg meaning that once generated on a system, the binary will work with no dependancies (other than the operating system not changing)
Because this creates a static binary, this script does not work on Mac OSX.
See https://stackoverflow.com/questions/3801011/ld-library-not-found-for-lcrt0-o-on-osx-10-6-with-gcc-clang-static-flag for more detail.
The script could be easily modified to create ffmpeg built with shared libraries, but Homebrew is a much more sensible solution for that approach


Hard Prerequisites: yasm, cmake, gcc, g++

Note: these can all be avoided by downloading tarballs instead
Source Acqusition Prerequisites: git, subversion, mercurial, wget, tar

Directions:
Clone the repository, set your project directory in constants.bash, and then run ffmpeg-builder.bash

Your final binary will appear in $PROJECT_DIRECTORY/target/bin

Warning: compilation is very computationally intensive. On slow machines, this is a multi-hour process.
On an Intel i7-4770K @ 3.5GHz and a 2MB/s connection the process takes almost exactly 10 minutes
