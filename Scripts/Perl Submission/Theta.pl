#!/usr/bin/perl -w
use strict;

for(my $i = 1; $i <= 20; $i++){

	open(OUT, '>Submitted/thetaHY_Chr'.$i.'.slurm');

	print OUT '#!/bin/sh'."\n";
	print OUT '#SBATCH --ntasks-per-node=1'."\n";
	print OUT '#SBATCH --nodes=1'."\n";
	print OUT '#SBATCH --mem=85gb'."\n";
	print OUT '#SBATCH --time=5:00:00'."\n";
	print OUT '#SBATCH --job-name='.$i.'_HY'."\n";
	print OUT '#SBATCH --error=/work/soybean/mhapp95/AGRO932Project/Log/thetavHY_'.$i.'.error'."\n";
	print OUT '#SBATCH --output=/work/soybean/mhapp95/AGRO932Project/Log/thetaHY_'.$i.'.out'."\n\n";

	print OUT 'cd /work/soybean/mhapp95/AGRO932Project/Data/'."\n"; 
#	print OUT 'realSFS SAF/HY_Chr'.$i.'.saf.idx -P 24 > SFS/HY_Chr'.$i.'.sfs'."\n";
#	print OUT 'angsd -b Bam/HighYield.bam.txt  -anc /work/soybean/mhapp95/PopGenvQTL/Data/Reference/GlyMax/GlyMax.fasta -ref /work/soybean/mhapp95/PopGenvQTL/Data/Reference/GlyMax/GlyMax.fasta -pest SFS/HY_Chr'.$i.'.sfs -out Theta/HY_Chr'.$i.' -nThreads 16 -P 8 -gl 1 -baq 1 -C 50 -minMapQ 30 -minQ 20 -r '.$i.' -doThetas 1 -doSaf 1'."\n";
	print OUT 'thetaStat print Theta/HY_Chr'.$i.'.thetas.idx > Theta/HY_Chr'.$i.'.theta.txt'."\n";
	print OUT 'thetaStat do_stat Theta/HY_Chr'.$i.'.thetas.idx -win 5000 -step 1000  -outnames Theta/HY_Chr'.$i.'.thetasWindow'."\n";

	
	close OUT;
	
	system('sbatch Submitted/thetaHY_Chr'.$i.'.slurm');

	open(OUT, '>Submitted/thetaDr_Chr'.$i.'.slurm');

	print OUT '#!/bin/sh'."\n";
	print OUT '#SBATCH --ntasks-per-node=1'."\n";
	print OUT '#SBATCH --nodes=1'."\n";
	print OUT '#SBATCH --mem=85gb'."\n";
	print OUT '#SBATCH --time=5:00:00'."\n";
	print OUT '#SBATCH --job-name='.$i.'_Dr'."\n";
	print OUT '#SBATCH --error=/work/soybean/mhapp95/AGRO932Project/Log/thetavDr_'.$i.'.error'."\n";
	print OUT '#SBATCH --output=/work/soybean/mhapp95/AGRO932Project/Log/thetaDr_'.$i.'.out'."\n\n";

	print OUT 'cd /work/soybean/mhapp95/AGRO932Project/Data/'."\n"; 
#	print OUT 'realSFS SAF/Drought_Chr'.$i.'.saf.idx -P 24 > SFS/Drought_Chr'.$i.'.sfs'."\n";
#	print OUT 'angsd -b Bam/Drought.bam.txt  -anc /work/soybean/mhapp95/PopGenvQTL/Data/Reference/GlyMax/GlyMax.fasta -ref /work/soybean/mhapp95/PopGenvQTL/Data/Reference/GlyMax/GlyMax.fasta -pest SFS/Drought_Chr'.$i.'.sfs -out Theta/Drought_Chr'.$i.' -nThreads 16 -P 8 -gl 1 -baq 1 -C 50 -minMapQ 30 -minQ 20 -r '.$i.' -doThetas 1 -doSaf 1'."\n";
	print OUT 'thetaStat print Theta/Drought_Chr'.$i.'.thetas.idx > Theta/Drought_Chr'.$i.'.theta.txt'."\n";
	print OUT 'thetaStat do_stat Theta/Drought_Chr'.$i.'.thetas.idx -win 5000 -step 1000  -outnames Theta/Drought_Chr'.$i.'.thetasWindow'."\n";

	
	close OUT;
	
	system('sbatch Submitted/thetaDr_Chr'.$i.'.slurm');

	open(OUT, '>Submitted/thetaDv_Chr'.$i.'.slurm');

	print OUT '#!/bin/sh'."\n";
	print OUT '#SBATCH --ntasks-per-node=1'."\n";
	print OUT '#SBATCH --nodes=1'."\n";
	print OUT '#SBATCH --mem=85gb'."\n";
	print OUT '#SBATCH --time=5:00:00'."\n";
	print OUT '#SBATCH --job-name='.$i.'_Dv'."\n";
	print OUT '#SBATCH --error=/work/soybean/mhapp95/AGRO932Project/Log/thetavDv_'.$i.'.error'."\n";
	print OUT '#SBATCH --output=/work/soybean/mhapp95/AGRO932Project/Log/thetaDv_'.$i.'.out'."\n\n";

	print OUT 'cd /work/soybean/mhapp95/AGRO932Project/Data/'."\n"; 
#	print OUT 'realSFS SAF/Diverse_Chr'.$i.'.saf.idx -P 24 > SFS/Diverse_Chr'.$i.'.sfs'."\n";
#	print OUT 'angsd -b Bam/Diverse.bam.txt  -anc /work/soybean/mhapp95/PopGenvQTL/Data/Reference/GlyMax/GlyMax.fasta -ref /work/soybean/mhapp95/PopGenvQTL/Data/Reference/GlyMax/GlyMax.fasta -pest SFS/Diverse_Chr'.$i.'.sfs -out Theta/Diverse_Chr'.$i.' -nThreads 16 -P 8 -gl 1 -baq 1 -C 50 -minMapQ 30 -minQ 20 -r '.$i.' -doThetas 1 -doSaf 1'."\n";
	print OUT 'thetaStat print Theta/Diverse_Chr'.$i.'.thetas.idx > Theta/Diverse_Chr'.$i.'.theta.txt'."\n";
	print OUT 'thetaStat do_stat Theta/Diverse_Chr'.$i.'.thetas.idx -win 5000 -step 1000  -outnames Theta/Diverse_Chr'.$i.'.thetasWindow'."\n";

	
	close OUT;
	
	system('sbatch Submitted/thetaDv_Chr'.$i.'.slurm');

}
