#!/bin/sh
# SPDX-License-Identifier: 0BSD OR MIT-0

case $# in
(1)	N=$1
	;;
(2)	N=$2
	;;
(*)	echo 1>&2 'usage: reversion.sh [--commit] <number>'
	exit 1
	;;
esac

perl -pi -e 's{(ns(diff|patch|vi)-)[0-9.]+[0-9]}{${1}'$N'}' \
     README.pod nsdiff nspatch nsvi lib/DNS/nsdiff.pm

perl -pi -e 's{(VERSION\s+=>?\s+|\tgrep\s+)"[0-9.]+[0-9]"}{${1}"'$N'"}' \
     Makefile.PL lib/DNS/nsdiff.pm

case $# in
(1)	git diff
	;;
(2)	V=nsdiff-$N
	git commit -a -m $V
	git tag -a -m $V $V
	;;
esac
