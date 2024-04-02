#' Load Kinase-Substrate Data
#'
#' This function loads kinase-substrate interaction data from an RDS file that is
#' included within the package. This internal data is used for the Kinase Substrate
#' Enrichment Analysis (KSEA) computations.
#'
#' @return A data frame containing the kinase-substrate interaction data.
#' @keywords internal
#' @noRd
#' @examples
#' kinase_substrate_data <- function() {
#'   data_path <- system.file("extdata", "kinase_substrate.rds", package = "KSEApackage")
#'   readRDS(data_path)
#' }
kinase_substrate_data <- function() {
  data_path <- system.file("extdata", "kinase_substrate.rds", package = "KSEAr")
  readRDS(data_path)
}
