#!/bin/sh
#SBATCH --ntasks-per-node=16
#SBATCH --nodes=1
#SBATCH --mem=105gb
#SBATCH --time=5:00:00
#SBATCH --job-name=GF
#SBATCH --error=GF.error
#SBATCH --output=GF.out

module load R/3.5

R CMD BATCH GenomicFeature_Graph.R
