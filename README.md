CyTOF benchmark data sets from Levine et al (2015)
==================================================

This repository contains R code to prepare two manually gated benchmark data sets from the PhenoGraph paper (Levine et al, 2015) into a tab-delimited text format with cluster labels added.

If you use these data sets, please cite the PhenoGraph paper. These are very useful data sets, and we would like to ensure that the authors receive credit and thank them for making the data publicly available:

- Levine et al., (2015). *Data-Driven Phenotypic Dissection of AML Reveals Progenitor-like Cells that Correlate with Prognosis.* Cell, 162, pp. 184-197. http://www.sciencedirect.com/science/article/pii/S0092867415006376



## Contents

This repository contains the following files, which are explained in more detail below.

- [prepare_dataset_1.R](prepare_dataset_1.R): R script to prepare benchmark data set 1
- [prepare_dataset_2.R](prepare_dataset_2.R): R script to prepare benchmark data set 2
- [processed_data](processed_data/): folder with processed data files in tab-delimited text format, with cluster labels added where available. Files are provided with and without a standard `asinh` transform applied (see below for details on the individual files).



## Background

CyTOF or mass cytometry is a recent advance in flow cytometry, which allows single cells to be characterized by measuring the expression levels of around 30-40 surface protein markers and intracellular signaling proteins. Thousands of cells can be measured per second, resulting in data sets with hundreds of thousands of cells and up to 30-40 dimensions. Analysis of CyTOF data sets often involves searching for clusters representing distinct cell populations, and comparing the sets of cell populations between samples or patients.

PhenoGraph is a powerful new graph-based algorithm for detecting clusters or communities in CyTOF data. The algorithm was introduced in the Levine et al (2015) paper.

The Levine et al (2015) paper also included several data sets from acute myeloid leukemia (AML) patients and healthy controls, which the authors used to study the biology of AML and demonstrate the performance of the PhenoGraph algorithm.



## Benchmark data sets in PhenoGraph paper

The PhenoGraph paper includes two benchmark data sets, consisting of manually gated mass cytometry data from healthy bone marrow mononuclear cells (BMMC), from three healthy individuals. The benchmark data sets are used in Figures 2A-B, S2A-C, and Data S1A-F (benchmark data set 1); and Figure S2D and Data S1G-I (benchmark data set 2) in the paper.

"Manual gating" refers to the traditional flow cytometry analysis technique of visually searching for clusters or regions of high density in a series of two-dimensional scatter plots. While expert manual gating is quite reliable in low-dimensional flow cytometry data sets, it quickly becomes unwieldy in higher-dimensional CyTOF data sets. Algorithms such as PhenoGraph aim to discover clusters automatically. However, this is also computationally difficult due to the "curse of dimensionality".

We believe these benchmark data sets will be very useful for testing high-dimensional (in the order of 10-100 dimensions) clustering algorithms.

The data sets were made publicly available through the [Cytobank](https://www.cytobank.org/) platform (see links below). The files are saved in Flow Cytometry Standard (FCS) binary file format, which is the most commonly used file format in the flow and mass cytometry community. However, since it is a binary format, specialized software tools are required to read the files, making them difficult to access for users from other fields.

In this repository, we provide R code to read the FCS files from these benchmark data sets, convert the data to tab-delimited text format, and add cluster labels from the manual gating in the PhenoGraph paper. We use the [flowCore](http://bioconductor.org/packages/release/bioc/html/flowCore.html) R/Bioconductor package to read the FCS files. Our aim is to make these data sets accessible to users unfamiliar with the FCS file format, so they can be used to test high-dimensional clustering algorithms.



## Benchmark data set 1

The first benchmark data set contains manually gated healthy bone marrow mononuclear cell (BMMC) data from one healthy individual, with 13 surface markers measured. The surface markers are: CD45, CD45RA, CD19, CD11b, CD4, CD8, CD34, CD20, CD33, CD123, CD38, CD90, and CD3.

This data set has relatively low dimensionality. No intracellular signaling proteins were measured.

Manual gating was performed on all 13 surface markers. An additional "DNA x cell length" gating step was also applied to remove platelets. A total of 24 cell types were found by manual gating. The final data set contained 167,044 cells (see https://www.cytobank.org/cytobank/experiments/46259).

Of the 167,044 cells, around 49% (81,747 cells) were assigned to one of the 24 cell types by the manual gating. The remaining 51% (85,297 cells) were not assigned to any cell type. Therefore, the benchmark data set was split into two parts. The first part is the "gold standard" data set, which contains the 49% of cells that were assigned to cell types by manual gating. The second part (51%) contains the unassigned cells, which are retained as a test data set. Since both parts are sourced from the same biological sample, similar clusters should exist in the test data set, although some additional unknown cell types may also be present. (See Levine et al, 2015, Supplemental Experimental Procedures, for more details.)


**Data source:**

- The FCS data files can be downloaded from the Cytobank experiment page for benchmark data set 1: https://www.cytobank.org/cytobank/experiments/46259.

    The data are provided as a set of 24 FCS files for the gold standard data set (one FCS file per cluster), and one additional combined FCS file for the test data set. Note that cluster labels are not available for the cells in the test data set.


**Files in this repository:**

- The R script [prepare_dataset_1.R](prepare_dataset_1.R) reads the FCS files, adds cluster labels for the 24 manually gated clusters, applies a standard `asinh` transform, and saves the data in tab-delimited text format.

- The [processed_data](processed_data/) folder contains the final tab-delimited text files.

    - [benchmark_dataset_1.txt](processed_data/benchmark_dataset_1.txt) contains the data from the 24 manually gated clusters in the gold standard data set (49% of the total data set), with `asinh` transform applied, and cluster labels added. [benchmark_dataset_1_notransform.txt](processed_data/benchmark_dataset_1_notransform.txt) contains the same data without the `asinh` transform.
    
    - [benchmark_dataset_1_unassigned.txt](processed_data/benchmark_dataset_1_unassigned.txt) contains the unassigned cells in the test data set (51% of the total data set), with `asinh` transform applied. Cluster labels are not available here, since these cells were not assigned to any cell types by the manual gating. [benchmark_dataset_1_unassigned_notransform.txt](processed_data/benchmark_dataset_1_unassigned_notransform.txt) contains the same data without the `asinh` transform.


**Original reference:**

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

This includes links to the paper and related data sets, including the benchmark data sets used here. The data were published in FCS format on [Cytobank](https://www.cytobank.org/). Note that a (free) Cytobank account is required to access the Cytobank links.

- Cytobank project page (contains links to all data sets from the PhenoGraph paper): https://www.cytobank.org/cytobank/experiments?project=750

- Cytobank experiment page for benchmark data set 1: https://www.cytobank.org/cytobank/experiments/46259

- Cytobank experiment page for benchmark data set 2: https://www.cytobank.org/cytobank/experiments/46102

- Link to PhenoGraph paper: http://www.sciencedirect.com/science/article/pii/S0092867415006376 or http://www.ncbi.nlm.nih.gov/pubmed/26095251


