#!/bin/bash

# Script for installing prerequisites on systesms with apt-get, yum, or packman
# NOTE: This is untested on packman and yum.  No gaurentees on their syntax being perfect...

# POSIX-compliant check heuristic sourced from ihunath at:
# https://stackoverflow.com/questions/592620/how-to-check-if-a-program-exists-from-a-bash-script

INSTALL_COMMAND="noInstall"

# Sets the package manager (later occuring lines have higher presidence)
setPackageManager(){
    command -v apt-get >/dev/null 2>&1 && INSTALL_COMMAND="packmanInstall"
    command -v apt-get >/dev/null 2>&1 && INSTALL_COMMAND="yumInstall"
    command -v apt-get >/dev/null 2>&1 && INSTALL_COMMAND="aptGetInstall"
}

noInstall(){
    echo "You do not have a supported package manager on your system"
    echo "Please install either apt-get, yum, or packman"
}

packmanInstall(){
    sudo pacman -S "$1"

}

yumInstall(){
    sudo yum -y install "$1"
}

aptGetInstall(){
    sudo apt-get update
    sudo apt-get -y install "$1"
}

packageManagerInstall(){
    "$INSTALL_COMMAND" "$1"
}

installHardPrerequisites(){
    # Install GCC if not present. Doubt this one will ever execute...
    command -v gcc >/dev/null 2>&1 || { (packageManagerInstall "gcc") }
    # Install G++ if not present
    command -v g++ >/dev/null 2>&1 || { (packageManagerInstall "g++") }
    # Install YASM if not present
    command -v yasm >/dev/null 2>&1 || { (packageManagerInstall "yasm") }
    # Install CMAKE if not present
    command -v cmake >/dev/null 2>&1 || { (packageManagerInstall "cmake") }
}

installSoftPrerequisites(){
    # Install git if not present
    command -v git >/dev/null 2>&1 || { (packageManagerInstall "git") }
    # Install mercurial if not present
    command -v hg >/dev/null 2>&1 || { (packageManagerInstall "mercurial") }
    # Install subversion if not present
    command -v svn >/dev/null 2>&1 || { (packageManagerInstall "subversion") }
    # Install GNU parallel if not present
    # NOTE: some package managers may not provide the GNU version, likely will need the GNU version
    command -v parallel >/dev/null 2>&1 || { (packageManagerInstall "parallel") }
}

# Set Package Manager
setPackageManager

# Install necessary Hard prerequisites
installHardPrerequisites

# Install Soft prerequisites to make your life easier
installSoftPrerequisites
