#' Kinase Substrate Enrichment Analysis (KSEA)
#'
#' Performs Kinase Substrate Enrichment Analysis (KSEA) to compare kinase activity
#' between control and drug-treated groups based on phosphorylation data. This analysis
#' includes the application of networkin score and substrate count cutoffs to filter
#' kinase-substrate pairs, followed by statistical filtering to identify significant changes.
#' The function outputs both the analysis result and the visualization plot.
#'
#' @param input_data The input dataset, expected to be a data frame containing the experimental data.
#' @param networkin_score_cutoff The cutoff for the networkin score used to filter kinase-substrate pairs.
#'        Higher values indicate more reliable results. Default is 1.
#' @param substrate_count_cutoff The cutoff for the number of substrates associated with a kinase.
#'        Only kinases with substrates count equal or greater than this cutoff will be considered. Default is 4.
#' @param threshold_type The statistical measure used for filtering results; "p" for p-value, "fdr" for false discovery rate.
#'        Default is "p".
#' @param threshold_cutoff The cutoff value for the selected statistical measure (p-value or FDR) to filter significant results.
#'        Default is 0.05.
#' @param dataset The kinase-substrate database to use, either "PSP_networkin" or "PSP". Default is "PSP_networkin".
#'
#' @return A list containing two elements:
#'         1. A data frame with the filtered kinase scores and additional information,
#'            including a marker indicating whether phosphorylation levels have increased or decreased.
#'         2. A ggplot object representing the KESA plot visualizing the analysis results.
#'
#' @examples
#' \dontrun{
#'   result <- KSEA(input_data = your_data,
#'                  networkin_score_cutoff = 1,
#'                  substrate_count_cutoff = 4,
#'                  threshold_type = "p",
#'                  threshold_cutoff = 0.05,
#'                  dataset = "PSP_networkin")
#' }
#' @importFrom dplyr filter mutate
#' @importFrom magrittr %>%
#' @export
KSEA <- function(
    input_data,
    networkin_score_cutoff = 1,
    substrate_count_cutoff = 4,
    threshold_type = "p",
    threshold_cutoff = 0.05,
    dataset = "PSP_networkin"
) {
  # Assuming Format_Check, format_KS_dataset, process_experimental_data, calculate_KSEA, KESA_plot
  # are defined elsewhere in the package

  # Check format of the input data
  Format_Check(input = input_data)

  # Format the kinase-substrate dataset based on selected database and networkin score cutoff
  ks_filtered <- format_KS_dataset(datasets = dataset,
                                   networkin_score_cutoff = networkin_score_cutoff)

  # Process experimental data
  processed_data <- process_experimental_data(experimental_data = input_data)

  # Calculate KSEA
  result <- calculate_KSEA(KS_filtered = ks_filtered, experimental_data = processed_data)

  # Filter results based on user-defined cutoffs and add phosphorylation status marker
  choice <- if (threshold_type == "p") "p.value" else "FDR"
  result_filtered <- result %>%
    filter(m >= substrate_count_cutoff, get(choice) < threshold_cutoff, z.score != 0) %>%
    mutate(sigmarker = ifelse(z.score < 0, "decreased phosphorylation", "increased phosphorylation"))

  # Generate plot
  Fig <- KESA_plot(x = result_filtered)

  return(list(result_filtered, Fig))
}
