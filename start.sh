#!/usr/bin/env bash

BOLD="\033[1m"
NORM="\033[0m"
INFO="$BOLD Info: $NORM"
INPUT="$BOLD => $NORM"
ERROR="\033[31m *** Error: $NORM"
WARNING="\033[33m * Warning: $NORM"

# tips
echo -e "$INFO Welcome to Stuart's oh-my-openwrt!"
echo
echo "        1. 编译 lean openwrt"
echo "        2. 编译 stuart openwrt for xiaomi"
echo "        3. 编译 stuart openwrt for newifi3"
echo "        4. 编译 stuart openwrt for x86_64"
echo "        9. 安装编译依赖"
echo "        0. 索引 ipks 并签名"
echo

while true; do
    echo -n -e "$INPUT"
    read -s -p "请输入操作序号 (0-9): " yn
    echo
    case $yn in
        1 ) bash scripts/lean.sh; break;;
        2 ) bash scripts/xiaomi.sh; break;;
        3 ) bash scripts/newifi3.sh; break;;
        4 ) bash scripts/x86_64.sh; break;;
        9 ) bash scripts/dependency.sh; break;;
        0 ) bash scripts/index_sign.sh; exit;;
        "") echo -e "$INFO end!"; exit;;
        * ) echo "输入 0-9 以确认";;
    esac
done
