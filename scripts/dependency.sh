#!/usr/bin/env bash

BOLD="\033[1m"
NORM="\033[0m"
INFO="$BOLD Info: $NORM"
INPUT="$BOLD => $NORM"
ERROR="\033[31m *** Error: $NORM"
WARNING="\033[33m * Warning: $NORM"

# if error occured, then exit
set -e

######################## build dependency ########################

## for missing ncurses(libncurses.so or ncurses.h), 'unzip', Python 2.x, openssl, make
do_install_dep_stuart(){
    echo "install build dependency for stuart begin..."
    sudo apt update
    sudo apt install -y libncurses5-dev unzip python libssl-dev build-essential
    echo -e "$INFO install build dependency for stuart done!"
}

# install build dependency
## @https://github.com/coolsnowwolf/lede
## @https://github.com/esirplayground/lede
do_install_dep_lean(){
    echo "install build dependency for lean begin..."
    sudo apt update
    sudo apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev patch python3.5 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex node-uglify gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx-ucl libelf-dev autoconf automake libtool autopoint device-tree-compiler libuv-dev g++-multilib linux-libc-dev
    echo -e "$INFO install build dependency for lean done!"
}

do_install_dep(){
    do_install_dep_stuart
    do_install_dep_lean
}

install_dep(){
    while true; do
        echo -n -e "$INPUT"
        read -s -p "是否 安装/更新 编译依赖 (y/n) ?" yn
        echo
        case $yn in
            [Yy]* ) do_install_dep; break;;
            [Nn]* | "" ) exit;;
            * ) echo "输入 y 或 n 以确认";;
        esac
    done
}

echo -e "$INFO 此过程无需翻墙!"
install_dep
