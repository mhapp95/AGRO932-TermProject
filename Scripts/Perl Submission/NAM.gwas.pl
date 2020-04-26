#!/usr/bin/perl -w
use strict;

print "\n".'Writing jobs ..... '."\n\n";

print "\n".'Submitting jobs ..... '."\n\n";

	for(my $i = 110; $i < 5000; $i=$i+100){

		open(OUT, '>Submitted/NAM_'.$i.'.R');

		print OUT 'rm(list = ls())'."\n\n";

		print OUT "setwd('/work/soybean/mhapp95/AGRO932Project/Data/ReferenceFiles/')"."\n\n";
 
		print OUT 'library(asreml)'."\n";
		print OUT 'library(readr)'."\n";
		print OUT 'library(corpcor)'."\n";
		print OUT 'library(RSpectra)'."\n";
		print OUT 'library(data.table)'."\n";
		print OUT 'library(doParallel)'."\n";
		print OUT 'library(foreach)'."\n";
		print OUT 'library(MASS)'."\n";
		print OUT 'library(asremlPlus)'."\n\n";

		print OUT 'Geno <- fread(file = "G.csv", sep=",", header=TRUE, na.strings="NA")'."\n";
		print OUT 'Pheno <- as.data.frame(read.csv(file = "YieldNAM_All.csv", sep=",", na.strings= "NA"))'."\n\n";

		print OUT 'SNPID <- as.vector(colnames(Geno))'."\n";

		print OUT 'Merged <- merge(Pheno, Geno, by="ID")'."\n";
		print OUT 'Pheno <- Merged[,1:10]'."\n";

		print OUT 'Start <- Sys.time()'."\n\n";

		print OUT 'bottom <-'.$i.'-99'."\n\n";

		print OUT 'Data <- data.frame(Pheno)'."\n";
		print OUT 'Data <- Data[!is.na(Data["Yield"]),]'."\n";
		print OUT 'Data$ID <- as.factor(Data$ID)'."\n";
		print OUT 'Data$Year <- as.factor(Data$Year)'."\n";
		print OUT 'Data$Env <- as.factor(Data$Env)'."\n";
		print OUT 'Data$Env <- as.factor(Data$Loc)'."\n";
 	        print OUT 'Data <- Data[order(Data$ID),]',"\n";
 	        print OUT 'Data <- Data[order(Data$Env),]',"\n";
		
		print OUT 'asreml.options(maxit = 5000, workspace = 8e6, trace=FALSE)'."\n";
		print OUT 'base.modelG <- asreml(Yield ~ PC1 + PC2 + PC3 + PC4 + PC5 + Year*Loc, 
					random =~ Env:ID, 
					data = Data, na.action = na.method(x = "include"))'."\n\n";
	
    		print OUT 'asreml.options(maxit = 5000, workspace = 8e6, trace=FALSE)'."\n";
	        print OUT 'base.modelGE <- asreml(Yield ~ PC1 + PC2 + PC3 + PC4 + PC5 + Year*Loc, 
					random =~ ID, 
					data = Data, na.action = na.method(x = "include"))'."\n\n";

		print OUT "foreach(i=bottom:$i, .packages='asreml', .errorhandling='pass') %do% {"."\n\n";

		print OUT 'MStart <- Sys.time()'."\n\n";

		print OUT 'SNP <-as.vector(Merged[,i])'."\n";            
		print OUT 'DataTwo <- data.frame(Data, SNP)'."\n";
		print OUT 'DataTwo <- DataTwo[!is.na(DataTwo["Yield"]),]'."\n";
		print OUT 'DataTwo$SNP <- as.factor(DataTwo$SNP)'."\n\n";
		
		print OUT 's <- SNPID[i-9]'."\n\n";

		print OUT 'asreml.options(maxit = 5000, workspace = 10e6, trace=FALSE)'."\n";
		print OUT 'snp.modelG <- asreml(Yield ~ PC1 + PC2 + PC3 + PC4 + PC5 + PC5 + Year*Loc,
                                        random =~ SNP + Env:ID, 
					data = DataTwo, na.action = na.method(x = "include"))'."\n\n";

		print OUT 'asreml.options(maxit = 5000, workspace = 10e6, trace=FALSE)'."\n";
		print OUT 'snp.modelGE <- asreml(Yield ~ PC1 + PC2 + PC3 + PC4 + PC5 + PC5 + Year*Loc,
                                        random =~ Env:SNP + ID, 
					data = DataTwo, na.action = na.method(x = "include"))'."\n\n";

		print OUT 'lrtG <- lrt.asreml(base.modelG, snp.modelG, boundary = TRUE)'."\n";
		print OUT 'lrtGE <- lrt.asreml(base.modelGE, snp.modelGE, boundary = TRUE)'."\n";
		print OUT 'SigG <- lrtG[1,3]'."\n";
		print OUT 'SigGE <- lrtGE[1,3]'."\n";

		print OUT 'var.modelG <- asreml(Yield ~ 1,
                                        random =~ SNP + Env:ID + Year + Loc ,
                                        data = DataTwo, na.action = na.method(x = "include"))'."\n\n";

		print OUT 'var.modelGE <- asreml(Yield ~ 1,
                                        random =~ Env:SNP + ID + Year + Loc,
                                        data = DataTwo, na.action = na.method(x = "include"))'."\n\n";

		print OUT 'sum <- vpredict(var.modelG, hA~(V1)/(V1+V2+V3+V4+V5))'."\n";
		print OUT 'SNP <-  sum[1,1]'."\n";
		print OUT 'sum <- vpredict(var.modelGE, hA~(V3)/(V1+V2+V3+V4+V5))'."\n";
		print OUT 'SNPxE <-  sum[1,1]'."\n";
		print OUT 'MFinish <- Sys.time()'."\n";
		print OUT 'Time <- MFinish - MStart'."\n";
		print OUT "cat('Model Took', Time, '\n')"."\n\n";

		print OUT "cat('SNP', s, 'P vals', SigG, SigGE, 'Var', SNP, SNPxE, '\n')"."\n";

		print OUT '}'."\n\n";

		print OUT 'Finish  <- Sys.time()'."\n";
		print OUT 'Finish - Start'."\n\n";

		close OUT;

                open(OUT, '>Submitted/NAM_'.$i.'.slurm');

                print OUT '#!/bin/sh'."\n";
                print OUT '#SBATCH --ntasks-per-node=1'."\n";
                print OUT '#SBATCH --nodes=1'."\n";
                print OUT '#SBATCH --mem=85gb'."\n";
                print OUT '#SBATCH --time=6:30:00'."\n";
                print OUT '#SBATCH --job-name=NAM_'.$i.''."\n";
                print OUT '#SBATCH --error=/work/soybean/mhapp95/AGRO932Project/Log/NAM_'.$i.'.error'."\n";
                print OUT '#SBATCH --output=/work/soybean/mhapp95/AGRO932Project/Log/NAM_'.$i.'.out'."\n\n";

                print OUT 'cd /work/soybean/mhapp95/AGRO932Project/Scripts/Submitted/'."\n\n";

                print OUT 'module load R/3.5'."\n\n";

                print OUT 'nohup R CMD BATCH --no-restore --no-save NAM_'.$i.'.R'."\n";

                system('sbatch /work/soybean/mhapp95/AGRO932Project/Scripts/Submitted/NAM_'.$i.'.slurm');

		close OUT;
                	
		}
