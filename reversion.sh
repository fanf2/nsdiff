#!/bin/sh

case $# in
(0)	V=$(git describe --tags --dirty=.X)
	N=${V#nsdiff-}
	;;
(1)	N=$1
	V=nsdiff-$N
	;;
(*)	echo 1>&2 'usage: reversion.sh [number]'
	exit 1
	;;
esac

perl -pi -e 's{(ns(diff|patch)-)\d\.\d\d(\.X)?}{${1}'$N'}' \
	README.pod nsdiff nspatch

case $# in
(0)	git diff
	;;
(1)	git commit -a -m $V
	git tag $V
	;;
esac
