#' Generate KESA Plot
#'
#' This function generates a bar plot with vertical lines and gradient color fill
#' based on `z.score`. It is designed to display the distribution of `z.score`
#' across different `GENE` levels, highlighting significant markers.
#'
#' @param x A data frame containing the columns `m`, `mS`, `z.score`, `p.value`, `GENE`,
#' and `sigmarker`. It assumes that `x` is a pre-processed data frame.
#'
#' @return A ggplot object representing the KESA plot. The plot includes a gradient fill based on
#' `z.score` values, with a vertical line at `x = 0` and customized theme settings.
#'
#' @importFrom dplyr arrange mutate rename
#' @importFrom ggplot2 ggplot aes geom_bar geom_vline scale_fill_gradient2 theme_classic
#' @export
KESA_plot <- function(x) {
  plot_dat <- x %>%
    arrange(desc(z.score)) %>%
    mutate(
      m = as.numeric(unlist(m)),
      mS = as.numeric(unlist(mS)),
      z.score = as.numeric(unlist(z.score)),
      p.value = as.numeric(unlist(p.value)),
      GENE = factor(GENE, levels = GENE)
    ) %>%
    rename("Condition" = sigmarker)

  Fig <- ggplot(data = plot_dat, aes(x = z.score, y = GENE, fill = z.score)) +
    geom_bar(stat = 'identity') +
    geom_vline(xintercept = c(0), size = 0.1, color = "#1f294e") +
    scale_fill_gradient2(low = "#073f82", mid = "#eaebea", high = "#B2182B", midpoint = 0) +
    theme_classic(base_line_size = 0.1) +
    ylab(NULL) +
    theme(axis.text.x = element_text(size = 10),
          axis.text.y = element_text(size = 5))

  return(Fig)
}
