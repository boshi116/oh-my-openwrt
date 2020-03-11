#!/usr/bin/env bash

BOLD="\033[1m"
NORM="\033[0m"
INFO="$BOLD Info: $NORM"
INPUT="$BOLD => $NORM"
ERROR="\033[31m *** Error: $NORM"
WARNING="\033[33m * Warning: $NORM"

# if error occured, then exit
set -e

# common
project="xiaomi"
version="18.06.8"
device_profile="miwifi-nano"
cpu_arch="mipsel_24kc"
imagebuilder_url="http://downloads.openwrt.org/releases/$version/targets/ramips/mt76x8/openwrt-imagebuilder-$version-ramips-mt76x8.Linux-x86_64.tar.xz"
sdk_url="https://downloads.openwrt.org/releases/$version/targets/ramips/mt76x8/openwrt-sdk-$version-ramips-mt76x8_gcc-7.3.0_musl.Linux-x86_64.tar.xz"

# path
root_path=`pwd`
project_path="$root_path/$project"
sdk_path="$project_path/sdk"
ipk_path="$sdk_path/bin/packages/mipsel_24kc"
imagebuilder_path="$project_path/imagebuilder"
bin_path="$imagebuilder_path/bin/targets/ramips/mt76x8"

######################## setting env ########################
