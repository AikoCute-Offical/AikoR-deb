#!/bin/bash

version=`curl -s https://api.github.com/repos/AikoCute-Offical/AikoR/releases/latest | grep "tag_name" | cut -d '"' -f4`
wget https://github.com/AikoCute-Offical/AikoR/releases/download/"${version}"/AikoR-linux-64.zip || exit 1
# Unzip the file and remove the zip file Go to the directory /etc /aikor and overwrite all file
unzip AikoR-linux-64.zip -d ./AikoR-linux-64/etc/aikor/ || exit 1
rm -rf AikoR-linux-64.zip || exit 1

# Build the package
dpkg -b ./AikoR-linux-64/ AikoR-"${version}"-amd64.deb || exit 1

# rename Version number from file : /AikoR-linux-64/DEBIAN/control
sed -i "s/Version: 1.0.0/Version: ${version}/g" ./AikoR-linux-64/DEBIAN/control || exit 1