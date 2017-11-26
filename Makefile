# Makefile for nsdiff

prefix =	${HOME}
bindir =	${prefix}/bin
mandir =	${prefix}/share/man
man1dir=	${mandir}/man1

bindest=	${DESTDIR}${bindir}
man1dest=	${DESTDIR}${man1dir}

PROGS=		nsdiff nspatch nsvi
DOCSRC=		${PROGS} README

man1files=	${PROGS:=.1}
podlinks=	${PROGS:=.pod}
txtfiles=	${DOCSRC:=.txt}
htmlfiles=	${DOCSRC:=.html}

DOCS=	${man1files} ${htmlfiles} ${txtfiles}

all: ${DOCS}

install: all
	install -m 755 -d ${bindest}
	install -m 755 ${PROGS} ${bindest}/
	install -m 755 -d ${man1dest}
	install -m 644 ${man1files} ${man1dest}/

clean:
	rm -f ${DOCS} ${podlinks}

${podlinks}:
	for f in ${PROGS}; do ln -sf $$f $$f.pod; done

.SUFFIXES: .1 .pod .txt .html

.pod.1:
	pod2man $< >$@

.pod.txt:
	pod2text $< >$@

.pod.html:
	pod2html --noindex $< >$@
	rm pod2htm?.tmp

release: ${DOCS}
	./release.sh ${DOCS}

upload: all
	git push --tags github master
	git push --tags dotat master
	git push --tags csx master
	ln -sf README.html index.html
	rsync -ilt ${htmlfiles} nsdiff \
		*.tar.xz *.tar.gz *.zip \
		chiark:public-html/prog/nsdiff/
	scp nsdiff ent:~/public_html/hermes/conf/bind/bin
	rm -f index.html
