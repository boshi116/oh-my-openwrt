#!/usr/bin/env bash

BOLD="\033[1m"
NORM="\033[0m"
INFO="$BOLD Info: $NORM"
INPUT="$BOLD => $NORM"
ERROR="\033[31m *** Error: $NORM"
WARNING="\033[33m * Warning: $NORM"

# if error occured, then exit
set -e

# path
root_path=`pwd`
project_path="$root_path/lean-openwrt"
# 1 小米路由器青春版, 2 Newifi3, 3 软路由
device_type=3
# 1 lean, 2 18.06.8, 3 19.07.2
index_type=1

gen_device_desc(){
    if [ $device_type -eq 1 ]; then
        device_desc="xiaomi"
        device_ipk_desc="mipsel_24kc"
        device_bin_desc="ramips/mt76x8"
    elif [ $device_type -eq 2 ]; then
        device_desc="newifi3"
        device_ipk_desc="newifi3"
        device_bin_desc="ramips/newifi3"
    elif [ $device_type -eq 3 ]; then
        device_desc="x86_64"
        device_ipk_desc="x86_64"
        device_bin_desc="x86/x86_64"
    else
        echo -e "$INFO end!"
        exit
    fi
}

gen_index(){
    tmp_dir=$1
    cd $tmp_dir
    rm -f Packages*
    $project_path/scripts/ipkg-make-index.sh . 2>/dev/null > Packages.manifest
    grep -vE '^(Maintainer|LicenseFiles|Source|Require)' Packages.manifest > Packages
    gzip -9nc Packages > Packages.gz
    $project_path/staging_dir/host/bin/usign -S -m Packages -s $root_path/openwrt-stuart.key
}

index_ipk(){
    echo "gen ipks index begin..."

    tmp_env=$PATH
    export PATH="$project_path/staging_dir/host/bin:$PATH"

    gen_index "$1/luci"
    gen_index "$1/base/$device_desc"

    unset PATH
    export PATH="$tmp_env"
    
    echo -e "$INFO gen ipks index done!"
}

dir_index_ipk(){
    if [ $device_type -eq 1 ]; then
        artifact_root_path="$root_path/lean"
    elif [ $device_type -eq 2 ]; then
        artifact_root_path="$root_path/18.06.8"
    elif [ $device_type -eq 3 ]; then
        artifact_root_path="$root_path/19.07.2"
    else
        echo -e "$INFO end!"
        exit
    fi

    artifact_ipk_path="$artifact_root_path/packages/$device_desc"
    index_ipk "$artifact_ipk_path"
}

# gen key
if [ ! -e $root_path/openwrt-stuart.key ]; then
    echo "openwrt-stuart.key gen..."
    $project_path/staging_dir/host/bin/usign -G -p $root_path/openwrt-stuart.pub -s $root_path/openwrt-stuart.key
    echo -e "$INFO openwrt-stuart.key gen done!"
fi

while true; do
    echo -n -e "$INPUT"
    read -s -p "请选择路由器设备 ( 0/1/2/3 | 0 取消, 1 小米路由器青春版, 2 Newifi3, 3 软路由 )" yn
    echo
    case $yn in
        1 ) device_type=1; gen_device_desc; break;;
        2 ) device_type=2; gen_device_desc; break;;
        3 ) device_type=3; gen_device_desc; break;;
        0 ) echo -e "$INFO end!"; exit;;
        "" ) gen_device_desc; break;;
        * ) echo "输入 1(小米), 2(Newifi3), 3(软路由) 或 0(取消) 以确认";;
    esac
done

while true; do
    echo -n -e "$INPUT"
    read -s -p "请选择需要索引的目录 ( 0/1/2/3 | 0 取消, 1 lean, 2 18.06.8, 3 19.07.2 )" yn
    echo
    case $yn in
        1 ) index_type=1; dir_index_ipk; break;;
        2 ) index_type=2; dir_index_ipk; break;;
        3 ) index_type=3; dir_index_ipk; break;;
        0  | "") echo -e "$INFO end!"; exit;;
        * ) echo "输入 1(lean), 2(18.06.8), 3(19.07.2) 或 0(取消) 以确认";;
    esac
done
