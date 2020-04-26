#!/usr/bin/perl -w
use strict;

print "\n".'Writing jobs ..... '."\n\n";

print "\n".'Submitting jobs ..... '."\n\n";

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

		open(OUT, '>/work/soybean/mhapp95/AGRO932Project/Scripts/Submitted/Bam2FA_'.$array.'.slurm');

		print OUT '#!/bin/sh'."\n";
		print OUT '#SBATCH --ntasks=16'."\n";
		print OUT '#SBATCH --mem=55gb'."\n";
		print OUT '#SBATCH --time=1:30:00'."\n";
		print OUT '#SBATCH --job-name=b2fa'."\n";
		print OUT '#SBATCH --error=/work/soybean/mhapp95/AGRO932Project/Log/Error/Bam2FA_'.$array.'.error'."\n";
		print OUT '#SBATCH --output=/work/soybean/mhapp95/AGRO932Project/Log/Out/Bam2FA_'.$array.'.out'."\n\n";
		
		print OUT 'cd /work/soybean/mhapp95/AGRO932Project/Data/Bam'."\n\n";
			
		print OUT 'module load samtools/1.5'."\n\n";
		
		print OUT 'samtools fasta --reference /work/soybean/mhapp95/SNPGenotyping/Data/Intermediaries/Reference/GlyMax.fasta '.$array.'_merged_sorted.bam > '.$array.'.fasta'."\n\n";
		close OUT;

		system('sbatch /work/soybean/mhapp95/AGRO932Project/Scripts/Submitted/Bam2FA_'.$array.'.slurm');
 
		}
	}

close IN;

