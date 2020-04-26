#!/usr/bin/perl -w
use strict;

for(my $i = 1; $i <= 20; $i++){

	open(OUT, '>Submitted/SAFHY_Chr'.$i.'.slurm');

	print OUT '#!/bin/sh'."\n";
	print OUT '#SBATCH --ntasks-per-node=16'."\n";
	print OUT '#SBATCH --nodes=1'."\n";
	print OUT '#SBATCH --mem=85gb'."\n";
	print OUT '#SBATCH --time=15:00:00'."\n";
	print OUT '#SBATCH --job-name=HY'."\n";
	print OUT '#SBATCH --error=/work/soybean/mhapp95/AGRO932Project/Log/Error/SAFHY_'.$i.'.error'."\n";
	print OUT '#SBATCH --output=/work/soybean/mhapp95/AGRO932Project/Log/Out/SAFHY_'.$i.'.out'."\n\n";


	print OUT 'cd /work/soybean/mhapp95/AGRO932Project/Data/Bam/'."\n"; 
	print OUT 'angsd -b HighYield.bam.txt  -anc /work/soybean/mhapp95/PopGenvQTL/Data/Reference/GlyMax/GlyMax.fasta -ref /work/soybean/mhapp95/PopGenvQTL/Data/Reference/GlyMax/GlyMax.fasta -out /work/soybean/mhapp95/AGRO932Project/Data/SAF/HY_Chr'.$i.' -nThreads 16 -P 24 -dosaf 1 -gl 1 -baq 1 -C 50 -minMapQ 30 -minQ 20 -r '.$i.''."\n";

	close OUT;

	system('sbatch Submitted/SAFHY_Chr'.$i.'.slurm');

	open(OUT, '>Submitted/SAFDrought_Chr'.$i.'.slurm');

	print OUT '#!/bin/sh'."\n";
	print OUT '#SBATCH --ntasks-per-node=16'."\n";
	print OUT '#SBATCH --nodes=1'."\n";
	print OUT '#SBATCH --mem=85gb'."\n";
	print OUT '#SBATCH --time=15:00:00'."\n";
	print OUT '#SBATCH --job-name=D'."\n";
	print OUT '#SBATCH --error=/work/soybean/mhapp95/AGRO932Project/Log/Error/SAFDrought_'.$i.'.error'."\n";
	print OUT '#SBATCH --output=/work/soybean/mhapp95/AGRO932Project/Log/Out/SAFDrought_'.$i.'.out'."\n\n";


	print OUT 'cd /work/soybean/mhapp95/AGRO932Project/Data/Bam/'."\n"; 
	print OUT 'angsd -b Drought.bam.txt  -anc /work/soybean/mhapp95/PopGenvQTL/Data/Reference/GlyMax/GlyMax.fasta -ref /work/soybean/mhapp95/PopGenvQTL/Data/Reference/GlyMax/GlyMax.fasta -out /work/soybean/mhapp95/AGRO932Project/Data/SAF/Drought_Chr'.$i.' -nThreads 16 -P 24 -dosaf 1 -gl 1 -baq 1 -C 50 -minMapQ 30 -minQ 20 -r '.$i.''."\n";

	close OUT;

	system('sbatch Submitted/SAFDrought_Chr'.$i.'.slurm');

	open(OUT, '>Submitted/SAFDiverse_Chr'.$i.'.slurm');

	print OUT '#!/bin/sh'."\n";
	print OUT '#SBATCH --ntasks-per-node=16'."\n";
	print OUT '#SBATCH --nodes=1'."\n";
	print OUT '#SBATCH --mem=85gb'."\n";
	print OUT '#SBATCH --time=15:00:00'."\n";
	print OUT '#SBATCH --job-name=Dv'."\n";
	print OUT '#SBATCH --error=/work/soybean/mhapp95/AGRO932Project/Log/Error/SAFDiverse_'.$i.'.error'."\n";
	print OUT '#SBATCH --output=/work/soybean/mhapp95/AGRO932Project/Log/Out/SAFDiverse_'.$i.'.out'."\n\n";


	print OUT 'cd /work/soybean/mhapp95/AGRO932Project/Data/Bam/'."\n"; 
	print OUT 'angsd -b Diverse.bam.txt  -anc /work/soybean/mhapp95/PopGenvQTL/Data/Reference/GlyMax/GlyMax.fasta -ref /work/soybean/mhapp95/PopGenvQTL/Data/Reference/GlyMax/GlyMax.fasta -out /work/soybean/mhapp95/AGRO932Project/Data/SAF/Diverse_Chr'.$i.' -nThreads 16 -P 24 -dosaf 1 -gl 1 -baq 1 -C 50 -minMapQ 30 -minQ 20 -r '.$i.''."\n";

	close OUT;

	system('sbatch Submitted/SAFDiverse_Chr'.$i.'.slurm');

}
