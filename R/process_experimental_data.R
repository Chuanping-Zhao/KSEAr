#' Process Experimental Data
#'
#' Preprocesses experimental data by replacing zeroes in the FC (fold change) column with NA,
#' splitting entries with multiple phosphorylation sites, and calculating the log2 of fold changes.
#'
#' @param experimental_data A data frame containing the experimental data with columns for protein,
#'        gene, peptide, residue, fold change (FC), and phosphorylation site (Residue.Both).
#'
#' @return A data frame with processed experimental data, where entries with multiple phosphorylation
#'         sites are expanded into separate rows, fold change values are transformed to log2 scale,
#'         and unnecessary NA rows are removed.
#' @export
process_experimental_data <- function(experimental_data) {
  # Replace fold change values of 0 with NA
  experimental_data[experimental_data$FC == 0, "FC"] <- NA
  
  # Check if there are multiple phosphorylation sites in any entries
  if (length(grep(";", experimental_data$Residue.Both)) == 0) {
    new <- experimental_data
  } else {
    # Separate entries with multiple phosphorylation sites
    double <- experimental_data[grep(";", experimental_data$Residue.Both),]
    single <- experimental_data[-grep(";", experimental_data$Residue.Both),]
    
    # Split entries with multiple phosphorylation sites into separate rows
    split_residues <- strsplit(as.character(double$Residue.Both), ";")
    expanded_rows <- mapply(function(protein, gene, peptide, residue, p, fc, n) {
      data.frame(Protein = rep(protein, n),
                 Gene = rep(gene, n),
                 Peptide = rep(peptide, n),
                 Residue.Both = residue,
                 p = rep(p, n),
                 FC = rep(fc, n))
    }, protein = double$Protein, gene = double$Gene, peptide = double$Peptide,
    residue = split_residues, p = double$p, fc = double$FC, n = sapply(split_residues, length),
    SIMPLIFY = FALSE)
    
    expanded <- do.call(rbind, expanded_rows)
    
    # Combine processed data
    new <- rbind(single, expanded)
  }
  
  # Rename columns and calculate log2 of fold change
  colnames(new)[c(2, 4)] <- c("SUB_GENE", "SUB_MOD_RSD")
  new$log2FC <- log2(abs(as.numeric(as.character(new$FC))))
  
  # Remove any rows with NA values
  new <- new[complete.cases(new), ]
  
  return(new)
}
