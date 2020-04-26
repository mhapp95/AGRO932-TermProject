#!/bin/sh
#SBATCH --ntasks-per-node=16
#SBATCH --nodes=1
#SBATCH --mem=125gb
#SBATCH --time=10:00:00
#SBATCH --job-name=Drought
#SBATCH --error=/work/soybean/mhapp95/AGRO932Project/Log/Drought.error
#SBATCH --output=/work/soybean/mhapp95/AGRO932Project/Log/Drought.out

perl table_annovar.pl /work/soybean/mhapp95/AGRO932Project/Data/VCF/Drought.SNPs.vcf soybeandb/ -buildver GM46 -protocol refGene -out Drought -operation g -vcfinput
