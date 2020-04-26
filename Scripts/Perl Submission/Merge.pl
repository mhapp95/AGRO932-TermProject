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

	open(IN, $ARGV[0]);

	for(my $j = 1; $j < 21; $j++){

		open(OUT, '>/work/soybean/mhapp95/AGRO932Project/Scripts/Submitted/Merge_'.$j.'.slurm');

		print OUT '#!/bin/sh'."\n";
		print OUT '#SBATCH --ntasks-per-node=16'."\n";
		print OUT '#SBATCH --nodes=1'."\n";
		print OUT '#SBATCH --mem=125gb'."\n";
		print OUT '#SBATCH --time=3:00:00'."\n";
		print OUT '#SBATCH --job-name=merge'."\n";
		print OUT '#SBATCH --error=/work/soybean/mhapp95/AGRO932Project/Log/Merge'.$j.'.error'."\n";
		print OUT '#SBATCH --output=/work/soybean/mhapp95/AGRO932Project/Log/Merge'.$j.'.out'."\n\n";
		
		print OUT 'cd /work/soybean/mhapp95/AGRO932Project/Data'."\n\n";

		print OUT 'module load gatk4/4.0'."\n\n";
		
#		print OUT 'gatk CombineGVCFs '.$backslash.''."\n";
#		print OUT ''.$dash.'R /work/soybean/mhapp95/SNPGenotyping/Data/Intermediaries/Reference/GlyMax.fasta '.$backslash.''."\n";
		
#                for(my $i = 0; $i < scalar(@rawreadsarray)-1; $i++){
#                my $array = "";
#                $array = $rawreadsarray[$i];

#				print OUT ''.$dash.''.$dash.'variant VCF/Indv/'.$array.'.'.$j.'.g.vcf  '.$backslash.''."\n";
		
#			}

#	        print OUT ''.$dash.'O VCF/'.$j.'g..vcf'."\n\n";

		print OUT 'gatk GenotypeGVCFs '.$backslash.''."\n";
		print OUT ''.$dash.'R /work/soybean/mhapp95/SNPGenotyping/Data/Intermediaries/Reference/GlyMax.fasta '.$backslash.''."\n";
		print OUT ''.$dash.''.$dash.'variant VCF/'.$j.'g..vcf  '.$backslash.''."\n";
		print OUT ''.$dash.'O VCF/'.$j.'.vcf  '.$backslash.''."\n";

		close OUT;

		
		system('sbatch /work/soybean/mhapp95/AGRO932Project/Scripts/Submitted/Merge_'.$j.'.slurm');
 
		}
	}

close IN;

