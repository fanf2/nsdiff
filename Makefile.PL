use 5.10.0;
use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> 'DNS::nsdiff',
	VERSION		=> "1.82",
	ABSTRACT	=>
	    "create an 'nsupdate' script from DNS zone file differences",
	EXE_FILES	=> [qw[ nsdiff nspatch nsvi ]],

	# to stop MakeMaker from installing the README as a man page
	# we have to list the section 3 pages explicitly
	MAN3PODS	=> {
		'lib/DNS/nsdiff.pm' => 'blib/man3/DNS::nsdiff.3pm',
	    },

	AUTHOR		=> 'Tony Finch <dot@dotat.at>',
	LICENSE		=> 'unrestricted', # cc0 not allowed by CPAN::Meta::Spec
	MIN_PERL_VERSION=> '5.10.0',
	META_MERGE	=> {
		'meta-spec' => { version => 2 },
		'resources' => {
			repository => {
				type => 'git',
				url  => 'git://dotat.at/nsdiff.git',
				web  => 'https://dotat.at/cgi/git/nsdiff.git',
			}
		}
	}
);

sub MY::postamble {
	return <<'MAKE_FRAG';
html::
	for f in nsdiff nspatch nsvi; \
	do pod2html --noindex $$f >web/$$f.html; \
	done
	pod2html --noindex README.pod >web/README.html
	ln -sf README.html web/index.html
	rm -f pod2htm?.tmp

deb::
	dpkg-buildpackage -uc -A
	mv ../nsdiff_* web/.
	debian/rules clean

upload:: html
	git push --tags github trunk
	git push --tags dotat trunk
	if [ -f DNS-nsdiff-*.tar.gz ]; \
	then mv DNS-nsdiff-*.tar.gz web/.; \
	fi
	cp nsdiff web/.
	rsync -ilt web/nsdiff web/*.html web/*.tar.gz web/nsdiff_* \
		chiark:public-html/prog/nsdiff/

MAKE_FRAG
}
