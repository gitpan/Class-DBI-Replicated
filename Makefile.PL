use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Class::DBI::Replicated',
    AUTHOR              => 'Hans Dieter Pearcey <hdp@cpan.org>',
    VERSION_FROM        => 'lib/Class/DBI/Replicated.pm',
    ABSTRACT_FROM       => 'lib/Class/DBI/Replicated.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
	'Class::DBI' => '3.0.1',
	'Params::Validate' => '0.74',
	'Class::Data::Inheritable' => 0,
	'Class::Accessor::Class' => 0,
	'Sub::Install' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Class-DBI-Replicated-*' },
);
