% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/format_KS_dataset.R
\name{format_KS_dataset}
\alias{format_KS_dataset}
\title{Format Kinase-Substrate Dataset}
\usage{
format_KS_dataset(datasets = "PSP_networkin", networkin_score_cutoff = 2)
}
\arguments{
\item{datasets}{The source of the kinase-substrate data, either "PSP" for PhosphoSitePlus
or "PSP_networkin" for PhosphoSitePlus combined with networkin. Default is "PSP_networkin".}

\item{networkin_score_cutoff}{The cutoff for the networkin score used to filter the data.
Only entries with a networkin score above this threshold will be included.
Default is 2. The minimum allowed value is 1.}
}
\value{
A filtered data frame containing the kinase-substrate interactions from the specified source.
}
\description{
Loads and formats kinase-substrate datasets based on the specified source and score cutoff.
Supports loading from \code{PhosphoSitePlus} and \code{PhosphoSitePlus+networkin} datasets.
}
