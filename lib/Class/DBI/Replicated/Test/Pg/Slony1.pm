package Class::DBI::Replicated::Test::Pg::Slony1;

=head1 NAME

Class::DBI::Replicated::Test::Pg::Slony1

=head1 SEE ALSO

L<Class::DBI::Replicated::Pg::Slony1>

=cut

use strict;
use warnings;
use base qw(Class::DBI::Replicated::Test
            Class::DBI::Replicated::Pg::Slony1);

my @from_env = qw(db user pass host repl_user repl_pass schema);
my %cfg;

for my $key (@from_env) {
  $cfg{$key} = $ENV{"PG_" . uc($key)} || "";
}

__PACKAGE__->_test_init;

__PACKAGE__->replication({
  master => [
    "dbi:Pg:dbname=$cfg{db};host=$cfg{host}",
    $cfg{user}, $cfg{pass}, { AutoCommit => 1 },
  ],
  slaves => [
    localhost => [
      "dbi:Pg:dbname=$cfg{db}",
      $cfg{user}, $cfg{pass},
    ],
  ],

  user     => $cfg{repl_user},
  password => $cfg{repl_pass},

  slony1_schema => $cfg{schema},
  slony1_origin => 1,
});

for my $db (qw(db_Master db_Slave)) {
  eval {
    __PACKAGE__->$db->do(<<'');
CREATE TABLE repl_test (
  id     serial,
  name   varchar(40) not null,
  flavor varchar(20) not null default 'Original',
  PRIMARY KEY(id)
);

                                 };
  if ($@) {
    die $@ unless $@ =~ /relation.+already exists/i;
  }
}

#__PACKAGE__->table('repl_test');
#__PACKAGE__->columns(All => qw(id name flavor));
__PACKAGE__->set_up_table('repl_test');

1;
