use strict;
use warnings;

package AoC::2017::Day04;

sub high_entrophy_passphrase {
    my ($pass) = @_;

    my @words = $pass =~ m{(\w+)}g;

    my %uniq;
    foreach my $word (@words) {
        return 0 if ++$uniq{$word} > 1;
    }

    return 1;

}

sub high_entrophy_passphrase_2 {
    my ($pass) = @_;

    my @words = map { join '', sort split '' } ( $pass =~ m{(\w+)}g );

    my %uniq;
    foreach my $word (@words) {
        return 0 if ++$uniq{$word} > 1;
    }

    return 1;

}

'ok';
