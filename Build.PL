use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Mobigen::Command',
    license             => 'perl',
    dist_author         => 'Emmanuel Di Pretoro <edipretoro@gmail.com>',
    dist_version_from   => 'lib/Mobigen/Command.pm',
    build_requires => {
        'Test::More' => 0,
        'Class::Accessor::Fast' => 0,
        'Class::ErrorHandler' => 0,
        'IPC::Run' => 0,
        'File::Basename' => 0,
        'File::Spec' => 0,
        'File::Copy' => 0,
    },
    add_to_cleanup      => [ 'Mobigen-Command-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
