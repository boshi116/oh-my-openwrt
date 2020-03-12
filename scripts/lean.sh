#!/usr/bin/env bash

BOLD="\033[1m"
NORM="\033[0m"
INFO="$BOLD Info: $NORM"
INPUT="$BOLD => $NORM"
ERROR="\033[31m *** Error: $NORM"
WARNING="\033[33m * Warning: $NORM"

# if error occured, then exit
set -e

######################## setting env ########################
# common
project="lean-openwrt"
# 1 小米路由器青春版, 2 Newifi3, 3 软路由
device_type=3

gen_device_desc(){
    if [ $device_type -eq 1 ]; then
        device="xiaomi"
        device_ipk_desc="mipsel_24kc"
        device_bin_desc="ramips/mt76x8"
    elif [ $device_type -eq 2 ]; then
        device="newifi3"
        device_ipk_desc="newifi3"
        device_bin_desc="ramips/newifi3"
    elif [ $device_type -eq 3 ]; then
        device="x86_64"
        device_ipk_desc="x86_64"
        device_bin_desc="x86/x86_64"
    else
        echo -e "$INFO End!"
        exit
    fi
}
while true; do
    echo -n -e "$INPUT"
    read -p "请选择路由器设备 ( 0/1/2/3 | 0 取消, 1 小米路由器青春版, 2 Newifi3, 3 软路由 )" yn
    echo
    case $yn in
        1 ) device_type=1; gen_device_desc; break;;
        2 ) device_type=2; gen_device_desc; break;;
        3 ) device_type=3; gen_device_desc; break;;
        0  | "") echo -e "$INFO End!"; exit;;
        * ) echo "输入 1(小米), 2(Newifi3), 3(软路由) 或 0(取消) 以确认";;
    esac
done

# prepare
if [ ! -d build_openwrt ]; then
    mkdir -p build_openwrt
fi
cd build_openwrt

# path
root_path=`pwd`
project_path="$root_path/$project"
ipk_path="$code_path/bin/packages/$device_ipk_desc"
bin_path="$code_path/bin/targets/$device_bin_desc"
artifact_root_path="$root_path/artifacts/lean"
artifact_bin_path="$artifact_root_path/targets/$device"
artifact_ipk_path="$artifact_root_path/packages/$device"

######################## set env ########################
# dir for project and artifact
pre_artifacts_dir(){
    if [ ! -d $code_path ]; then
        mkdir -p $code_path
    fi
    if [ ! -d $bin_path ]; then
        mkdir -p $bin_path
    fi
    if [ ! -d $ipk_path/stuart ]; then
        mkdir -p $ipk_path/stuart
    fi
    if [ ! -d $artifact_root_path ]; then
        mkdir -p $artifact_root_path
    fi
    if [ ! -d $artifact_bin_path ]; then
        mkdir -p $artifact_bin_path
    fi
    if [ ! -d $artifact_ipk_path ]; then
        mkdir -p $artifact_ipk_path
    fi
    if [ ! -d $artifact_ipk_path/luci ]; then
        mkdir -p $artifact_ipk_path/luci
    fi
    if [ ! -d $artifact_ipk_path/base ]; then
        mkdir -p $artifact_ipk_path/base
    fi
    echo -e "$INFO artifact dir set done!"
}
pre_artifacts_dir

######################## download app code from lean openwrt rep ########################
do_update_code(){
    echo "update code..."
    cd $code_path
    git pull origin master 1>/dev/null 2>&1
    echo -e "$INFO code update done!"
}
do_clone_code(){
    echo "clone code..."
    cd $root_path
    rm -rf $code_path
    git clone https://github.com/coolsnowwolf/lede.git $project
    echo -e "$INFO code clone done!"
}
clone_or_update_code(){
    if [ ! -d $code_path ]; then
        mkdir -p $code_path
    fi
    result=`ls $code_path`
    if [ -z "$result" ]; then
        do_clone_code
    else
        do_update_code
    fi
}

clone_or_update_code

######################## feeds update and install ########################
# 修复 18.04 动态链接库缺失问题
fix_sys(){
    if [ ! -L /lib/ld-linux-x86-64.so.2 ]; then
        sudo ln -s /lib/x86_64-linux-gnu/ld-2.27.so /lib/ld-linux-x86-64.so.2
    fi
}
fix_sys
# feeds download
do_update_feeds(){
    echo "download feeds begin..."
    cd $code_path
    ./scripts/feeds update -a && ./scripts/feeds install -a
    echo -e "$INFO download feeds done!"
}
update_feeds(){
    while true; do
        echo -n -e "$INPUT"
        read -p "是否 安装/更新 feeds (y/n) ?" yn
        echo
        case $yn in
            [Yy]* ) do_update_feeds; break;;
            [Nn]* | "" ) break;;
            * ) echo "输入 y 或 n 以确认";;
        esac
    done
}
update_feeds

######################## build openwrt ########################
archive_bin(){
    cd $bin_path
    cp -f openwrt-*-squashfs-sysupgrade.bin $artifact_bin_path
}
do_build_openwrt(){
    echo "build begin..."
    cd $code_path
    make menuconfig
    make download
    make V=s
    echo -e "$INFO build done!"
    
    # 归档 bin
    archive_bin
}
build_openwrt(){
    while true; do
        echo -n -e "$INPUT"
        read -p "是否开始编译 lean openwrt 固件 (y/n) ?" yn
        echo
        case $yn in
            [Yy]* ) do_build_openwrt; break;;
            [Nn]* | "" ) break;;
            * ) echo "输入 y 或 n 以确认";;
        esac
    done
}
build_openwrt

######################## build ipks ########################
archive_ssr_ipk(){
    cd $ipk_path/base
    cp -f luci-app-ssr-plus*_all.ipk $artifact_ipk_path/luci/
    # dependency
    cp -f shadowsocksr-libev-alt*$device_ipk_desc.ipk $artifact_ipk_path/base/
    cp -f ipt2socks*$device_ipk_desc.ipk $artifact_ipk_path/base/
    cp -f microsocks*$device_ipk_desc.ipk $artifact_ipk_path/base/
    cp -f pdnsd-alt*$device_ipk_desc.ipk $artifact_ipk_path/base/
    cp -f simple-obfs*$device_ipk_desc.ipk $artifact_ipk_path/base/
    cp -f v2ray*$device_ipk_desc.ipk $artifact_ipk_path/base/
    cp -f trojan*$device_ipk_desc.ipk $artifact_ipk_path/base/
}

do_build_ssr_ipk(){
    echo "build ssr begin..."
    cd $code_path
    make menuconfig
    make target/linux/compile V=s
    make package/lean/luci-app-ssr-plus/compile V=s
    echo -e "$INFO build ssr done!"

    # 归档 ipks
    archive_ssr_ipk
}
build_ssr_ipk(){
    while true; do
        echo -n -e "$INPUT"
        read -p "是否开始编译 SSR 软件包 (y/n) ?" yn
        echo
        case $yn in
            [Yy]* ) do_build_ssr_ipk; break;;
            [Nn]* | "" ) break;;
            * ) echo "输入 y 或 n 以确认";;
        esac
    done
}
build_ssr_ipk