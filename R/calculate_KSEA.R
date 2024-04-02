#' Calculate Kinase Substrate Enrichment Analysis (KSEA)
#'
#' Performs KSEA by merging kinase-substrate data with experimental data,
#' computing average log2 fold change (log2FC) for each kinase, and calculating
#' enrichment scores, z-scores, p-values, and false discovery rates (FDR).
#'
#' @param KS_filtered The filtered kinase-substrate dataset.
#' @param experimental_data The experimental dataset containing log2 fold change values.
#'
#' @return A data frame containing the KSEA results for each kinase, including
#'         enrichment scores, z-scores, p-values, and FDR.
#' @export
calculate_KSEA <- function(KS_filtered, experimental_data) {
  # Merge kinase-substrate data with experimental data
  merged_data <- merge(KS_filtered, experimental_data)
  
  # Calculate the average log2FC for each kinase
  kinase_log2FC <- aggregate(log2FC ~ GENE, data = merged_data, FUN = mean)
  
  # Calculate the global mean and standard deviation of log2FC
  global_mean_log2FC <- mean(experimental_data$log2FC, na.rm = TRUE)
  global_sd_log2FC <- sd(experimental_data$log2FC, na.rm = TRUE)
  
  # Determine the substrate count (m) for each kinase
  kinase_list <- table(merged_data$GENE)
  
  # Calculate m (the number of substrates) for each kinase
  kinase_log2FC$m <- kinase_list[kinase_log2FC$GENE]
  
  # Calculate mS (the product of m and average log2FC) for each kinase
  kinase_log2FC$mS <- kinase_log2FC$m * kinase_log2FC$log2FC
  
  # Calculate the enrichment score for each kinase
  kinase_log2FC$Enrichment <- kinase_log2FC$log2FC / abs(global_mean_log2FC)
  
  # Calculate the z-score for each kinase
  kinase_log2FC$z.score <- (kinase_log2FC$log2FC - global_mean_log2FC) * sqrt(kinase_log2FC$m) / global_sd_log2FC
  
  # Calculate the p-value for each kinase
  kinase_log2FC$p.value <- pnorm(-abs(kinase_log2FC$z.score), lower.tail = TRUE)
  
  # Calculate the false discovery rate (FDR) based on the z-score
  kinase_log2FC$FDR <- p.adjust(kinase_log2FC$p.value, method = "fdr")
  
  return(kinase_log2FC)
}
