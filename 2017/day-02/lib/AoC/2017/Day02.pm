use strict;
use warnings;

package AoC::2017::Day02;

sub corruption_checksum {
    my ($lines) = @_;

    my $sum = 0;

    _corruption_checksum( \$sum, $lines, 0, $#{$lines} );

    return $sum;
}

sub _corruption_checksum {
    my ( $sum_ref, $lines, $index, $last_index ) = @_;

    return if $index > $last_index;

    my @numbers = map int, split /\s+/, $lines->[$index];

    my ( $min, $max );
    _find_min_max( \$min, \$max, \@numbers );

    my $diff = $max - $min;
    ${$sum_ref} += $diff;

    _corruption_checksum( $sum_ref, $lines, $index + 1, $last_index );

    return;
}

sub _find_min_max {
    my ( $min_ref, $max_ref, $numbers ) = @_;

    my ( $tmp_min, $tmp_max );

    foreach my $num ( @{$numbers} ) {
        if ( !defined $tmp_min || $num < $tmp_min ) {
            $tmp_min = $num;
        }
        if ( !defined $tmp_max || $num > $tmp_max ) {
            $tmp_max = $num;
        }
    }

    ${$min_ref} = $tmp_min;
    ${$max_ref} = $tmp_max;

    return;
}

'true';
