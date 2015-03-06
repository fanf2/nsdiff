#!/bin/sh

V=$(git describe --tags --dirty=.X)
mkdir $V
cp $(git ls-files | fgrep -v .git) "$@" $V
zip -qr $V.zip $V
tar cf $V.tar $V
xz -k9 $V.tar
gzip -9 $V.tar
rm -R $V
