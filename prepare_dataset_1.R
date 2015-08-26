## R script to convert FCS data files for benchmark data set 1 in PhenoGraph paper 
## (Levine et al, 2015) into tab-delimited text format with manually gated cluster labels
##
## Lukas Weber, Aug 2015
##
## Reference:
## ----------
## Levine et al., (2015). "Data-Driven Phenotypic Dissection of AML Reveals 
## Progenitor-like Cells that Correlate with Prognosis." Cell, 162, pp. 184-197. 
## http://www.sciencedirect.com/science/article/pii/S0092867415006376
##
## Data source:
## ------------
## Cytobank experiment page:
## https://www.cytobank.org/cytobank/experiments/46259


# Install "flowCore" package from Bioconductor if not already installed
#source("http://bioconductor.org/biocLite.R")
#biocLite("flowCore")


# Download files

# download FCS files manually from https://www.cytobank.org/cytobank/experiments/46259
# and save in directory named "FCS_files_dataset_1" (there should be 25 FCS files)


# FCS filenames

files <- list.files("FCS_files_dataset_1", pattern = "\\.fcs$", full.names = TRUE)
files_gated <- files[-grep("NotGated", files)]
files_notgated <- files[grep("NotGated", files)]

files_gated  # check
files_notgated


# Read FCS files for the 24 manually gated clusters and add cluster labels

library(magrittr)
library(flowCore)

cols <- files_gated[1] %>% 
  read.FCS(., transformation = FALSE) %>% 
  exprs %>% 
  colnames %>% 
  unname %>% 
  c(., "cluster")

cols  # check

res <- data.frame()

for (i in seq_along(files_gated)) {
  data <- exprs(read.FCS(files_gated[i], transformation = FALSE))
  data <- cbind(data, cluster = i)
  if (!all(colnames(data) == cols)) stop("column names do not match")
  res <- rbind(res, data)
}

# Save in tab-delimited text format

file_out <- "processed_data/benchmark_dataset_1.txt"
write.table(res, file = file_out, row.names = FALSE, quote = FALSE, sep = "\t")


# Read FCS file for the ungated test data set

data_notgated <- exprs(read.FCS(files_notgated, transformation = FALSE))
if (!all(colnames(data_notgated) == cols[-length(cols)])) stop("column names do not match")

# Save in tab-delimited text format

file_out_notgated <- "processed_data/benchmark_dataset_1_notgated.txt"
write.table(data_notgated, file = file_out_notgated, 
            row.names = FALSE, quote = FALSE, sep = "\t")

