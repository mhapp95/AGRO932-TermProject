setwd("C:/Users/mhapp/Desktop/AGRO932/")

library(data.table)
library(ggplot2)
library(RColorBrewer)
library(dplyr)
library(ggrepel)
library(tidyr)
library(plyr)

Fst_1 <- fread("Data/FST.HY.Drought.sw.txt")
Fst_2 <- fread("Data/FST.HY.Diverse.sw.txt")
Fst_3 <- fread("Data/FST.Diverse.Drought.sw.txt")
colnames(Fst_1) <- c ("range", "CHR", "BP", "SNP", "Fst")
colnames(Fst_2) <- c ("range", "CHR", "BP", "SNP", "Fst")
colnames(Fst_3) <- c ("range", "CHR", "BP", "SNP", "Fst")
Fst <- merge(Fst_1, merge(Fst_2, Fst_3, by = c("CHR", "BP")), by = c("CHR", "BP"))  
Theta_1 <- fread("Data/Theta.HY.sw.txt")
Theta_2 <- fread("Data/Theta.Drought.sw.txt")
Theta_3 <- fread("Data/Theta.Diverse.sw.txt")
colnames(Theta_1) <- c("range", "CHR", "BP", "Watterson's Theta", "Nucleotide Diversity", "tF", "tH", "tL", "Tajima's D", "fuf", "fud", "fayh", "zeng", "SNP")
colnames(Theta_2) <- c("range", "CHR", "BP", "Watterson's Theta", "Nucleotide Diversity", "tF", "tH", "tL", "Tajima's D", "fuf", "fud", "fayh", "zeng", "SNP")
colnames(Theta_3) <- c("range", "CHR", "BP", "Watterson's Theta", "Nucleotide Diversity", "tF", "tH", "tL", "Tajima's D", "fuf", "fud", "fayh", "zeng", "SNP")
Theta <- merge(Theta_1, merge(Theta_2, Theta_3, by = c("CHR", "BP")), by = c("CHR", "BP"))                                      

var <- fread("Data/NAM.gwas.results.txt")
vartwo <- separate(var, ID, into=c("CHR", "ogBP"), sep = ":")
vartwo$CHR <- as.numeric(vartwo$CHR)
vartwo$ogBP <- as.numeric(vartwo$ogBP)
vartwo$BPw <- round_any(vartwo$ogBP, 1000, f = ceiling)
vartwo$BP <- vartwo$BPw - 500

m <- merge(Fst, merge(Theta, vartwo, by = c("CHR", "BP")), by = c("CHR", "BP"))
Data <- data.frame(m$CHR, m$BP, m$Fst, m$Fst.x, m$Fst.y, m$`Watterson's Theta`,  m$`Watterson's Theta.x`,  m$`Watterson's Theta.y`, m$`Nucleotide Diversity`, m$`Nucleotide Diversity.x`, m$`Nucleotide Diversity.y`, m$`Tajima's D`, m$`Tajima's D.x`, m$`Tajima's D.y`, m$vGxE, m$vG)

FstPlot <- Data[,3:5]
colnames(FstPlot) <- c("High Yield/Drought Tolerance", "High Yield/ Diverse Ancestry", "Drought Tolerance/Diverse Ancestry")
FstPlot$vGxE <- Data$m.vGxE
FstPlot$vG <- Data$m.vG
Melt <- melt(FstPlot, id = c("vGxE", "vG"))
colnames(Melt) <- c("vGxE", "vG", "Populations", "Fst")

png("Fst.GxE.png", width=400, height=400)
ggplot(data=Melt, aes(y=`vGxE`, x=`Fst`, color = Populations)) +
  stat_smooth(method = "lm", formula = y ~ poly(x, 1), size = 1) +
  labs(title = "")
dev.off()
png("Fst.G.png", width=400, height=400)
ggplot(data=Melt, aes(y=`vG`, x=`Fst`, color = Populations)) +
    stat_smooth(method = "lm", formula = y ~ poly(x, 1), size = 1) +
    labs(title = "Variance Components v Fst")
dev.off()

Watterson <- Data[,6:8]
colnames(Watterson) <- c("High Yield", "Drought Tolerant", "Diverse Ancestry")
Watterson$vGxE <- Data$m.vGxE
Watterson$vG <- Data$m.vG
Melt <- melt(Watterson, id = c("vGxE", "vG"))
colnames(Melt) <- c("vGxE", "vG", "Populations", "Watterson's Theta")

png("Watterson's Theta.GxE.png", width=400, height=400)
ggplot(data=Melt, aes(y=`vGxE`, x=`Watterson's Theta`, color = Populations)) +
  stat_smooth(method = "lm", formula = y ~ poly(x, 1), size = 1) +
  labs(title = "")
dev.off()
png("Watterson's Theta.G.png", width=400, height=400)
ggplot(data=Melt, aes(y=`vG`, x=`Watterson's Theta`, color = Populations)) +
  stat_smooth(method = "lm", formula = y ~ poly(x, 1), size = 1) +
  labs(title = "Variance Components v Watterson's Theta")
dev.off()

ND <- Data[,9:11]
colnames(ND) <- c("High Yield", "Drought Tolerant", "Diverse Ancestry")
ND$vGxE <- Data$m.vGxE
ND$vG <- Data$m.vG
Melt <- melt(ND, id = c("vGxE", "vG"))
colnames(Melt) <- c("vGxE", "vG", "Populations", "Nucleotide Diversity")

png("Nucleotide Diversity.GxE.png", width=400, height=400)
ggplot(data=Melt, aes(y=`vGxE`, x=`Nucleotide Diversity`, color = Populations)) +
  stat_smooth(method = "lm", formula = y ~ poly(x, 1), size = 1) +
  labs(title = "")
dev.off()
png("Nucleotide Diversity.G.png", width=400, height=400)
ggplot(data=Melt, aes(y=`vG`, x=`Nucleotide Diversity`, color = Populations)) +
  stat_smooth(method = "lm", formula = y ~ poly(x, 1), size = 1) +
  labs(title = "Variance Components v Nucleotide Diversity")
dev.off()


TD <- Data[,12:14]
colnames(TD) <- c("High Yield", "Drought Tolerant", "Diverse Ancestry")
TD$vGxE <- Data$m.vGxE
TD$vG <- Data$m.vG
Melt <- melt(TD, id = c("vGxE", "vG"))
colnames(Melt) <- c("vGxE", "vG", "Populations", "Tajima's D")

png("Tajima's D.GxE.png", width=400, height=400)
ggplot(data=Melt, aes(y=`vGxE`, x=`Tajima's D`, color = Populations)) +
  stat_smooth(method = "lm", formula = y ~ poly(x, 1), size = 1) +
  labs(title = "")
dev.off()
png("Tajima's D.G.png", width=400, height=400)
ggplot(data=Melt, aes(y=`vG`, x=`Tajima's D`, color = Populations)) +
  stat_smooth(method = "lm", formula = y ~ poly(x, 1), size = 1) +
  labs(title = "Variance Components v Tajima's D")
dev.off()

