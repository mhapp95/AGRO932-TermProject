#!/usr/bin/perl -w
use strict;

my $rawreads = "";
my @rawreadsarray = ();

open(IN, $ARGV[0]);

for(my $rawreads = <IN>){
	chomp $rawreads;
	my @rawreadsarray = split(/\,/,$rawreads);

	for(my $i = 0; $i < scalar(@rawreadsarray)-1; $i++){
		my $array = "";
		$array = $rawreadsarray[$i];	
	
	open(OUT, '>/work/soybean/mhapp95/AGRO932Project/Scripts/Submitted/SplitFQ_'.$array.'.slurm');

	print OUT '#!/bin/sh'."\n";
	print OUT '#SBATCH --ntasks-per-node=1'."\n";
	print OUT '#SBATCH --nodes=1'."\n";
	print OUT '#SBATCH --mem=65gb'."\n";
	print OUT '#SBATCH --time=15:00:00'."\n";
	print OUT '#SBATCH --job-name=split'."\n";
	print OUT '#SBATCH --error=/work/soybean/mhapp95/AGRO932Project/Log/Error/split_'.$array.'.error'."\n";
	print OUT '#SBATCH --output=/work/soybean/mhapp95/AGRO932Project/Log/Out/split_'.$array.'.out'."\n\n";

	print OUT 'cd /work/soybean/mhapp95/AGRO932Project/Data/Raw/Fastq/'."\n\n";

#	print OUT 'cat '.$array.'.sra_1.fastq '.$array.'.sra_2.fastq > '.$array.'.fastq'."\n";
	print OUT 'fastqsplitter -i '.$array.'.fastq -o '.$array.'.1.fastq -o '.$array.'.2.fastq -o '.$array.'.3.fastq -o '.$array.'.4.fastq -o '.$array.'.5.fastq -o '.$array.'.6.fastq -o '.$array.'.7.fastq -o '.$array.'.8.fastq -o '.$array.'.9.fastq -o '.$array.'.10.fastq -o '.$array.'.11.fastq -o '.$array.'.12.fastq -o '.$array.'.13.fastq -o '.$array.'.14.fastq -o '.$array.'.15.fastq -o '.$array.'.16.fastq -o '.$array.'.17.fastq -o '.$array.'.18.fastq -o '.$array.'.19.fastq -o '.$array.'.20.fastq -o '.$array.'.21.fastq -o '.$array.'.22.fastq -o '.$array.'.23.fastq -o '.$array.'.24.fastq'."\n";

	close OUT;

	system('sbatch /work/soybean/mhapp95/AGRO932Project/Scripts/Submitted/SplitFQ_'.$array.'.slurm');  	

	}

}
close IN;



