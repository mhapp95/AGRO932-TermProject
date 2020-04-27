library(data.table)
library(readr)
library(ggplot2)
library(dplyr)
library(GenomicRanges)
library(plyr)

gff <- fread(cmd='grep -v "#" GlyMax.gff3', header=FALSE, data.table=FALSE)
names(gff) <- c("seq", "source", "feature", "start", "end", "score", "strand", "phase", "att")
gp <- subset(gff, strand %in% "+") 

gp_5p <- subset(gp, feature %in% "five_prime_UTR")
gp_5p$geneid <- gsub(".*gene:|;biotype.*", "", gp_5p$att)
gp_3p <- subset(gp, feature %in% "three_prime_UTR")
gp_3p$geneid <- gsub(".*gene:|;biotype.*", "", gp_3p$att)
gp_cds <- subset(gp, feature %in% "CDS")
gp_cds$geneid <- gsub(".*gene:|;biotype.*", "", gp_cds$att)
gp_gene <- subset(gp, feature %in% "gene")
gp_gene$geneid <- gsub(".*gene:|;biotype.*", "", gp_gene$att)

g <- subset(gp, feature %in% "gene")
g$geneid <- gsub(".*gene:|;biotype.*", "", g$att)
gp_up <- g
gp_up$end <- gp_up$start - 1
gp_up$start <- gp_up$end - 5000
gp_down <- g
gp_down$start <- gp_down$end + 1
gp_down$end <- gp_down$start + 5000

get_mean_theta <- function(feature){
  # gf_file: gene feature file [chr, ="cache/mt_gene_up5k.txt"]
  theta <- fread("FinishedResults/FST.HY.Diverse.all.txt")
  colnames(theta) <- c("seq", "Pos", "Un", "Fst")	
#  names(theta)[1] <- "seq"
  ### define the subject file for theta values
  grc <- with(theta, GRanges(seqnames=seq, IRanges(start=Pos, end=Pos)))
  ### define the query file for genomic feature
  grf <- with(feature, GRanges(seqnames=seq, IRanges(start=start, end=end), geneid=geneid))
  ### find overlaps between the two
  tb <- findOverlaps(query=grf, subject=grc)
  tb <- as.matrix(tb)
  out1 <- as.data.frame(grf[tb[,1]])
  out2 <- as.data.frame(grc[tb[,2]])
  ### for each genomic feature, find the sites with non-missing data
  out <- cbind(out1, out2[, "start"]) 
  names(out)[ncol(out)] <- "pos"
  #define unique identifier and merge with the thetas
  out$seq <- as.numeric(as.character(out$seqnames))
  out$Pos <- as.numeric(as.character(out$pos))
  theta$seq <- as.numeric(as.character(theta$seq))
  theta$Pos <- as.numeric(as.character(theta$Pos))
  t <- data.table(theta, key = c("seq", "Pos"))
  o <- data.table(out, key = c("seq", "Pos"))
  df <- merge(o, t)
  # for each region, how many theta values
#  k <- ddply(df, .(geneid), summarise,
#            Pairwise = mean(Pairwise, na.rm=TRUE),
#            theta = mean(Watterson, na.rm=TRUE))
  k <- ddply(df, .(geneid), summarise,
            Fst = mean(Fst, na.rm=TRUE))
}

#cds <- get_mean_theta(gp_cds)
#write.table(cds, "fst_cds_dv.dr.txt", row.names = FALSE)
#gene <- get_mean_theta(gp_gene)
#write.table(gene, "fst_gene_dv.dr.txt", row.names = FALSE)
#fivep <- get_mean_theta(gp_5p)
#write.table(fivep, "fst_5p_dv.dr.txt", row.names = FALSE)
#threep <- get_mean_theta(gp_3p)
#write.table(threep, "fst_3p_hy.dr.txt", row.names = FALSE)
#up <- get_mean_theta(gp_up)
#write.table(up, "fst_up_dv.dr.txt", row.names = FALSE)
down <- get_mean_theta(gp_down)
write.table(down, "fst_down_hy.dv.txt", row.names = FALSE)
