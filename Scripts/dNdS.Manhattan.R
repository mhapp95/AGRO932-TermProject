setwd("C:/Users/mhapp/Desktop/AGRO932/")

library(data.table)
library(ggplot2)
library(RColorBrewer)
library(dplyr)
library(ggrepel)
library(tidyr)

Database <- fread("Data/All.exons.code")
HY <- fread("Data/Drought.exon.table", header = FALSE)

colnames(Database) <- c("Start", "Stop", "Gene")
colnames(HY) <- c("Pos", "Type", "S", "Gene")
HY$S <- NULL

Merge <- merge(Database, HY, by = "Gene")
Data <- extract(Merge, Gene, into = c("Discard", "Chr", "Discard2"), "(.{6})(.{2})(.{7})", remove=FALSE)
Data$Discard <- NULL
Data$Discard2 <- NULL
Data$Length <- Data$Stop - Data$Start
New <- Data[order(Data$Chr, Data$Pos),]

New$nonSyn <- ifelse(Data$Type == "nonsynonymous", 1/Data$Length, 0)
New$Syn <- ifelse(Data$Type == "synonymous", 1/Data$Length, 0)
attach(New)
Summary <- data.frame(Gene, nonSyn, Syn)
detach(New)

ratio <- function(df){
  y <- sum(df$nonSyn)/sum(df$Syn)
  return(y)
}

dNdSRatios <- Summary %>%
  group_by(Gene) %>%
  do(data.frame(dNdS=ratio(.)))

Merge <- merge(dNdSRatios, New, by = "Gene")
Final <- as.data.frame(as.numeric(as.factor(Merge$Chr)))
Final$CHR <- Final[,1]
Final[,1] <- NULL
Final$BP <- Merge$Start
Final$SNP <- Merge$Gene
Final$dNdS <- Merge$dNdS
Final$dNdS <- ifelse(Final$dNdS == "Inf", runif(1, min=0.01, max=0.05) , Final$dNdS)
Final <- na.omit(unique(Final))
max(log(Final$dNdS))

mypalette <- c("goldenrod", "firebrick")
sugg = 0
sig = 0

png("dNdS.Drought.png", width=1200, height=600)
gg.manhattan(Final, threshold=sugg, hlight=NA, col=mypalette, ylims=c(0,10), title="dNdS Ratio Across Genes, Drought Tolerant Population")
dev.off()
