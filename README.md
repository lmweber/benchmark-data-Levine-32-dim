CyTOF benchmark data sets from PhenoGraph paper
===============================================

This repository contains R code to prepare two manually gated benchmark data sets from the PhenoGraph paper (Levine et al, 2015) into a tab-delimited text format with cluster labels added.

If you use these data sets, please cite the PhenoGraph paper (citation below). These are very useful data sets and we would like to give the authors credit, and thank them for making the data sets publicly available.

- Levine et al., (2015). *Data-Driven Phenotypic Dissection of AML Reveals Progenitor-like Cells that Correlate with Prognosis.* Cell, 162, pp. 184-197. http://www.sciencedirect.com/science/article/pii/S0092867415006376



## Contents

This repository contains the following files, which are explained in more detail below.

- [prepare_dataset_1.R](prepare_dataset_1.R): R script to prepare benchmark data set 1
- [prepare_dataset_2.R](prepare_dataset_2.R): R script to prepare benchmark data set 2
- [processed_data](processed_data/) folder with the processed data files in tab-delimited text format, with cluster labels added where available (see below for details on the individual files)



## Background

CyTOF or mass cytometry is a recent advance in flow cytometry, which allows single cells to be characterized by measuring the expression levels of around 30-40 surface protein markers and intracellular signaling proteins. Thousands of cells can be measured per second, resulting in data sets with hundreds of thousands of cells and up to 30-40 dimensions. Analysis of CyTOF data sets often involves searching for clusters representing distinct cell populations, and comparing the sets of cell populations between samples or patients.

PhenoGraph is a powerful new graph-based algorithm for detecting clusters or communities in CyTOF data. The algorithm was introduced in the Levine et al (2015) paper.

The Levine et al (2015) paper also included several data sets from acute myeloid leukemia (AML) patients and healthy controls, which the authors used to study the biology of AML and demonstrate the performance of the PhenoGraph algorithm.



## PhenoGraph paper and benchmark data sets

The PhenoGraph paper includes two benchmark data sets, consisting of manually gated healthy bone marrow mononuclear cell (BMMC) mass cytometry data from three healthy individuals. The benchmark data sets are used in Figures 2A-B, S2A-C, and Data S1A-F (benchmark data set 1); and Figure S2D and Data S1G-I (benchmark data set 2) in the paper.

"Manual gating" refers to the traditional flow cytometry analysis technique of manually searching for clusters or regions of high density in a series of two-dimensional scatter plots. While expert manual gating is quite reliable in low-dimensional flow cytometry data sets, it quickly becomes unwieldy in higher-dimensional CyTOF data sets. Algorithms such as PhenoGraph aim to discover clusters automatically. However, this is also computationally difficult due to the "curse of dimensionality".

We believe these benchmark data sets will be very useful for testing high-dimensional (in the order of 10-100 dimensions) clustering algorithms.

The data sets were made publicly available through the [Cytobank](https://www.cytobank.org/) data repository and analysis platform (see links below). The files are saved in Flow Cytometry Standard (FCS) binary file format, which is the most commonly used file format in the flow and mass cytometry community. However, since it is a binary format, specialized software tools are required to read the files, making them difficult to access for users from other fields.

In this repository, we provide R code to access the FCS files from these benchmark data sets, and convert them to tab-delimited text format. We use the [flowCore](http://bioconductor.org/packages/release/bioc/html/flowCore.html) R/Bioconductor package to read the files, and add cluster labels from the manual gating in the PhenoGraph paper. Our aim is to make these data sets accessible to users unfamiliar with the FCS file format, so that they can be used to test high-dimensional clustering algorithms.



## Benchmark data set 1

The first benchmark data set contains manually gated healthy bone marrow mononuclear cell (BMMC) data from one healthy individual, with 13 surface markers measured. The surface markers are: CD45, CD45RA, CD19, CD11b, CD4, CD8, CD34, CD20, CD33, CD123, CD38, CD90, and CD3.

This data set has relatively low dimensionality. No intracellular signaling proteins were measured.

Manual gating was performed on all 13 surface markers. An additional "DNA x cell length" gating step was also applied to remove platelets from the data set. A total of 24 cell types were found by manual gating. The final data set contained 167,044 cells (see https://www.cytobank.org/cytobank/experiments/46259).

For the benchmark data set, the data were also split into two parts. For 49% of the cells (81,747 cells), manual gating cluster assignments were kept, to produce a "gold standard" data set. For the remaining 51% of cells (85,297 cells), gating assignments were removed in order to create a test data set.

The data are provided as a set of 24 FCS files for the gold standard data set (one FCS file per cluster), and one additional combined FCS file for the test data set. Note that cluster labels are not available for the cells in the test data set.


**Source for FCS data files:**

- The FCS data files can be downloaded from the Cytobank experiment page for benchmark data set 1: https://www.cytobank.org/cytobank/experiments/46259. A total of 24 FCS files are provided for the manually gated clusters in the gold standard data set (one file per cluster or cell type), and one additional FCS file for the test data set (see above).


**Files in this repository:**

- The R script [prepare_dataset_1.R](prepare_dataset_1.R) reads the FCS files, adds cluster labels for the 24 manually gated clusters in the gold standard data set, and saves the data in tab-delimited text format.

- The [processed_data](processed_data/) folder contains the final tab-delimited text files. [benchmark_dataset_1.txt](processed_data/benchmark_dataset_1.txt) contains the data from the 24 manually gated clusters in the gold standard data (49% of the total data set), with cluster labels added. [benchmark_dataset_1_notgated.txt](processed_data/benchmark_dataset_1_notgated.txt) contains the nongated test data (51% of the total data set), where cluster labels are not available. The nongated part of the data set can be used as test data since it is sourced from the same biological sample, so the same clusters or cell types should be present.


**Original source:**

This data set was originally published in the following paper (Bendall et al, 2011), however the version of the data published with the PhenoGraph paper includes additional processing steps.

- Bendall et al., (2011). *Single-cell mass cytometry of differential immune and drug responses across a human hematopoietic continuum.* Science, 332, pp. 687-696. http://www.ncbi.nlm.nih.gov/pubmed/21551058 (data available at http://reports.cytobank.org/1/v1 or https://www.cytobank.org/cytobank/experiments/6033).



## Benchmark data set 2

The second benchmark data set

two individuals

how many dimensions/markers

both surface markers and intracellular signaling proteins

different protein panel than in benchmark data set 1

benchmark-data-set-2-h1

benchmark-data-set-2-h2



## More information

Further details can be found on the PhenoGraph page on the Dana Pe'er lab web page: http://www.c2b2.columbia.edu/danapeerlab/html/phenograph.html

This includes links to the paper and related data sets, including the benchmark data sets. The data were published in FCS format on [Cytobank](https://www.cytobank.org/). Note that a (free) Cytobank account is required to access the Cytobank links.

- Cytobank project page (contains links to all data sets from the PhenoGraph paper): https://www.cytobank.org/cytobank/experiments?project=750

- Cytobank experiment page for benchmark data set 1: https://www.cytobank.org/cytobank/experiments/46259

- Cytobank experiment page for benchmark data set 2: https://www.cytobank.org/cytobank/experiments/46102

- Link to PhenoGraph paper: http://www.sciencedirect.com/science/article/pii/S0092867415006376 or http://www.ncbi.nlm.nih.gov/pubmed/26095251


