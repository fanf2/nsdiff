DOCS=	nsdiff.1	\
	nsdiff.txt	\
	nsdiff.html	\
	README.txt	\
	README.html

all: ${DOCS}

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
