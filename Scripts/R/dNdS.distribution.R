setwd("C:/Users/mhapp/Desktop/AGRO932/")

library(data.table)
library(ggplot2)
library(RColorBrewer)
library(dplyr)
library(ggrepel)
library(tidyr)

Database <- fread("Data/All.exons.code")
Dr <- fread("Data/Drought.exon.table", header = FALSE)
Dv <- fread("Data/Diverse.exon.table", header = FALSE)
HY <- fread("Data/HighYield.exon.table", header = FALSE) 

colnames(Database) <- c("Start", "Stop", "Gene")
colnames(HY) <- c("Pos", "Type", "S", "Gene")
HY$S <- NULL
HY$Pop <- rep("High Yield", length(HY$Pos))
colnames(Dr) <- c("Pos", "Type", "S", "Gene")
Dr$S <- NULL
Dr$Pop <- rep("Drought Tolerant", length(Dr$Pos))
colnames(Dv) <- c("Pos", "Type", "S", "Gene")
Dv$S <- NULL
Dv$Pop <- rep("Diverse Ancestry", length(Dv$Pos))
Populations <- rbind(Dr, Dv, HY)

Merge <- merge(Database, Populations, by = "Gene")
Merge$key <- interaction(Merge$Gene, Merge$Pop, sep = ":")
Data <- extract(Merge, Gene, into = c("Discard", "Chr", "Discard2"), "(.{6})(.{2})(.{7})", remove=FALSE)
Data$Discard <- NULL
Data$Discard2 <- NULL
Data$Length <- Data$Stop - Data$Start
New <- Data[order(Data$Chr, Data$Pos),]
New$nonSyn <- ifelse(Data$Type == "nonsynonymous", 1/Data$Length, 0)
New$Syn <- ifelse(Data$Type == "synonymous", 1/Data$Length, 0)
attach(New)
Summary <- data.frame(key, nonSyn, Syn)
detach(New)

ratio <- function(df){
  y <- sum(df$nonSyn)/sum(df$Syn)
  return(y)
}

dNdSRatios <- Summary %>%
  group_by(key) %>%
  do(data.frame(dNdS=ratio(.)))

Merge <- merge(dNdSRatios, New, by = "key")

png("dNdS.dist.png", width=1200, height=600)
ggplot(Merge, aes(x=Pop, y=log(dNdS+1), fill=Pop)) + 
  geom_boxplot()+
  labs(title="Distribution of dN/dS Ratios", x="Population", y = "log(dN/dS+1)")+
  geom_boxplot(width=0.1, fill="white")+
#  scale_fill_manual(values=c("seagreen", "steelblue", "goldenrod")) + 
  theme_classic()
dev.off()
