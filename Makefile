# Makefile for nsdiff

prefix =	${HOME}
bindir =	${prefix}/bin
mandir =	${prefix}/share/man
man1dir=	${mandir}/man1

bindest=	${DESTDIR}${bindir}
man1dest=	${DESTDIR}${man1dir}

DOCS=	nsdiff.1	\
	nsdiff.txt	\
	nsdiff.html	\
	README.txt	\
	README.html

all: ${DOCS}

install: all
	install -m 755 -d ${bindest}
	install -m 755 nsdiff ${bindest}/
	install -m 755 -d ${man1dest}
	install -m 644 nsdiff.1 ${man1dest}/

clean:
	rm -f ${DOCS}

nsdiff.1: nsdiff
	pod2man nsdiff >nsdiff.1

nsdiff.txt: nsdiff
	pod2text nsdiff >nsdiff.txt

nsdiff.html: nsdiff
	pod2html nsdiff | sed -f fixhtml.sed >nsdiff.html
	rm pod2htm?.tmp

README.txt: README.pod
	pod2text README.pod >README.txt

README.html: README.pod
	pod2html README.pod | sed -f fixhtml.sed >README.html
	rm pod2htm?.tmp

release: ${DOCS}
	./release.sh ${DOCS}

upload:
	git push --tags github master
	git push --tags dotat master
	git push --tags csx master
	ln -sf README.html index.html
	scp index.html README.html nsdiff.html nsdiff \
		*.tar.xz *.tar.gz *.zip \
		chiark:public-html/prog/nsdiff/
	cp nsdiff /home/uxsup/fanf2/public_html/hermes/conf/bind/bin/
	rm -f index.html
