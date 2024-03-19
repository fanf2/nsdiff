# SPDX-License-Identifier: 0BSD OR MIT-0

use 5.10.0;
use ExtUtils::MakeMaker;

# suppress warning about the ExtUtils::MakeMaker bug
# that we fixed with the MAN3PODS setting below
$SIG{__WARN__} = sub {
	print STDERR @_ unless "@_" eq "WARNING: Older versions of ExtUtils::MakeMaker may errantly install README.pod as part of this distribution. It is recommended to avoid using this path in CPAN modules.\n"
};

WriteMakefile(
	NAME		=> 'DNS::nsdiff',
	VERSION		=> "1.84",
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
	mkdir -p web
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
	git push --tags chiark trunk
	if [ -f DNS-nsdiff-*.tar.gz ]; \
	then mv DNS-nsdiff-*.tar.gz web/.; \
	fi
	cp nsdiff web/.
	rsync -ilt web/nsdiff web/*.html web/*.tar.gz web/nsdiff_* \
		chiark:public-html/prog/nsdiff/

MAKE_FRAG
}
