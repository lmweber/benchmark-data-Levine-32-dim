## R script to prepare benchmark data set 2 from PhenoGraph paper (Levine et al, 2015)
##
## converts FCS data files to text format, applies asinh transform, and adds cluster 
## labels for the manually gated clusters
##
## note benchmark data set 2 contains cells from two individuals, H1 and H2
##
## Lukas Weber, Aug 2015
##
##
## Reference:
## ----------
## Levine et al., (2015). "Data-Driven Phenotypic Dissection of AML Reveals 
## Progenitor-like Cells that Correlate with Prognosis." Cell, 162, pp. 184-197. 
## http://www.sciencedirect.com/science/article/pii/S0092867415006376
##
## Cytobank experiment pages with FCS data files:
## Benchmark data set 1: https://www.cytobank.org/cytobank/experiments/46259
## Benchmark data set 2: https://www.cytobank.org/cytobank/experiments/46102


# Install "flowCore" package from Bioconductor if not already installed
#source("http://bioconductor.org/biocLite.R")
#biocLite("flowCore")


# Download FCS files

# download FCS files manually from https://www.cytobank.org/cytobank/experiments/46102 
# (download from the "attachments" section) and save in directory "FCS_files_dataset_2"
# (there should be 30 FCS files - 15 for each individual, H1 and H2)


# FCS filenames (two individuals, H1 and H2)

files_H1 <- list.files("FCS_files_dataset_2", pattern = "H1\\.fcs$", full.names = TRUE)
files_H1_gated <- files_H1[-grep("NotDebrisSinglets", files_H1)]
files_H1_unassigned <- files_H1[grep("NotDebrisSinglets", files_H1)]

files_H2 <- list.files("FCS_files_dataset_2", pattern = "H2\\.fcs$", full.names = TRUE)
files_H2_gated <- files_H2[-grep("NotDebrisSinglets", files_H2)]
files_H2_unassigned <- files_H2[grep("NotDebrisSinglets", files_H2)]


# Read FCS files for the 14 manually gated clusters for each individual (one FCS file per
# cluster per individual), apply asinh transform, add cluster labels, and save in
# tab-delimited text format
# ---------------------------------------------------------------------------------------

library(magrittr)  # install from CRAN with install.packages() if required
library(flowCore)  # install from Bioconductor (see above)

# column names

cols <- files_H1[1] %>% 
  read.FCS(., transformation = FALSE) %>% 
  exprs %>% 
  colnames %>% 
  unname

cols <- cols[5:36]
cols  # check

# read FCS files

data_H1 <- data_H2 <- matrix(nrow = 0, ncol = length(cols))
labels_H1 <- labels_H2 <- vector()

for (i in seq_along(files_H1_gated)) {
  data_H1_i <- exprs(read.FCS(files_H1_gated[i], transformation = FALSE))
  if (!all(cols %in% colnames(data_H1_i))) stop("column names do not match")
  data_H1_i <- data_H1_i[, cols]
  data_H1 <- rbind(data_H1, data_H1_i)
  labels_H1_i <- rep(i, nrow(data_H1_i))
  labels_H1 <- c(labels_H1, labels_H1_i)
  
  data_H2_i <- exprs(read.FCS(files_H2_gated[i], transformation = FALSE))
  if (!all(cols %in% colnames(data_H2_i))) stop("column names do not match")
  data_H2_i <- data_H2_i[, cols]
  data_H2 <- rbind(data_H2, data_H2_i)
  labels_H2_i <- rep(i, nrow(data_H2_i))
  labels_H2 <- c(labels_H2, labels_H2_i)
}

dim(data_H1)
dim(data_H2)

# apply asinh transform

asinh_scale <- 5
data_H1_scaled <- asinh(data_H1 / asinh_scale)
data_H2_scaled <- asinh(data_H2 / asinh_scale)

# save as text files

res_H1_notransform <- cbind(data_H1, labels = labels_H1)
res_H2_notransform <- cbind(data_H2, labels = labels_H2)
res_H1_scaled <- cbind(data_H1_scaled, labels = labels_H1)
res_H2_scaled <- cbind(data_H2_scaled, labels = labels_H2)

file_out_H1_notransform <- 
  "processed_data/dataset_2/benchmark_dataset_2_H1_notransform.txt"
file_out_H2_notransform <- 
  "processed_data/dataset_2/benchmark_dataset_2_H2_notransform.txt"
file_out_H1_scaled <- 
  "processed_data/dataset_2/benchmark_dataset_2_H1.txt"
file_out_H2_scaled <- 
  "processed_data/dataset_2/benchmark_dataset_2_H2.txt"

write.table(res_H1_notransform, file = file_out_H1_notransform, 
            row.names = FALSE, quote = FALSE, sep = "\t")
write.table(res_H2_notransform, file = file_out_H2_notransform, 
            row.names = FALSE, quote = FALSE, sep = "\t")
write.table(res_H1_scaled, file = file_out_H1_scaled, 
            row.names = FALSE, quote = FALSE, sep = "\t")
write.table(res_H2_scaled, file = file_out_H2_scaled, 
            row.names = FALSE, quote = FALSE, sep = "\t")


# Read FCS file for unassigned cells (no cluster labels available) for each individual, 
# apply asinh transform, and save in tab-delimited text format
# -------------------------------------------------------------------------------------

data_H1_unassigned <- exprs(read.FCS(files_H1_unassigned, transformation = FALSE))
if (!all(cols %in% colnames(data_H1_unassigned))) stop("column names do not match")
data_H1_unassigned <- data_H1_unassigned[, cols]

data_H2_unassigned <- exprs(read.FCS(files_H2_unassigned, transformation = FALSE))
if (!all(cols %in% colnames(data_H2_unassigned))) stop("column names do not match")
data_H2_unassigned <- data_H2_unassigned[, cols]

dim(data_H1_unassigned)
dim(data_H2_unassigned)

data_H1_unassigned_scaled <- asinh(data_H1_unassigned / asinh_scale)
data_H2_unassigned_scaled <- asinh(data_H2_unassigned / asinh_scale)

file_out_H1_unassigned_notransform <- 
  "processed_data/dataset_2/benchmark_dataset_2_H1_unassigned_notransform.txt"
file_out_H2_unassigned_notransform <- 
  "processed_data/dataset_2/benchmark_dataset_2_H2_unassigned_notransform.txt"
file_out_H1_unassigned_scaled <- 
  "processed_data/dataset_2/benchmark_dataset_2_H1_unassigned.txt"
file_out_H2_unassigned_scaled <- 
  "processed_data/dataset_2/benchmark_dataset_2_H2_unassigned.txt"

write.table(data_H1_unassigned, file = file_out_H1_unassigned_notransform, 
            row.names = FALSE, quote = FALSE, sep = "\t")
write.table(data_H2_unassigned, file = file_out_H2_unassigned_notransform, 
            row.names = FALSE, quote = FALSE, sep = "\t")
write.table(data_H1_unassigned_scaled, file = file_out_H1_unassigned_scaled, 
            row.names = FALSE, quote = FALSE, sep = "\t")
write.table(data_H2_unassigned_scaled, file = file_out_H2_unassigned_scaled, 
            row.names = FALSE, quote = FALSE, sep = "\t")

