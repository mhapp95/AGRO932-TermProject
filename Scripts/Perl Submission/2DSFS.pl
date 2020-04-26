#!/usr/bin/perl -w
use strict;

for(my $i = 1; $i <= 20; $i++){

	open(OUT, '>Submitted/2DSFS.HY.Drought.Chr'.$i.'.slurm');

	print OUT '#!/bin/sh'."\n";
	print OUT '#SBATCH --ntasks-per-node=16'."\n";
	print OUT '#SBATCH --nodes=1'."\n";
	print OUT '#SBATCH --mem=125gb'."\n";
	print OUT '#SBATCH --time=125:00:00'."\n";
	print OUT '#SBATCH --job-name=2DSFS'."\n";
	print OUT '#SBATCH --error=/work/soybean/mhapp95/AGRO932Project/Log/Error/2DSFS.HY.Drought._'.$i.'.error'."\n";
	print OUT '#SBATCH --output=/work/soybean/mhapp95/AGRO932Project/Log/Out/2DSFS.HY.Drought._'.$i.'.out'."\n\n";

	print OUT 'cd /work/soybean/mhapp95/AGRO932Project/Data/'."\n\n";
 
	print OUT 'realSFS -P 24 SAF/HY_Chr'.$i.'.saf.idx SAF/Drought_Chr'.$i.'.saf.idx > 2DSFS/HY.Drought_Chr'.$i.'.ml '."\n";

	close OUT;

	system('sbatch Submitted/2DSFS.HY.Drought.Chr'.$i.'.slurm');

	open(OUT, '>Submitted/2DSFS.HY.Diverse.Chr'.$i.'.slurm');

	print OUT '#!/bin/sh'."\n";
	print OUT '#SBATCH --ntasks-per-node=16'."\n";
	print OUT '#SBATCH --nodes=1'."\n";
	print OUT '#SBATCH --mem=125gb'."\n";
	print OUT '#SBATCH --time=125:00:00'."\n";
	print OUT '#SBATCH --job-name=2DSFS'."\n";
	print OUT '#SBATCH --error=/work/soybean/mhapp95/AGRO932Project/Log/Error/2DSFS.HY.Diverse_'.$i.'.error'."\n";
	print OUT '#SBATCH --output=/work/soybean/mhapp95/AGRO932Project/Log/Out/2DSFS.HY.Diverse._'.$i.'.out'."\n\n";

	print OUT 'cd /work/soybean/mhapp95/AGRO932Project/Data/'."\n\n";
 
	print OUT 'realSFS -P 24 SAF/HY_Chr'.$i.'.saf.idx SAF/Diverse_Chr'.$i.'.saf.idx > 2DSFS/HY.Diverse_Chr'.$i.'.ml '."\n";

	close OUT;

	system('sbatch Submitted/2DSFS.HY.Diverse.Chr'.$i.'.slurm');

	open(OUT, '>Submitted/2DSFS.Drought.Diverse.Chr'.$i.'.slurm');

	print OUT '#!/bin/sh'."\n";
	print OUT '#SBATCH --ntasks-per-node=16'."\n";
	print OUT '#SBATCH --nodes=1'."\n";
	print OUT '#SBATCH --mem=125gb'."\n";
	print OUT '#SBATCH --time=125:00:00'."\n";
	print OUT '#SBATCH --job-name=2DSFS'."\n";
	print OUT '#SBATCH --error=/work/soybean/mhapp95/AGRO932Project/Log/Error/2DSFS.Drought.Diverse._'.$i.'.error'."\n";
	print OUT '#SBATCH --output=/work/soybean/mhapp95/AGRO932Project/Log/Out/2DSFS.Drought.Diverse._'.$i.'.out'."\n\n";

	print OUT 'cd /work/soybean/mhapp95/AGRO932Project/Data/'."\n\n";
 
	print OUT 'realSFS -P 24 SAF/Drought_Chr'.$i.'.saf.idx SAF/Diverse_Chr'.$i.'.saf.idx > 2DSFS/Drought.Diverse_Chr'.$i.'.ml '."\n";

	close OUT;

#	system('sbatch Submitted/2DSFS.Drought.Diverse.Chr'.$i.'.slurm');

}
