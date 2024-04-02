# KSEAr

KSEAr is an R package developed as an adaptation of the [KSEA](https://github.com/casecpb/KSEA) Shiny app, originally created by [casecpb](https://github.com/casecpb).
This version has been transformed from a Shiny application into a set of R functions for batch processing, making it more suitable for automated workflows and large-scale analyses.

# Acknowledgments

We would like to acknowledge the original work done by [casecpb](https://github.com/casecpb) in the KSEA project. 
The source code and example data in KSEAr have been adapted from the KSEA Shiny app, and we are thankful to the original authors for their foundational contributions to the field.

# Key Modifications

- **Conversion to R Functions:** The original Shiny app interface has been restructured into R functions, allowing for direct and flexible scripting in R. This change facilitates batch processing and integration into automated data analysis pipelines.
- **Updated Visualization Style:** We have updated the visual presentation of the KSEA results, offering a more contemporary and insightful visualization approach that enhances the interpretability of the analysis.

# Purpose

KSEAr is designed to perform Kinase-Substrate Enrichment Analysis (KSEA) in a more programmatically accessible manner, making it easier to integrate KSEA into larger bioinformatics workflows and to perform the analysis on a larger scale.

# Purpose

KSEAr is designed to perform Kinase-Substrate Enrichment Analysis (KSEA) in a more programmatically accessible manner, making it easier to integrate KSEA into larger bioinformatics workflows and to perform the analysis on a larger scale.

# How to Install
```R
install.packages("ggplot2")# ggplot2 v3.5.0
install.packages("remotes")
remotes::install_github("Chuanping-Zhao/KSEAr")
```
# use
```R
rm(list = ls())
library(tidyverse)
library(KSEAr)

#loading data
files_input <- fs::dir_ls("inputfile",recurse = TRUE,glob = "*.csv")
input <-  map_dfr(files_input,read_csv)
result <- KSEA(input_data = input,#a dataframe
               networkin_score_cutoff = 1,# The filter score of networkin datsets(if selected)
               substrate_count_cutoff = 4,# The counts of substrate
               threshold_type = "fdr",# The threshold used: 'fdr' or 'p'
               threshold_cutoff = 0.05, The cutoff of 'fdr' or 'p' 
               dataset = "PSP_networkin")#datasets:'PSP_networkin' or 'PSP'
enrichresults <- result[[1]]#resulst
enrich_plot <- result[[2]]#plotting

```
![image](https://github.com/Chuanping-Zhao/KSEAr/assets/134377196/2b352f5e-142a-475d-a5d3-c49b6456a6b6)
