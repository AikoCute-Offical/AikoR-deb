#!/bin/bash

old=`grep "^Version:" ./AikoR-linux-64/DEBIAN/control | cut -d ' ' -f2`
version=$1
name='AikoR'
[[ $1 > '0.0.1' ]] && name='AikoR'
wget https://github.com/AikoCute-Offical/AikoR/releases/download/v"${version}"/AikoR-linux-64.zip || exit 1
unzip AikoR-linux-64.zip -d AikoR-linux-64
cp -v ./AikoR-linux-64/AikoR ./AikoR-linux-64/usr/bin/AikoR/
cp -v ./AikoR-linux-64/geoip.dat ./AikoR-linux-64/usr/bin/AikoR/
cp -v ./AikoR-linux-64/geosite.dat ./AikoR-linux-64/usr/bin/AikoR/
sed -i -r 's/^ExecStart=.+/ExecStart=\/usr\/bin\/AikoR\/AikoR -config \/etc\/AikoR\/aiko.yml/g' ./AikoR-linux-64/etc/systemd/system/AikoR.service
size=`du -sk AikoR-linux-64/ | cut -f1`
sed -i -e "/^Version:/cVersion: $version" -e "/^Installed-Size:/cInstalled-Size: $size" ./AikoR-linux-64/DEBIAN/control
sed -i "s/$old/$version/g" ./README.md ./build.sh
rm -rf ./AikoR-linux-64*
