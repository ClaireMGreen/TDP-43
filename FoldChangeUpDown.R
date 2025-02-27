setwd("/users/clairegreen/Documents/PhD/TDP-43/TDP-43_Code/Results/GeneExpression/noMedian/")

C9 <- read.csv("C9_unique.csv")
C9 <- C9[order(C9$P.Value),]
# CH <- read.csv("CH_unique.csv")
# CH <- CH[order(CH$P.Value),]
sals <- read.csv("sals_unique.csv")
sals <- sals[order(sals$P.Value),]
ftld <- read.csv("ftld_unique.csv")
ftld <- ftld[order(ftld$P.Value),]
vcp <- read.csv("vcp_unique.csv")
vcp <- vcp[order(vcp$P.Value),]

setwd("/users/clairegreen/Documents/PhD/TDP-43/TDP-43_Code/Results/GeneExpression/TDP-43_DEseq2/")

pet <- read.csv("PET_results_keepfiltering.csv")
rav <- read.csv("RAV_results_keepfiltering.csv")




thresh <- 1

upC9 <- subset(C9, C9$Fold.Change >= thresh)
upC9gene <- upC9$Gene.Symbol

# upCH <- subset(CH, CH$Fold.Change >= thresh)
# upCHgene <- upCH$Gene.Symbol

upSALS <- subset(sals, sals$Fold.Change >= thresh)
upSALSgene <- upSALS$Gene.Symbol

upFTLD <- subset(ftld, ftld$Fold.Change >= thresh)
upFTLDgene <- upFTLD$Gene.Symbol

upVCP <- subset(vcp, vcp$Fold.Change >= thresh)
upVCPgene <- upVCP$Gene.Symbol

upPET <- subset(pet, pet$FoldChange >= thresh)
upPETgene <- upPET$hgnc_symbol

upRAV <- subset(rav, rav$FoldChange >= thresh)
upRAVgene <- upRAV$hgnc_symbol

INTUP_TDP <- Reduce(intersect, list(upC9gene, upSALSgene, upFTLDgene, upVCPgene, upPETgene, upRAVgene))

# cat(INTUP, sep = "\n")

# setwd("/Users/clairegreen/Documents/PhD/TDP-43/TDP-43_Code/Results/GeneExpression/FoldChangeResults")
# write.table(INTUP, "intersect_up_1.txt", col.names = F, row.names = F, quote = F)



#### DOWN ####
thresh <- -1

downC9 <- subset(C9, C9$Fold.Change <= thresh)
downC9gene <- downC9$Gene.Symbol

# downCH <- subset(CH, CH$Fold.Change <= thresh)
# downCHgene <- downCH$Gene.Symbol

downSALS <- subset(sals, sals$Fold.Change <= thresh)
downSALSgene <- downSALS$Gene.Symbol

downFTLD <- subset(ftld, ftld$Fold.Change <= thresh)
downFTLDgene <- downFTLD$Gene.Symbol

downVCP <- subset(vcp, vcp$Fold.Change <= thresh)
downVCPgene <- downVCP$Gene.Symbol

downPET <- subset(pet, pet$FoldChange <= thresh)
downPETgene <- downPET$hgnc_symbol

downRAV <- subset(rav, rav$FoldChange <= thresh)
downRAVgene <- downRAV$hgnc_symbol

INTDOWN_TDP <- Reduce(intersect, list(downC9gene, downSALSgene, downFTLDgene, downVCPgene, downPETgene, downRAVgene))

# setwd("/Users/clairegreen/Documents/PhD/TDP-43/TDP-43_Code/Results/GeneExpression/FoldChangeResults")
# write.table(INTDOWN, "intersect_down_1.txt", col.names = F, row.names = F, quote = F)

# cat(INTDOWN, sep = "\n")
# 
# upC9FC <- data.frame(row.names = upC9$Gene.Symbol, 
#                      logFC = upC9$logFC)
# upC9FC <- order(upC9FC[row.names(upC9FC),])
# upsalsFC <- data.frame(row.names = upSALS$Gene.Symbol, 
#                      logFC = upSALS$logFC)
# upftldFC <- data.frame(row.names = upFTLD$Gene.Symbol, 
#                      logFC = upFTLD$logFC)
# upvcpFC <- data.frame(row.names = upVCP$Gene.Symbol, 
#                      logFC = upVCP$logFC)
# uppetFC <- data.frame(row.names = upPET$hgnc_symbol, 
#                      logFC = upPET$log2FoldChange)
# upravFC <- data.frame(row.names = upRAV$hgnc_symbol, 
#                      logFC = upRAV$log2FoldChange)
# 
# 


############################################################################
################### NON-TDP ALS ############################################
############################################################################

setwd("/users/clairegreen/Documents/PhD/TDP-43/TDP-43_Code/Results/GeneExpression/non-TDP/")

FUS <- read.csv("FUSrankeduniqueresult.csv")
FUS <- FUS[order(FUS$P.Value),]
SOD1 <- read.csv("SOD1rankeduniqueresult.csv")
SOD1 <- SOD1[order(SOD1$P.Value),]
# CBFTLD <- read.csv("CBFTLDrankeduniqueresult.csv")
# CBFTLD <- CBFTLD[order(CBFTLD$P.Value),]

#### UP ####
thresh <- 1

upFUS <- subset(FUS, FUS$Fold.Change >= thresh)
upFUSgene <- upFUS$Gene.Symbol

# upCBFTLD <- subset(CBFTLD, CBFTLD$Fold.Change >= thresh)
# upCBFTLDgene <- upCBFTLD$Gene.Symbol

upSOD1 <- subset(SOD1, SOD1$Fold.Change >= thresh)
upSOD1gene <- upSOD1$Gene.Symbol

INTUP_non <- Reduce(intersect, list(upSOD1gene, upFUSgene))

#### DOWN ####
thresh <- -1

downFUS <- subset(FUS, FUS$Fold.Change <= thresh)
downFUSgene <- downFUS$Gene.Symbol

downSOD1 <- subset(SOD1, SOD1$Fold.Change <= thresh)
downSOD1gene <- downSOD1$Gene.Symbol

# downCBFTLD <- subset(CBFTLD, CBFTLD$Fold.Change <= thresh)
# downCBFTLDgene <- downCBFTLD$Gene.Symbol

INTDOWN_non <- Reduce(intersect, list(downSOD1gene, downFUSgene))



########################### COMMON GENES ##############################
upremove <- Reduce(intersect, list (INTUP_TDP, INTUP_non))
downremove <- Reduce(intersect, list(INTDOWN_TDP, INTDOWN_non))



################ REMOVE COMMON GENES ######################
resultsup <- subset(INTUP_TDP, !(INTUP_TDP %in% upremove))
resultsdown <- subset(INTDOWN_TDP, !(INTDOWN_TDP %in% downremove))
results <- c(resultsup, resultsdown)

# setwd("/users/clairegreen/Documents/PhD/TDP-43/TDP-43_Code/Results/GeneExpression/FoldChangeResults/")
# write.table(resultsup, "Filtered_up_genes_cbftld.txt", quote = F, row.names = F, col.names = F)
# write.table(resultsdown, "Filtered_down_genes_cbftld.txt", quote = F, row.names = F, col.names = F)
# 
# cat(resultsup, sep="\n")
