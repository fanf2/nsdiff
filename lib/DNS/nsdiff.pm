# SPDX-License-Identifier: CC0-1.0

package DNS::nsdiff;

our $VERSION = "1.82";

=head1 NAME

DNS::nsdiff - the nsdiff, nspatch, and nsvi scripts

=head1 DESCRIPTION

This is a stub module for overview documentation. There are three
scripts in the DNS::nsdiff distribution:

=over

=item B<nsdiff>

The B<nsdiff> program examines the old and new versions of a DNS zone,
and outputs the differences as a script for use by BIND's B<nsupdate>
program. It provides a bridge between static zone files and dynamic
updates.

=item B<nspatch>

The B<nspatch> script is a wrapper around C<nsdiff | nsupdate> that
checks and reports errors in a manner suitable for running from B<cron>.

=item B<nsvi>

The B<nsvi> script makes it easy to edit a dynamic zone.

=back

=head1 VERSION

  This is DNS::nsdiff-1.82 <https://dotat.at/prog/nsdiff/>

  Written by Tony Finch <fanf2@cam.ac.uk> <dot@dotat.at>
  at Cambridge University Information Services.
  You may do anything with this. It has no warranty.
  <https://creativecommons.org/publicdomain/zero/1.0/>

=head1 SEE ALSO

nsdiff(1), nspatch(1), nsvi(1), nsupdate(1)

=cut

1;
