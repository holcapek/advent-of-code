use strict;
use warnings;

package AoC::2017::Day02;

sub corruption_checksum {
    my ($lines) = @_;

    my $sum = 0;

    _corruption_checksum( \$sum, $lines, 0, $#{$lines}, \&_find_max_min_diff );

    return $sum;
}

sub corruption_checksum_2 {
    my ($lines) = @_;

    my $sum = 0;

    _corruption_checksum( \$sum, $lines, 0, $#{$lines}, \&_find_zero_mod );

    return $sum;
}

sub _corruption_checksum {
    my ( $sum_ref, $lines, $index, $last_index, $find_sum_pair_coderef ) = @_;

    return if $index > $last_index;

    my @numbers = map int, split /\s+/, $lines->[$index];

    my $inc = $find_sum_pair_coderef->( \@numbers );

    ${$sum_ref} += $inc;

    _corruption_checksum( $sum_ref, $lines, $index + 1, $last_index, $find_sum_pair_coderef );

    return;
}

sub _find_max_min_diff {
    my ($numbers) = @_;

    my ( $min, $max );

    foreach my $num ( @{$numbers} ) {
        if ( !defined $min || $num < $min ) {
            $min = $num;
        }
        if ( !defined $max || $num > $max ) {
            $max = $num;
        }
    }

    return $max - $min;
}

sub _find_zero_mod {
    my ($numbers) = @_;

    foreach my $i ( 0 .. ( $#{$numbers} - 1 ) ) {
        foreach my $j ( $i + 1 .. ( $#{$numbers} ) ) {
            my ( $a, $b ) = @{$numbers}[ $i, $j ];

            return $a / $b if ( $a > $b && $a % $b == 0 );
            return $b / $a if ( $b > $a && $b % $a == 0 );

        }
    }
    return 0;
}

'true';
