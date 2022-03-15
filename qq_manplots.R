#Name: Pauline King'ori
#Date: March 2020
#Title: Annotating qq and manhattan plots

#install and load package
install.packages("qqman")
library(qqman)
#The qqman package includes functions for creating manhattan plots and q-q plots from GWAS results.
str(gwasResults) #inbuilt dataframe simulating results for 16,470 SNPs on 22 chromosomes
head(gwasResults)


#number of SNPs on each chromosome
as.data.frame(table(gwasResults$CHR))

#create manhattan plots
manhattan(gwasResults)
manhattan(gwasResults, main = "Manhattan Plot", cex = 0.5, cex.axis = 0.8)

par("mar")
par(mar=c(1,1,1,1))

#change the colors and increase the maximum y-axis
manhattan(gwasResults, col = c("blue4", "orange3"), ymax = 12)
manhattan(gwasResults, suggestiveline = F, genomewideline = F)


#zoom into single chromosome
manhattan(subset(gwasResults, CHR == 1))
manhattan(subset(gwasResults, CHR == 3))

#highlight some SNPs of interest on chromosome
str(snpsOfInterest)
manhattan(gwasResults, highlight = snpsOfInterest)

#We can combine highlighting and limiting to a single chromosome, and use the xlim graphical parameter to zoom in
#on a region of interest (between position 200-500)
manhattan(subset(gwasResults, CHR == 3), highlight = snpsOfInterest, xlim = c(200, 500), main = "Chr 3")
manhattan(gwasResults, annotatePval = 0.01)

#annotate all SNPs that meet a threshold
manhattan(gwasResults, annotatePval = 0.005, annotateTop = FALSE)

# Add test statistics
gwasResults <- transform(gwasResults, zscore = qnorm(P/2, lower.tail = FALSE))
head(gwasResults)

# Make the new plot
manhattan(gwasResults, p = "zscore", logp = FALSE, ylab = "Z-score", genomewideline = FALSE, 
          suggestiveline = FALSE, main = "Manhattan plot of Z-scores")
