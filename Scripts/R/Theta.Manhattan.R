setwd("C:/Users/mhapp/Desktop/AGRO932/")

library(data.table)
library(ggplot2)
library(RColorBrewer)
library(dplyr)
library(ggrepel)
library(hrbrthemes)

Theta_1 <- fread("Data/Theta.HY.sw.txt")
Theta_2 <- fread("Data/Theta.Drought.sw.txt")
Theta_3 <- fread("Data/Theta.Diverse.sw.txt")

colnames(Theta_1) <- c("range", "CHR", "BP", "Watterson's Theta", "Nucleotide Diversity", "tF", "tH", "tL", "Tajima's D", "fuf", "fud", "fayh", "zeng", "SNP")
colnames(Theta_2) <- c("range", "CHR", "BP", "Watterson's Theta", "Nucleotide Diversity", "tF", "tH", "tL", "Tajima's D", "fuf", "fud", "fayh", "zeng", "SNP")
colnames(Theta_3) <- c("range", "CHR", "BP", "Watterson's Theta", "Nucleotide Diversity", "tF", "tH", "tL", "Tajima's D", "fuf", "fud", "fayh", "zeng", "SNP")
                              
M <- rbind(Theta_1, Theta_2, Theta_3)                                       
M$Population = c(rep("High Yield", 949069), rep("Drought Tolerant", 949069), rep("Diverse Ancestry", 949069))

png("Theta.dist.png", width=400, height=400)
ggplot(data=M, aes(y=`Watterson's Theta`, x=Population, fill=Population)) +
  geom_boxplot(axes=FALSE) + ylim(0,10) +
  labs(title="Distribution of Watterson's Theta") +
  theme(axis.ticks = element_blank(), axis.text.x = element_blank()) +
  scale_fill_manual(values = c("violetred", "thistle", "steelblue"))
dev.off()

png("NucleotideDiversity.dist.png", width=400, height=400)
ggplot(data=M, aes(y=`Nucleotide Diversity`, x=Population, fill=Population)) +
  geom_boxplot(axes=FALSE) + ylim(0,15) +
labs(title="Distribution of Nucleotide Diversity", x = "") +
  theme(axis.ticks = element_blank(), axis.text.x = element_blank()) +
  scale_fill_manual(values = c("violetred", "thistle","steelblue"))
dev.off()

png("TajmiasD.dist.png", width=400, height=400)
ggplot(data=M, aes(y=`Tajima's D`, x=Population, fill=Population)) +
  geom_boxplot(axes=FALSE) + ylim(-4,4) +
  labs(title="Distribution of Tajima's D") +
  theme(axis.ticks = element_blank(), axis.text.x = element_blank()) +
  scale_fill_manual(values = c("violetred", "thistle", "steelblue"))
dev.off()


mypalette <- c("violetred", "thistle")
sig = NA
sugg = NA
   
##### change y axis in plotting script between measures ######                    
##### change color palettes between measures ######                    
##### pay attention to limits ######    

min(c(Theta_1$`Watterson's Theta`, Theta_2$`Watterson's Theta`, Theta_3$`Watterson's Theta`))
max(c(Theta_1$`Watterson's Theta`, Theta_2$`Watterson's Theta`, Theta_3$`Watterson's Theta`))

png("Theta.HY.manhattan.png", width=1200, height=600)
gg.manhattan(Theta_1, threshold=sugg, hlight=NA, col=mypalette, ylims=c(0,50), title="Watterson's Theta, High Yielding Population")
dev.off()
                       
png("Theta.Drought.manhattan.png", width=1200, height=600)
gg.manhattan(Theta_2, threshold=sugg, hlight=NA, col=mypalette, ylims=c(0,50), title="Watterson's Theta, Drought Population")
dev.off()
                       
png("Theta.Diverse.manhattan.png", width=1200, height=600)
gg.manhattan(Theta_3, threshold=sugg, hlight=NA, col=mypalette, ylims=c(0,50), title="Watterson's Theta, Diverse Population")
dev.off()                                                                     

mypalette <- c("steelblue", "seagreen")
min(c(Theta_1$`Nucleotide Diversity`, Theta_2$`Nucleotide Diversity`, Theta_3$`Nucleotide Diversity`))
max(c(Theta_1$`Nucleotide Diversity`, Theta_2$`Nucleotide Diversity`, Theta_3$`Nucleotide Diversity`))

png("NucleotideDiversity.HY.manhattan.png", width=1200, height=600)
gg.manhattan(Theta_1, threshold=sugg, hlight=NA, col=mypalette, ylims=c(0,70), title="Nucleotide Diversity, High Yielding Population")
dev.off()

png("NucleotideDiversity.Drought.manhattan.png", width=1200, height=600)
gg.manhattan(Theta_2, threshold=sugg, hlight=NA, col=mypalette, ylims=c(0,70), title="Nucleotide Diversity, Drought Population")
dev.off()

png("NucleotideDiversity.Diverse.manhattan.png", width=1200, height=600)
gg.manhattan(Theta_3, threshold=sugg, hlight=NA, col=mypalette, ylims=c(0,70), title="Nucleotide Diversity, Diverse Population")
dev.off()                               

mypalette <- c("darkgoldenrod", "firebrick")
min(c(Theta_1$`Tajima's D`, Theta_2$`Tajima's D`, Theta_3$`Tajima's D`))
max(c(Theta_1$`Tajima's D`, Theta_2$`Tajima's D`, Theta_3$`Tajima's D`))
sig = 0

png("TajimasD.HY.manhattan.png", width=1200, height=600)
gg.manhattan(Theta_1, threshold=sugg, hlight=NA, col=mypalette, ylims=c(-4,4), title="Tajima's D, High Yielding Population")
dev.off()

png("TajimasD.Drought.manhattan.png", width=1200, height=600)
gg.manhattan(Theta_2, threshold=sugg, hlight=NA, col=mypalette, ylims=c(-4,4), title="Tajima's D, Drought Population")
dev.off()

png("TajimasD.Diverse.manhattan.png", width=1200, height=600)
gg.manhattan(Theta_3, threshold=sugg, hlight=NA, col=mypalette, ylims=c(-4,4), title="Tajima's D, Diverse Population")
dev.off()    
