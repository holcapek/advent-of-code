use strict;
use warnings;

use Test::More;
use File::Slurp 'read_file';
use AoC::2017::Day03;

my @input_files = glob('t/*.input');

my %files_map = map {
    my $output_file = $_;
    $output_file =~ s{\.input$}{.output};
    ( $_ => $output_file );
} @input_files;

foreach my $input_file (@input_files) {
    my $input_text = ( read_file( $input_file, { chomp => 1 } ) )[0];

    my $expected_output_text = ( read_file( $files_map{$input_file}, { chomp => 1 } ) )[0];

    my $output_text = AoC::2017::Day03::manhattan_distance($input_text);

    is( $output_text, $expected_output_text );
}

done_testing;
