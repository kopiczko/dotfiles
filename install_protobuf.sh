#!/bin/bash

VERSION=2.5.0
TMPDIR="/tmp"

file="protobuf-${VERSION}"
url="http://protobuf.googlecode.com/files/${file}.tar.bz2"

set -e

if [ ! -e "$TMPDIR/${file}.tar.gz" ] ; then
  curl -sS $url > "$TMPDIR/${file}.tar.bz2"
fi
if [ ! -d "$TMPDIR/$file" ] ; then
  tar xfj "$TMPDIR/${file}.tar.bz2" -C $TMPDIR
fi

cd "$TMPDIR/$file"
if [ ! -d "/opt/$file" ] ; then
  ./configure --prefix="/opt/$file"
  make
  sudo make install
fi

cd /opt
sudo ln -s $file protobuf
