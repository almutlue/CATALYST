% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/plotMedExprs.R
\docType{methods}
\name{plotMedExprs}
\alias{plotMedExprs}
\alias{plotMedExprs,daFrame-method}
\title{Plot median expressions}
\usage{
plotMedExprs(x, ...)

\S4method{plotMedExprs}{daFrame}(x, k = "meta20", facet = c("antigen",
  "cluster_id"), group_by = "condition")
}
\arguments{
\item{x}{a \code{\link{daFrame}}.}

\item{...}{optional arguments.}

\item{k}{character string. Specifies the clustering to use.
If \code{facet = "antigen"}, this argument will be ignored.}

\item{facet}{\code{"antigen"} or \code{"cluster_id"}. Note that 
the latter requires having run \code{\link{cluster}} first.}

\item{group_by}{character string. Has to appear as a column name of \code{rowData(x)}. 
Specifies sample grouping.}
}
\value{
a \code{ggplot} object.
}
\description{
Plots median marker expressions across samples
computed on arcsinh-transformed intensities.
}
\examples{
data(PBMC_fs, PBMC_panel, PBMC_md)
re <- daFrame(PBMC_fs, PBMC_panel, PBMC_md)

# plot median expressions
plotMedExprs(re)

# run clustering
re <- cluster(re)

# plot median expressions across clusters
plotMedExprs(re, facet="cluster_id", k="meta8")

}
\references{
Nowicka M, Krieg C, Weber LM et al. 
CyTOF workflow: Differential discovery in 
high-throughput high-dimensional cytometry datasets.
\emph{F1000Research} 2017, 6:748 (doi: 10.12688/f1000research.11622.1)
}
\author{
Helena Lucia Crowell \email{helena.crowell@uzh.ch}
}
