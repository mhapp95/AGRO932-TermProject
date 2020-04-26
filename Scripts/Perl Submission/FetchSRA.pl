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
	
	open(OUT, '>/work/soybean/mhapp95/AGRO932Project/Scripts/Submitted/Prefetch_'.$array.'.slurm');

	print OUT '#!/bin/sh'."\n";
	print OUT '#SBATCH --ntasks-per-node=1'."\n";
	print OUT '#SBATCH --nodes=1'."\n";
	print OUT '#SBATCH --mem=65gb'."\n";
	print OUT '#SBATCH --time=15:00:00'."\n";
	print OUT '#SBATCH --job-name=sra'."\n";
	print OUT '#SBATCH --error=/work/soybean/mhapp95/AGRO932Project/Log/Error/sra_'.$array.'.error'."\n";
	print OUT '#SBATCH --output=/work/soybean/mhapp95/AGRO932Project/Log/Out/sra_'.$array.'.out'."\n\n";

	print OUT 'cd /work/soybean/mhapp95/AGRO932Project/Data/Raw/SRA/'."\n\n";
	print OUT 'module load SRAtoolkit/2.10'."\n";
	print OUT 'module load aspera-cli'."\n\n";

	print OUT 'prefetch -a "/util/opt/anaconda/deployed-conda-envs/packages/aspera-cli/envs/aspera-cli-3.7.7/bin/ascp|$ASPERA_PUBLIC_KEY" '.$array.''."\n";

	close OUT;

	system('sbatch /work/soybean/mhapp95/AGRO932Project/Scripts/Submitted/Prefetch_'.$array.'.slurm');  	
	}

	print "\n".'All SRA transfers submitted'."\n\n";
}
close IN;



