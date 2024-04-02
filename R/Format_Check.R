#' Format Check for Input Data
#'
#' Checks if the input data contains all the required columns in the correct order and validates the format.
#' The function also checks for NA values in the 'FC' column.
#'
#' @param input The input dataset, expected to be a data frame.
#'
#' @return Prints a message indicating whether the input data format is correct, if any columns are missing,
#'         or if the column order is incorrect. Additionally, checks for NA values in the 'FC' column
#'         and prints a message if any are found.
#' @export
Format_Check <- function(input) {
  # Required column names, case-sensitive and in order
  required_columns <- c("Protein", "Gene", "Peptide", "Residue.Both", "p", "FC")
  
  # Check if each required column exists in the input and the order is correct
  missing_columns <- setdiff(required_columns, names(input))
  incorrect_order <- !identical(names(input), required_columns)
  
  if (length(missing_columns) == 0 && !incorrect_order) {
    cat("zcp: Data format and column order are correct!\n")
  } else {
    if (length(missing_columns) > 0) {
      cat(paste("zcp: Missing the following columns:", paste(missing_columns, collapse=", "), "\n"))
    }
    if (incorrect_order) {
      cat("zcp: The column order is incorrect. Please match the order with required columns.\n")
    }
  }
  
  if (anyNA(input$FC)) {
    cat("zcp: The 'FC' column contains NA values, please replace them with 0.\n")
  } else {
    cat("zcp: Data format is correct!\n")
  }
}
