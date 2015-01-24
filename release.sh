#!/bin/sh

N=1.54
V=nsdiff-$N

perl -pi -e 's{(ns(diff|patch)-)\d\.\d\d}{${1}'$N'}' \
	README.pod nsdiff nspatch

mkdir $V
cp $(git ls-files | fgrep -v .git) "$@" $V
zip -qr $V.zip $V
tar cf $V.tar $V
xz -k9 $V.tar
gzip -9 $V.tar
rm -R $V
