#!perl -T

use Test::More tests => 6;

BEGIN {
  use_ok( 'Class::DBI::Replicated' );
  use_ok( 'Class::DBI::Replicated::mysql' );
  use_ok( 'Class::DBI::Replicated::Pg::Slony1' );
  use_ok( 'Class::DBI::Replicated::Test' );
 SKIP: {
    skip "mysql test: TEST_MYSQL is false", 1 unless $ENV{TEST_MYSQL};
    use_ok( 'Class::DBI::Replicated::Test::mysql' );
  }
 SKIP: {
    skip "pg test: TEST_PG is false", 1 unless $ENV{TEST_PG};
    use_ok( 'Class::DBI::Replicated::Test::Pg::Slony1' );
  }
}

diag( "Testing Class::DBI::Replicated $Class::DBI::Replicated::VERSION, Perl $], $^X" );
