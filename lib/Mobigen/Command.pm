package Mobigen::Command;

use warnings;
use strict;

use base qw( Class::Accessor::Fast Class::ErrorHandler );
__PACKAGE__->mk_accessors( 
    qw( 
          mobigen
          stdout
          stderr
          options
          input_file
          output_file
          timeout
          command
  ) 
);

use File::Basename;
use File::Spec;
use IPC::Run qw( start );
use Carp qw( carp );

our %option = (
#    vouchers => '', # don't know what it mean...
    nocopypaste => '-nocopypaste',
    rebuild => '-rebuild',
    nodeps => '-nodeps',
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
        current_options => {},
        input_file => '',
        output_file => '',
    };
    bless $self, $class;
}

=head2 compression

=cut

sub compression {
    my ($self, $compression) = @_;
    
    if ($compression == 0) {
        $self->{current_options}->{compresion} = '-c0';
    } elsif ($compression == 1) {
        $self->{current_options}->{compresion} = '-c1';
    } elsif ($compression == 2) {
        $self->{current_options}->{compresion} = '-c2';
    }
}

=head2 verbosity

=cut

sub verbosity {
    my ($self, $verbosity) = @_;
    
    if ($verbosity eq 'normal') {
        $self->{current_options}->{verbosity} = '-v1';
    } elsif ($verbosity eq 'quiet') {
        $self->{current_options}->{verbosity} = '-v0';
    } elsif ($verbosity eq 'high') {
        $self->{current_options}->{verbosity} = '-v';
    }
}

=head2 security

=cut 

sub security {
    my ($self, $level) = @_;
    
    if ($level eq 'unsecure') {
        $self->{current_options}->{security} = '-s0';
    } elsif ($level eq 'encrypted') {
        $self->{current_options}->{security} = '-s1';
    } elsif ($level eq 'pid_secure') {
        $self->{current_options}->{security} = '-s2';
    }
}

=head2 execute

=cut

sub execute {
    my $self = shift;
    
    my @opts = ( \$self->{stdin}, \$self->{stdout}, \$self->{stderr} );
    push @opts, IPC::Run::timeout($self->timeout) if $self->timeout;

    my $cmd = [
        $self->mobigen,
        values(%{$self->{current_options}}),
#        @{ $self->options },
        $self->input_file,
    ];

    $self->command( join( ' ', @$cmd ) );

    my $h = eval {
        start( $cmd, @opts )
    };

    if( $@ ){
        $self->error($@);
        return;
    }
    else {
        finish $h or do {
            $self->error($self->stderr);
            return;
        };
    }
    
    $self->_rename_output_file() if $self->output_file;

    return 1;
}

sub _rename_output_file {
    my $self = shift;
    
    my ($file, $path, $ext) = fileparse( $self->input_file, qr/\.[^.]*/);
    my $mobi_file = File::Spec->catfile( $path, $file . '.mobi' );

    move($mobi_file, $self->output_file);
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
