setwd("C:/Users/mhapp/Desktop/AGRO932/")

library(data.table)
library(ggplot2)
library(RColorBrewer)
library(dplyr)
library(ggrepel)

Fst_1 <- fread("Data/FST.HY.Drought.sw.txt")
Fst_2 <- fread("Data/FST.HY.Diverse.sw.txt")
Fst_3 <- fread("Data/FST.Diverse.Drought.sw.txt")

colnames(Fst_1) <- c ("range", "CHR", "BP", "SNP", "Fst")
colnames(Fst_2) <- c ("range", "CHR", "BP", "SNP", "Fst")
colnames(Fst_3) <- c ("range", "CHR", "BP", "SNP", "Fst")

M <- rbind(Fst_1, Fst_2, Fst_3)                                       
M$Population = c(rep("High Yield/Drought Tolerant", 940486), rep("High Yield/Diverse Ancestry", 940760), rep("Drought Tolerant/Diverse Ancestry", 940484))

png("Fst.dist.png", width=400, height=400)
ggplot(data=M, aes(y=`Fst`, x=Population, fill=Population)) +
  geom_boxplot(axes=FALSE) + ylim(0,1) +
  labs(title="Distribution of Pairwise Fst") +
  theme(axis.ticks = element_blank(), axis.text.x = element_blank()) + 
  scale_fill_manual(values = c("violetred", "thistle", "steelblue"))
dev.off()


mypalette <- c("seagreen", "steelblue")
sig = NA
sugg = NA

png("FST.HY.Drought.manhattan.png", width=1200, height=600)
gg.manhattan(Fst_1, threshold=sugg, hlight=NA, col=mypalette, ylims=c(0,1), title="Fst between High Yielding and Drought Tolerant Population")
dev.off()

png("FST.HY.Diverse.manhattan.png", width=1200, height=600)
gg.manhattan(Fst_2, threshold=sugg, hlight=NA, col=mypalette, ylims=c(0,1), title="Fst between High Yielding and Diverse Population")
dev.off()

png("FST.Diverse.Drought.manhattan.png", width=1200, height=600)
gg.manhattan(Fst_3, threshold=sugg, hlight=NA, col=mypalette, ylims=c(0,1), title="Fst between Diverse and Drought Tolerant Population")
dev.off()
