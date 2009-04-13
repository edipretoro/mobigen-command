package Mobigen::Command;

use warnings;
use strict;

use base qw( Class::Accessor::Fast Class::ErrorHandler );
__PACKAGE__->mk_accessors( qw( mobigen stdout stderr options input_file output_file ) );

use IPC::Run qw( start );
use Carp qw( carp );

our %option = (
    compression => '',
    verbose => '',
    security => '',
#    vouchers => '', # don't know what it mean...
    nocopypaste => '-nocopypaste',
    rebuild => '-rebuild',
    onlydeps => '-onlydeps',
    unicode => '-unicode',
    lowpriority => '-lowpriority',
    gif => '-gif',
);

=head1 NAME

Mobigen::Command - A wrapper class for mobigen command line utility

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

    use Mobigen::Command;

    my $mobi = Mobigen::Command->new( '/usr/bin/mobigen_linux' );
    $mobi->input_file( './article.html' );
    $mobi->output_file( './article.mobi' );
    $mobi->execute();

=head1 FUNCTIONS

=head2 new

=cut

sub new {
    my $class = shift;
    my $self = {
        mobigen => shift || 'mobigen_linux',
        options => [],
        input_file => '',
        output_file => '',
    };
    bless $self, $class;
}

=head2 function2

=cut

sub function2 {
}

=head1 AUTHOR

Emmanuel Di Pretoro, C<< <edipretoro at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-mobigen-command at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Mobigen-Command>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Mobigen::Command


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Mobigen-Command>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Mobigen-Command>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Mobigen-Command>

=item * Search CPAN

L<http://search.cpan.org/dist/Mobigen-Command/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Emmanuel Di Pretoro, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

1; # End of Mobigen::Command
