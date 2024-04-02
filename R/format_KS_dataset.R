#' Format Kinase-Substrate Dataset
#'
#' Loads and formats kinase-substrate datasets based on the specified source and score cutoff.
#' Supports loading from `PhosphoSitePlus` and `PhosphoSitePlus+networkin` datasets.
#'
#' @param datasets The source of the kinase-substrate data, either "PSP" for PhosphoSitePlus
#'                 or "PSP_networkin" for PhosphoSitePlus combined with networkin. Default is "PSP_networkin".
#' @param networkin_score_cutoff The cutoff for the networkin score used to filter the data.
#'                 Only entries with a networkin score above this threshold will be included.
#'                 Default is 2. The minimum allowed value is 1.
#'
#' @return A filtered data frame containing the kinase-substrate interactions from the specified source.
#' @importFrom dplyr filter %>%
#' @export
format_KS_dataset <- function(datasets = "PSP_networkin", networkin_score_cutoff = 2) {
  # Load the datasets
  # files <- fs::dir_ls("datasets", recurse = TRUE, glob = "*.rds")
  # files_names <- str_extract(files, "(?<=\\/).*(?=\\.)")
  # KS.all <- map_dfr(files, readRDS)
  KS.all <- kinase_substrate_data()

  # Ensure the score cutoff is not below the minimum value
  if (networkin_score_cutoff < 1) {
    stop("The minimum value for networkin_score_cutoff is 1")
  }

  # Filter the dataset based on the source and score cutoff
  KS.filtered <- switch(datasets,
                        "PSP" = KS.all %>% filter(Source == "PhosphoSitePlus"),
                        "PSP_networkin" = KS.all %>% filter(networkin_score >= networkin_score_cutoff)
  )

  return(KS.filtered)
}
