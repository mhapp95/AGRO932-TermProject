#!/usr/bin/perl -w
use strict;

my $rawreads = "";
my @rawreadsarray = ();

open(IN, $ARGV[0]);

for(my $rawreads = <IN>){
	chomp $rawreads;
	my @rawreadsarray = split(/\,/,$rawreads);
	my $dash = '-';
	for(my $i = 0; $i < scalar(@rawreadsarray)-1; $i++){
		my $array = "";
		$array = $rawreadsarray[$i];	
	
	open(OUT, '>/work/soybean/mhapp95/AGRO932Project/Scripts/Submitted/sra2fq_'.$array.'.slurm');

	print OUT '#!/bin/sh'."\n";
	print OUT '#SBATCH --ntasks-per-node=1'."\n";
	print OUT '#SBATCH --nodes=1'."\n";
	print OUT '#SBATCH --mem=65gb'."\n";
	print OUT '#SBATCH --time=15:00:00'."\n";
	print OUT '#SBATCH --job-name=sra2fq'."\n";
	print OUT '#SBATCH --error=/work/soybean/mhapp95/AGRO932Project/Log/Error/sra2fq_'.$array.'.error'."\n";
	print OUT '#SBATCH --output=/work/soybean/mhapp95/AGRO932Project/Log/Out/sra2fq_'.$array.'.out'."\n\n";

	print OUT 'cd /work/soybean/mhapp95/AGRO932Project/Data/Raw/'."\n\n";
	print OUT 'module load SRAtoolkit/2.10'."\n";

	print OUT 'fasterq-dump -m 30GB -p -v -3 '.$dash.'-skip-technical -O Fastq/ SRA/'.$array.'/'.$array.'.sra'."\n";

	close OUT;

	system('sbatch /work/soybean/mhapp95/AGRO932Project/Scripts/Submitted/sra2fq_'.$array.'.slurm');
  	
	}

	print "\n".'All SRA to Fastq conversions submitted'."\n\n";
}
close IN;



