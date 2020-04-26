#!/usr/bin/perl -w
use strict;

for(my $i = 1; $i <= 20; $i++){

	open(OUT, '>Submitted/FST.HY.Drought_Chr'.$i.'.slurm');

	print OUT '#!/bin/sh'."\n";
	print OUT '#SBATCH --ntasks-per-node=1'."\n";
	print OUT '#SBATCH --nodes=1'."\n";
	print OUT '#SBATCH --mem=125gb'."\n";
	print OUT '#SBATCH --time=15:00:00'."\n";
	print OUT '#SBATCH --job-name=FST'."\n";
	print OUT '#SBATCH --error=/work/soybean/mhapp95/AGRO932Project/Log/Error/FST.HY.Drought_'.$i.'.error'."\n";
	print OUT '#SBATCH --output=/work/soybean/mhapp95/AGRO932Project/Log/Out/FST.HY.Drought_'.$i.'.out'."\n\n";

	print OUT 'cd /work/soybean/mhapp95/AGRO932Project/Data/'."\n\n";
 
#prepare the fst for easy window analysis etc
	print OUT 'realSFS fst index SAF/HY_Chr'.$i.'.saf.idx SAF/Drought_Chr'.$i.'.saf.idx -sfs 2DSFS/HY.Drought_Chr'.$i.'.ml -fstout FST/HY.Drought.Chr'.$i.' '."\n\n";

#get the global estimate
	print OUT 'realSFS fst stats FST/HY.Drought.Chr'.$i.'.fst.idx'."\n\n";

#get all
	print OUT 'realSFS fst print FST/HY.Drought.Chr'.$i.'.fst.idx > FST/HY.Drought.Chr'.$i.'.indvfst'."\n\n";

#sliding window
	print OUT 'realSFS fst stats2 FST/HY.Drought.Chr'.$i.'.fst.idx -win 5000 -step 1000 > FST/HY.Drought.Chr'.$i.'.slidingwindow'."\n\n";

	close OUT;

#	system('sbatch Submitted/FST.HY.Drought_Chr'.$i.'.slurm');

}

for(my $i = 1; $i <= 20; $i++){

	open(OUT, '>Submitted/FST.HY.Diverse_Chr'.$i.'.slurm');

	print OUT '#!/bin/sh'."\n";
	print OUT '#SBATCH --ntasks-per-node=1'."\n";
	print OUT '#SBATCH --nodes=1'."\n";
	print OUT '#SBATCH --mem=125gb'."\n";
	print OUT '#SBATCH --time=15:00:00'."\n";
	print OUT '#SBATCH --job-name=FST'."\n";
	print OUT '#SBATCH --error=/work/soybean/mhapp95/AGRO932Project/Log/Error/FST.HY.Diverse_'.$i.'.error'."\n";
	print OUT '#SBATCH --output=/work/soybean/mhapp95/AGRO932Project/Log/Out/FST.HY.Diverse_'.$i.'.out'."\n\n";

	print OUT 'cd /work/soybean/mhapp95/AGRO932Project/Data/'."\n\n";
 
#prepare the fst for easy window analysis etc
	print OUT 'realSFS fst index SAF/HY_Chr'.$i.'.saf.idx SAF/Diverse_Chr'.$i.'.saf.idx -sfs 2DSFS/HY.Diverse_Chr'.$i.'.ml -fstout FST/HY.Diverse.Chr'.$i.' '."\n\n";

#get the global estimate
	print OUT 'realSFS fst stats FST/HY.Diverse.Chr'.$i.'.fst.idx'."\n\n";

#get all
	print OUT 'realSFS fst print FST/HY.Diverse.Chr'.$i.'.fst.idx > FST/HY.Diverse.Chr'.$i.'.indvfst'."\n\n";

#sliding window
	print OUT 'realSFS fst stats2 FST/HY.Diverse.Chr'.$i.'.fst.idx -win 5000 -step 1000 > FST/HY.Diverse.Chr'.$i.'.slidingwindow'."\n\n";

	close OUT;

#	system('sbatch Submitted/FST.HY.Diverse_Chr'.$i.'.slurm');

}

for(my $i = 1; $i <= 20; $i++){

	open(OUT, '>Submitted/FST.Diverse.Drought_Chr'.$i.'.slurm');

	print OUT '#!/bin/sh'."\n";
	print OUT '#SBATCH --ntasks-per-node=1'."\n";
	print OUT '#SBATCH --nodes=1'."\n";
	print OUT '#SBATCH --mem=125gb'."\n";
	print OUT '#SBATCH --time=15:00:00'."\n";
	print OUT '#SBATCH --job-name=FST'."\n";
	print OUT '#SBATCH --error=/work/soybean/mhapp95/AGRO932Project/Log/Error/FST.Diverse.Drought_'.$i.'.error'."\n";
	print OUT '#SBATCH --output=/work/soybean/mhapp95/AGRO932Project/Log/Out/FST.Diverse.Drought_'.$i.'.out'."\n\n";

	print OUT 'cd /work/soybean/mhapp95/AGRO932Project/Data/'."\n\n";
 
#prepare the fst for easy window analysis etc
#	print OUT 'realSFS fst index SAF/Drought_Chr'.$i.'.saf.idx SAF/Diverse_Chr'.$i.'.saf.idx -sfs 2DSFS/Drought.Diverse_Chr'.$i.'.ml -fstout FST/Drought.Diverse.Chr'.$i.' '."\n\n";

#get the global estimate
	print OUT 'realSFS fst stats FST/Drought.Diverse.Chr'.$i.'.fst.idx'."\n\n";

#get all
	print OUT 'realSFS fst print FST/Drought.Diverse.Chr'.$i.'.fst.idx > FST/Diverse.DroughtChr'.$i.'.indvfst'."\n\n";

#sliding window
	print OUT 'realSFS fst stats2 FST/Drought.Diverse.Chr'.$i.'.fst.idx -win 5000 -step 1000 > FST/Diverse.Drought.Chr'.$i.'.slidingwindow'."\n\n";

	close OUT;

	system('sbatch Submitted/FST.Diverse.Drought_Chr'.$i.'.slurm');

}
