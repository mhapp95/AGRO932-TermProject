library(data.table)
library(ggplot2)
library(dplyr)
library(plyr)

cds <- fread("fst_cds_hy.dv.txt", sep = " ")
gene <- fread("fst_gene_hy.dv.txt", sep = " " )
fivep <- fread("fst_5p_hy.dv.txt", sep = " ")
threep <- fread("fst_3p_hy.dv.txt", sep = " ")
up <- fread("fst_up_hy.dv.txt", sep = " ")
down <- fread("fst_down_hy.dv.txt", sep = " ")

gene$feature <- "Gene"
cds$feature <- "CDS"
fivep$feature <- "5' UTR"
threep$feature <- "3' UTR"
up$feature <- "5K Upstream"
down$feature <- "5K Downstream"
res <- rbind(gene, cds, up, down, threep, fivep)

png("Features.Fst.HY.Diverse.png", width=400, height=400)
ggplot(res, aes(x=feature, y=Fst, fill=feature)) + 
  geom_violin(trim=FALSE)+
  ylim(0,0.0001) +
  theme(axis.text.x = element_text(angle = 45)) +
  labs(title="High Yielding vs Diverse Ancestry", x="Feature", y = "FST")+
  geom_boxplot(width=0.1, fill="white")
#  theme_classic()
dev.off()

#png("Features.ND.HY.Diverse.png", width=400, height=400)
#ggplot(res, aes(x=feature, y=Pairwise, fill=feature)) + 
#  geom_violin(trim=FALSE)+
#  ylim(-30,0) +
#  theme(axis.text.x = element_text(angle = 45)) +
#  labs(title="High Yielding", x="Feature", y = "Nucleotide Diversity")+
#  geom_boxplot(width=0.1, fill="white")
#  theme_classic()
#dev.off()
