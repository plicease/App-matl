package App::matl;

use strict;
use warnings;
use autodie qw( :all );
use 5.020;
use Ref::Util qw( is_ref is_blessed_ref );
use Term::ReadLine;
use Path::Tiny qw( path );
use YAML qw( Dump );

# ABSTRACT: Perl mathy REPL
# VERSION

=head1 SYNOPSIS

 perldoc matl

=head1 DESCRIPTION

This is the machinery for the L<matl> program.

=head1 SEE ALSO

=over 4

=item L<matl>

=back

=cut

package main {
  use List::SomeUtils qw( :all );

  sub cpanm
  {
    print "+cpanm @_";
    system 'cpanm', @_;
    return;
  }

  sub _ ()
  {
    return $_;
  }
}

sub is_single_basic
{
  return 0 unless @_ == 1;
  return 1 if ! is_ref $_[0];
  if(is_blessed_ref $_[0])
  {
    return 1 if $_[0]->isa('Math::BigInt') || $_[0]->isa('Math::BigFloat');
  }
  return 0;
}

sub main
{
  my(undef, @ARGV) = @_;

  my $term = Term::ReadLine->new('matl');
  my $history = path("~/.matl");

  if(-r $history)
  {
    $term->ReadHistory($history->stringify);
  }

  my @result;
  my $line;
  while(defined($line = $term->readline('matl> ')))
  {
    next if $line =~ /^\s*$/;
    @result = do {
      package main;
      no strict 'vars';
      use bignum;
      local $_ = $result[0];
      local @_ = @result;
      eval 'use autodie qw( :all ); ' . $line;  ## no critic (BuiltinFunctions::ProhibitStringyEval)
    };
    if(my $error = $@)
    {
      if(ref $error)
      {
        say "Exception (", ref($error), ")";
        local $YAML::Stringify = 1;
        #local $YAML::UseHeader = 0;
        print YAML::Dump($error);
      }
      else
      {
        say "Exception";
        $error = "$error";
        chomp $error;
        say $error;
      }
    }
    elsif(@result == 0)
    {
    }
    elsif(is_single_basic(@result) && defined $result[0])
    {
      say $result[0];
    }
    else
    {
      local $YAML::Stringify = 1;
      local $YAML::UseHeader = 0;
      print YAML::Dump(\@result);
    }
  }

  $term->WriteHistory($history->stringify);

  return 0;
}

1;
