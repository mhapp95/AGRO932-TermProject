#!/usr/bin/perl -w
use strict;


my $rawreads = "";
my @rawreadsarray = ();

open(IN, $ARGV[0]);

for(my $rawreads = <IN>){
	chomp $rawreads;
	my @rawreadsarray = split(/\,/,$rawreads);
	
	my $backslash = '\\';
	my $dash = '-';

	for(my $i = 0; $i < scalar(@rawreadsarray)-1; $i++){
		my $array = "";
		$array = $rawreadsarray[$i];

	for(my $j = 1; $j < 21; $j++){

		open(OUT, '>/work/soybean/mhapp95/AGRO932Project/Scripts/Submitted/'.$j.'_'.$array.'.slurm');

		print OUT '#!/bin/sh'."\n";
		print OUT '#SBATCH --ntasks-per-node=16'."\n";
		print OUT '#SBATCH --nodes=1'."\n";
		print OUT '#SBATCH --mem=125gb'."\n";
		print OUT '#SBATCH --time=3:00:00'."\n";
		print OUT '#SBATCH --job-name=call'."\n";
		print OUT '#SBATCH --error=/work/soybean/mhapp95/AGRO932Project/Log/'.$j.'_'.$array.'.error'."\n";
		print OUT '#SBATCH --output=/work/soybean/mhapp95/AGRO932Project/Log/'.$j.'_'.$array.'.out'."\n\n";
		
		print OUT 'cd /work/soybean/mhapp95/AGRO932Project/Data'."\n\n";

		print OUT 'module load gatk4/4.1'."\n\n";
		
		print OUT 'gatk HaplotypeCaller '.$backslash.''."\n";
		print OUT ''.$dash.'R /work/soybean/mhapp95/SNPGenotyping/Data/Intermediaries/Reference/GlyMax.fasta '.$backslash.''."\n";
		print OUT ''.$dash.'I Bam/'.$array.'_merged_sorted.bam '.$backslash.''."\n";
		print OUT ''.$dash.'ERC GVCF '.$backslash.''."\n";
		print OUT ''.$dash.'L '.$j.' '.$backslash.''."\n";
		print OUT ''.$dash.'O VCF/Indv/'.$array.'.'.$j.'.g.vcf '.$backslash.''."\n";
		
		close OUT;

		
		system('sbatch /work/soybean/mhapp95/AGRO932Project/Scripts/Submitted/'.$j.'_'.$array.'.slurm');
 
		}
	}
}
close IN;

