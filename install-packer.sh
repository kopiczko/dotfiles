#!/bin/bash

mkdir -p /tmp/packer
cd /tmp/packer

if [ ! -f 0.4.1_linux_amd64.zip ] ; then
    wget https://dl.bintray.com/mitchellh/packer/0.4.1_linux_amd64.zip
fi

if [ ! -d /opt/packer/0.4.1/bin ] ; then
    sudo mkdir -p /opt/packer/0.4.1/bin \
    && \
    sudo unzip 0.4.1_linux_amd64.zip -d /opt/packer/0.4.1/bin
fi

sudo stow -v -d /opt/packer -t /usr/local -S 0.4.1 \
&& \
rm -rf /tmp/packer \
&& \
exit 0
exit $?


## Uninstall:
#sudo stow -v -d /opt/packer -t /usr/local -D 0.4.1 \
#&& \
#sudo rm -rf /opt/packer \
#&& \
#exit 0
#exit $?
