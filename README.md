Clustering benchmark data: 32-dimensional data set from Levine et al. (2015)
============================================================================

This repository contains R code to prepare benchmark data set `Levine_2015_marrow_32`, which can be used to test clustering algorithms.

The data set is a 32-dimensional mass cytometry data set, consisting of protein expression levels for `n = 265,627` cells, `p = 32` protein markers (dimensions), and `k = 14` manually gated cell populations (clusters), from `h = 2` individuals. Cluster labels are available for 39% (104,184) of the cells. For more details see below.

The repository [benchmark-data-Levine-13-dim](https://github.com/lmweber/benchmark-data-Levine-13-dim) contains R code to prepare a second benchmark data set with lower dimensionality (13 dimensions).

The data set is sourced from the following paper:

- Levine et al. (2015). *Data-Driven Phenotypic Dissection of AML Reveals Progenitor-like Cells that Correlate with Prognosis.* Cell, 162, pp. 184-197. [http://www.sciencedirect.com/science/article/pii/S0092867415006376](http://www.sciencedirect.com/science/article/pii/S0092867415006376)

Raw data can be accessed through Cytobank:

- 13-dimensional benchmark data set: [https://www.cytobank.org/cytobank/experiments/46259](https://www.cytobank.org/cytobank/experiments/46259)
- 32-dimensional benchmark data set: [https://www.cytobank.org/cytobank/experiments/46102](https://www.cytobank.org/cytobank/experiments/46102)

If you use these data sets, please reference the paper by Levine et al. (2015).




## Background


### Mass cytometry

Mass cytometry (also known as CyTOF) is a new technology for high-throughput single-cell analysis, similar to flow cytometry but measuring a greater number of parameters per cell.

As in flow cytometry, data sets consist of expression levels of a set of protein markers for each cell. Currently, mass cytometry systems can measure hundreds of cells per second, and around 40 protein expression levels per cell. Typical data sets contain hundreds of thousands of cells per sample.

Protein expression levels can be used to characterize cell types, known as populations, and functional states. Applications of mass cytometry often involve analysis of cell populations — for example, detecting certain cell populations such as known disease biomarkers, or detecting cell populations in specific functional states, or comparing proportions of populations between samples.

Flow cytometry data has traditionally been analyzed by "gating", which refers to visually searching for clusters or regions of high density in a series of two-dimensional scatter plots. While this works well for low-dimensional flow cytometry data, it quickly becomes unreliable and unwieldy in higher-dimensional data sets. To address this, several research groups have recently developed algorithms for automated detection of cell populations.



### Levine et al. (2015) paper

Levine et al. (2015) (reference and link above) introduced PhenoGraph, a new graph-based algorithm for detecting clusters in high-dimensional mass cytometry data, and used it to study phenotypic and functional heterogeneity of cells from patients with acute myeloid leukemia (AML).

In their paper, Levine et al. used two benchmark data sets of healthy human bone marrow cells to demonstrate the performance of PhenoGraph. Healthy human bone marrow cells contain many well-characterized immune cell populations, and the evaluations showed that PhenoGraph was able to correctly identify these.

The data sets are used in Figures 2A-B, S2A-C, and Data S1A-F (13-dimensional data set), and Figure S2D and Data S1G-I (32-dimensional data set) in their paper.

Levine et al. have made these data sets publicly available, and we have found them to be very useful data sets for testing high-dimensional clustering algorithms.



### 13-dimensional benchmark data set

The first benchmark data set is a 13-dimensional mass cytometry data set, consisting of protein expression levels from healthy human bone marrow mononuclear cells (BMMCs) from one healthy individual. (This data set is referred to as "benchmark data set 1" in Levine et al. 2015).

This data set contains `n = 167,044` cells. The dimensionality is `p = 13` protein markers, all of which are surface proteins. Manually gated cell population (cluster) labels for `k = 24` major immune cell populations are available for 49% (81,747) of the cells. The remaining 51% (85,297) of cells are labeled as "unassigned". All cells are from a single individual.

The 13 surface markers are: CD45, CD45RA, CD19, CD11b, CD4, CD8, CD34, CD20, CD33, CD123, CD38, CD90, and CD3. All 13 surface markers were used for determining cell population labels by gating. An additional "DNA * cell length" gating step was also applied to remove platelets. See Levine et al. (2015), Supplemental Experimental Procedures, for more details.



### 32-dimensional benchmark data set

The second benchmark data is a 32-dimensional mass cytometry data set, which consists of protein expression levels from healthy human BMMCs from two healthy individuals. (This data set is referred to as "benchmark data set 2" in Levine et al. 2015).

This data set contains `n = 265,627` cells. The dimensionality is `p = 32` surface protein markers. For this data set, manually gated cell population (cluster) labels are available for `k = 14` major immune cell populations (i.e. the clustering is coarser than for the first data set). Cluster labels are available for 39% (104,184) of the cells, with the remaining 61% (161,443) labeled as "unassigned". The cells are from two individuals labeled `H1` and `H2`. For individual H1, 72,463 cells were assigned to populations, and 118,888 cells were unassigned (total 191,351 cells). For individual H2, 31,721 cells were assigned to populations, and 42,555 cells were unassigned (total 74,276 cells).

19 of the 32 surface markers were used for manual gating. These 19 are: CD3, CD4, CD7, CD8, CD15, CD16, CD19, CD20, CD34, CD38, CD41, CD44, CD45, CD61, CD64, CD123, CD11c, CD235a/b, and HLA-DR. All 32 surface markers were used for automated detection of cell populations with PhenoGraph by Levine et al. (2015). See Levine et al., 2015, Supplemental Experimental Procedures, for more details.




## This repository


### Purpose

We have written R code to pre-process and export these benchmark data sets in standard text-based format, to make it easier for researchers from other fields to access them to test clustering algorithms. This repository contains R code for the 32-dimensional data set, and the companion repository [benchmark-data-Levine-13-dim](https://github.com/lmweber/benchmark-data-Levine-13-dim) contains code for the 13-dimensional data set.

The publicly available data files provided by Levine et al. (2015) through Cytobank are in FCS (Flow Cytometry Standard) format, with one FCS file per manually gated cell population (cluster). The FCS format is an efficient binary file format, which is effectively the standard in the flow cytometry community. However, it requires specialized software tools to access, making it relatively inaccessible for researchers from other disciplines.

In addition, an arcsinh transform is usually applied before performing gating or automated analysis on flow or mass cytometry data. This is similar to a log transform, but is better suited for flow and mass cytometry data due to the presence of very small or negative values. Typical scale factors for the arcsinh transform are 5 for mass cytometry data, and 150 for flow cytometry data.


### Steps

The R script in this repository performs the following steps:

- Load the FCS files
- Extract cell population names, protein marker names, and labels for each individual
- Extract cluster labels (one cluster per FCS file; "unassigned" cells are labeled "NA")
- Apply standard arcsinh transform (scale factor 5 for mass cytometry data)
- Export data in FCS and tab-delimited TXT format (separate files with/without arcsinh transform)


### Contents

The files in this repository are:

- [prepare_data_Levine_2015_marrow_32.R](prepare_data_Levine_2015_marrow_32.R): R script to load, pre-process, and export data files for the 32-dimensional benchmark data set ("Levine_2015_marrow_32")

- [population_names_Levine_2015_marrow_32.txt](data/population_names_Levine_2015_marrow_32.txt): cell population names for each of the 14 clusters

- FCS files in folder [data](data/): exported data files in FCS format
    - [Levine_2015_marrow_32.fcs](data/Levine_2015_marrow_32.fcs): main data file (transformed data, with cluster labels, and labels for each individual)
    - [Levine_2015_marrow_32_notransform.fcs](data/Levine_2015_marrow_32_notransform.fcs): without arcsinh transform

We have not included the exported TXT format files in this repository, since they are too large for a GitHub repository (>100 MB). If you need the data files in TXT format, either download the raw data files from Cytobank and run the R script from this repository, or use the R code below to directly load and convert the exported FCS files (change the filename as required):

```
# install flowCore package
source("https://bioconductor.org/biocLite.R")
biocLite("flowCore")

library(flowCore)

# load FCS file and save in TXT format
data <- flowCore::exprs(flowCore::read.FCS("Levine_2015_marrow_32.fcs", transformation = FALSE))

head(data)
dim(data)

write.table(data, file = "Levine_2015_marrow_32.txt", quote = FALSE, sep = "\t", row.names = FALSE)
```




## References and links

The benchmark data sets are sourced from the paper by Levine et al. (2015):

- Levine et al. (2015). *Data-Driven Phenotypic Dissection of AML Reveals Progenitor-like Cells that Correlate with Prognosis.* Cell, 162, pp. 184-197. [http://www.sciencedirect.com/science/article/pii/S0092867415006376](http://www.sciencedirect.com/science/article/pii/S0092867415006376)


Data from Levine et al. (2015) are publicly available through Cytobank at the following links. Note that a (free) Cytobank account is required.

- Project page (all data from Levine et al. 2015): [https://www.cytobank.org/cytobank/experiments?project=750](https://www.cytobank.org/cytobank/experiments?project=750)

- Experiment page for 13-dimensional benchmark data set: [https://www.cytobank.org/cytobank/experiments/46259](https://www.cytobank.org/cytobank/experiments/46259)

- Experiment page for 32-dimensional benchmark data set: [https://www.cytobank.org/cytobank/experiments/46102](https://www.cytobank.org/cytobank/experiments/46102)


Additional information can also be found on the Dana Pe'er lab web page, at: [http://www.c2b2.columbia.edu/danapeerlab/html/phenograph.html](http://www.c2b2.columbia.edu/danapeerlab/html/phenograph.html)


The 13-dimensional benchmark data set was originally published by Bendall et al. (2011):

- Bendall et al. (2011). *Single-cell mass cytometry of differential immune and drug responses across a human hematopoietic continuum.* Science, 332, pp. 687-696. [http://www.ncbi.nlm.nih.gov/pubmed/21551058](http://www.ncbi.nlm.nih.gov/pubmed/21551058) (data available through Cytobank at [http://reports.cytobank.org/1/v1](http://reports.cytobank.org/1/v1) or [https://www.cytobank.org/cytobank/experiments/6033/](https://www.cytobank.org/cytobank/experiments/6033/)).


