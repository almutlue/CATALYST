% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/runDR.R
\docType{methods}
\name{runDR}
\alias{runDR}
\alias{runDR,daFrame-method}
\title{Perform dim. reduction on a \code{daFrame}}
\usage{
runDR(x, ...)

\S4method{runDR}{daFrame}(x, dr = c("TSNE", "PCA", "MDS", "UMAP",
  "DiffusionMap"), rows_to_use = 1000, cols_to_use = NULL,
  overwrite = FALSE, ...)
}
\arguments{
\item{x}{a \code{\link{daFrame}}.}

\item{...}{additional parameters passed to the dim. reduction method
(see \code{\link[scater]{runTSNE}}, \code{\link[scater]{runPCA}}, 
\code{\link[scater]{runMDS}}, \code{\link[scater]{runUMAP}}, 
and \code{\link[scater]{runDiffusionMap}}).}

\item{dr}{character string specifying the dimensionaly reduction method.}

\item{rows_to_use}{numeric vector of row indices (cells) to use.
If NULL, all cells will be used. If a single integer value N,
(default 1000) a subset of N cells will be drawn from each sample.}

\item{cols_to_use}{character vector in \code{colnames(x)} or numeric
vector of column indices to use for computing reduced dimensions.}

\item{overwrite}{logical. Whether to force overwriting 
any existing dimension reduction of type \code{dr}.}
}
\value{
a \code{daFrame} with an additional entry titled "\code{dr}"
  in the \code{reducedDims} slot of the input \code{daFrame}.
}
\description{
Wrapper function to perform dimensionality reduction methods
  on a \code{daFrame} object using \code{scater}.
}
\examples{
data(PBMC_fs, PBMC_panel, PBMC_md)
daf <- daFrame(PBMC_fs, PBMC_panel, PBMC_md)
daf <- cluster(daf)

# PCA on all cells
daf <- runDR(daf, "PCA")

# UMAP on 1000 random cells
daf <- runDR(daf, "UMAP", rows_to_use = sample(nrow(daf), 1e3))

reducedDims(daf)
head(reducedDim(daf, "UMAP"))

# PCA on 200 cells per sample
set.seed(1)
daf <- runDR(daf, "PCA", rows_to_use = 200, overwrite = TRUE)

# re-using PCA for t-SNE will fail when using different cells
\dontrun{
daf <- runDR(daf, "TSNE", rows_to_use = 1:500, use_dimred = "PCA")}

# use same seed to assure the same subset of cells is sampled
set.seed(1)
daf <- runDR(daf, "TSNE", rows_to_use = 200, use_dimred = "PCA")

# number of rows used for each DR:
vapply(reducedDims(daf), nrow, numeric(1))

# running on subset can be done 2-ways
daf2 <- runDR(daf, "MDS", 1:100)
daf3 <- runDR(daf[1:100, ], "MDS")

# option 1 keeps object-dimensions
identical(dim(daf2), dim(daf))

# option 2 keeps only specified rows
all.equal(dim(daf3), c(100, ncol(daf)))

# reduced dimension are identical
identical(reducedDim(daf2), reducedDim(daf2))

# run t-SNE on B-cell clusters only
data(merging_table)
daf <- mergeClusters(daf, "meta20", merging_table, "merging")
cells_use <- grep("B-cells", cluster_ids(daf, "merging"))
daf <- runDR(daf, "TSNE", cells_use, overwrite = TRUE)
plotDR(daf, "TSNE", "merging")

}
\author{
Helena L. Crowell \email{helena.crowell@uzh.ch}
}
