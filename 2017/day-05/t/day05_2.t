use strict;
use warnings;

use Test::More;
use File::Slurp 'read_file';
use AoC::2017::Day05;

my @input_files = glob('t/*.input_2');

my %files_map = map {
    my $output_file = $_;
    $output_file =~ s{\.input_2$}{.output_2};
    ( $_ => $output_file );
} @input_files;

foreach my $input_file (@input_files) {
    my @input = read_file( $input_file, { chomp => 1 } );

    my $expected_output = ( read_file( $files_map{$input_file}, { chomp => 1 } ) )[0];

    my $output = AoC::2017::Day05::twisty_trampolines_2( \@input );

    is( $output, $expected_output );
}

done_testing;
