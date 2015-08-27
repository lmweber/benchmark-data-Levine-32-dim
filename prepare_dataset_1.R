## R script to prepare benchmark data set 1 from PhenoGraph paper (Levine et al, 2015)
##
## converts FCS data files to text format, applies asinh transform, and adds cluster 
## labels for the manually gated clusters
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

# download FCS files manually from https://www.cytobank.org/cytobank/experiments/46259
# and save in directory named "FCS_files_dataset_1" (there should be 25 FCS files)


# FCS filenames

files <- list.files("FCS_files_dataset_1", pattern = "\\.fcs$", full.names = TRUE)
files_gated <- files[-grep("NotGated", files)]
files_unassigned <- files[grep("NotGated", files)]

files_gated  # check
files_unassigned


# Read FCS files for the 24 manually gated clusters (one FCS file per cluster), apply 
# asinh transform, add cluster labels, and save in tab-delimited text format
# -----------------------------------------------------------------------------------

library(magrittr)  # install from CRAN with install.packages() if required
library(flowCore)  # install from Bioconductor (see above)

# column names

cols <- files_gated[1] %>% 
  read.FCS(., transformation = FALSE) %>% 
  exprs %>% 
  colnames %>% 
  unname

cols  # check

# read FCS files

data <- matrix(nrow = 0, ncol = length(cols))
labels <- vector()

for (i in seq_along(files_gated)) {
  data_i <- exprs(read.FCS(files_gated[i], transformation = FALSE))
  if (!all(colnames(data_i) == cols)) stop("column names do not match")
  labels_i <- rep(i, nrow(data_i))
  data <- rbind(data, data_i)
  labels <- c(labels, labels_i)
}

dim(data)

# apply asinh transform

asinh_scale <- 5
data_scaled <- asinh(data / asinh_scale)

# save as text files

res_notransform <- cbind(data, labels)
res_scaled <- cbind(data_scaled, labels)

file_out_notransform <- "processed_data/benchmark_dataset_1_notransform.txt"
file_out_scaled <- "processed_data/benchmark_dataset_1.txt"

write.table(res_notransform, file = file_out_notransform, 
            row.names = FALSE, quote = FALSE, sep = "\t")
write.table(res_scaled, file = file_out_scaled, 
            row.names = FALSE, quote = FALSE, sep = "\t")


# Read FCS file for unassigned cells (no cluster labels available), apply asinh
# transform, and save in tab-delimited text format
# -----------------------------------------------------------------------------

data_unassigned <- exprs(read.FCS(files_unassigned, transformation = FALSE))
if (!all(colnames(data_unassigned) == cols)) stop("column names do not match")

dim(data_unassigned)

data_unassigned_scaled <- asinh(data_unassigned / asinh_scale)

file_out_unassigned_notransform <- "processed_data/benchmark_dataset_1_unassigned_notransform.txt"
file_out_unassigned_scaled <- "processed_data/benchmark_dataset_1_unassigned.txt"

write.table(data_unassigned, file = file_out_unassigned_notransform, 
            row.names = FALSE, quote = FALSE, sep = "\t")
write.table(data_unassigned_scaled, file = file_out_unassigned_scaled, 
            row.names = FALSE, quote = FALSE, sep = "\t")


