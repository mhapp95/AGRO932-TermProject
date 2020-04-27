#!/bin/sh
#SBATCH --ntasks-per-node=16
#SBATCH --nodes=2
#SBATCH --mem=245gb
#SBATCH --time=5:00:00
#SBATCH --job-name=GF
#SBATCH --error=GF2.error
#SBATCH --output=GF2.out

module load R/3.5

R CMD BATCH GenomicFeature_Lookup.R
