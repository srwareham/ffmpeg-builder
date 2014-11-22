ffmpeg-builder
==============

ffmpeg-builder is an easy-to-use program to build a static ffmpeg binary with most of the popular codecs baked in.

## Programs fetched and compiled:

* Audio Codecs: libfaac, libfdk-aac, libvorbis, libopus, libmp3lame
* Video Codecs: libx264, libx265, libvpx, libxvid, libtheora
* Programs: ffmpeg
* Containers: libogg

## Installation

1. Clone the repository
2. Set your desired output directories in constants.bash (default is to output to ~/Software/ffmpeg)
3. run ffmpeg-builder.bash
4. Enjoy!


Warning: compilation is very computationally intensive. On slow machines, this is a multi-hour process.
On an Intel i7-4770K @ 3.5GHz with a 2MB/s connection, the process takes only 10 minutes

**TL;DR:**

    git clone git@github.com:srwareham/ffmpeg-builder.git; cd ffmpeg-builder; ./ffmpeg-builder.bash

## Usage

The usage of this program really is the installation process itself, but the product of this program is a fully-functioning ffmpeg static binary.  Once compiled, this binary will have no dependencies and should work on your system given the operating system remains stable.

The default output location for your binary is ~/Software/ffmpeg/target/bin.  This path will be created if it does not exist.  This can be easily changed by modifying the PROJECT_DIR variable in constants.bash

If you would like to update your binary, simply run the script again.  The script uses git / hg / svn repositories to pull the source code of the various codecs and will ensure they are up to date on each run.

The compilation process for the codecs used in this project will work on Mac OSX, but the ffmpeg compilation will fail.  This is an intended limitation of the operating system as apple views static binaries as being contrary to their design philosphy.  See https://developer.apple.com/library/mac/qa/qa1118/_index.html and  https://stackoverflow.com/questions/3801011/ld-library-not-found-for-lcrt0-o-on-osx-10-6-with-gcc-clang-static-flag for more detail.

Although this script could be retooled to create of a binary using shared libraries, this is not the inteniton of this script. A static binary is extreemly easy to use and comes with virtually zero maintence once created.  If this is a feature set you are looking for on Mac OSX, I highly reccomend installing Homebrew and using it to install ffmpeg and any codecs.

All prerequisites for this program are automatically installed.  If you see a request for sudo privellages, this is only used by your package manager to fetch needed packages.

* Hard Prerequisites: yasm, cmake, gcc, g++
* Soft Prerequisites: git, subversion, mercurial, wget, tar

Note: to avoid soft prerequisites you would merely need to download tarballs of the sources of the codecs and ensure they are placed in the BUILD_DIR folder according to the name convention used (and of course comment out any code requiring them).

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History

ffmpeg is a great program that is almost essential for doing audio/ video encoding.  Because licenses restrict the distribution of many of the preffered codecs, you will not find static builds of them online (we hope).  That means if a user wants to use ffmpeg with these codecs they need to build and compile everything together on their own.  The hope of this project is to make that task _much_ easier to do so everyone can work with a fully-featured ffmpeg.  This is intended to be a one-click solution to install ffmpeg (or one push, as the case may be).  

## Credits

This project in its entirety has been written by Sean Wareham (thusfar!) but the inspiration and model for the idea comes from stvs at https://github.com/stvs/ffmpeg-static and a great compililation guide from the devs of ffmpeg: https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu

Credits for this README template are all due to zenorocha at https://gist.github.com/zenorocha/4526327

## License

I have posted this with the GPL in order to keep it aligned with the licenses of many of the codecs this project compiles.  As I am not distributing any source code or binaries of said codecs, I believe this project is fully in compliance with said licenses.  If you are the rights holder of any of these projects and you disagree, please let me know and I will immediately remove support for your project.
