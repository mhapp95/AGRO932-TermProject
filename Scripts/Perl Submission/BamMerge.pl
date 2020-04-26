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

		open(OUT, '>/work/soybean/mhapp95/AGRO932Project/Scripts/Submitted/MergeBam_'.$array.'.slurm');

		print OUT '#!/bin/sh'."\n";
		print OUT '#SBATCH --ntasks=16'."\n";
		print OUT '#SBATCH --mem=55gb'."\n";
		print OUT '#SBATCH --time=1:30:00'."\n";
		print OUT '#SBATCH --job-name=merge'."\n";
		print OUT '#SBATCH --error=/work/soybean/mhapp95/AGRO932Project/Log/Error/MergeBam_'.$array.'.error'."\n";
		print OUT '#SBATCH --output=/work/soybean/mhapp95/AGRO932Project/Log/Out/MergeBam_'.$array.'.out'."\n\n";
		
		print OUT 'cd /work/soybean/mhapp95/AGRO932Project/Data/Bam'."\n\n";
			
		print OUT 'module load samtools/1.5'."\n\n";
		
#		print OUT 'samtools merge '.$array.'_merged.bam '.$array.'.*_soybeansorted.bam'."\n\n";
#               print OUT 'samtools sort -o '.$array.'_merged_sorted.bam -O bam '.$array.'_merged.bam'."\n";
                print OUT 'samtools index -b '.$array.'_merged_sorted.bam '.$array.'_merged_sorted.bai'."\n";
       
		close OUT;

		system('sbatch /work/soybean/mhapp95/AGRO932Project/Scripts/Submitted/MergeBam_'.$array.'.slurm');
 
		}
	}

close IN;

