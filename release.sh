#!/bin/sh

V=nsdiff-$(./nsdiff -V | sed '/.* version /!d;s///;s/ .*//')

reversion () {
	sed "s/nsdiff-[0-9.]*[0-9]/$V/g" <$1 >$1.tmp
	mv $1.tmp $1
}

reversion README.pod

mkdir $V
cp $(git ls-files | fgrep -v .git) "$@" $V
zip -qr $V.zip $V
tar cf $V.tar $V
xz -k9 $V.tar
gzip -9 $V.tar
rm -R $V
