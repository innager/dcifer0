% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ibd.R
\name{ibdDat}
\alias{ibdDat}
\title{Pairwise Relatedness}
\usage{
ibdDat(
  dsmp,
  coi,
  afreq,
  dsmp2 = NULL,
  coi2 = NULL,
  pval = TRUE,
  confint = FALSE,
  rnull = 0,
  alpha = 0.05,
  nr = 1000,
  reval = NULL
)
}
\arguments{
\item{dsmp}{a list with each element corresponding to one sample.}

\item{coi}{a vector containing complexity of infection for each sample.}

\item{afreq}{a list of allele frequencies. Each element of the list
corresponds to a locus.}

\item{dsmp2}{a list representing a second dataset.}

\item{coi2}{a vector with complexities of infection for a second dataset.}

\item{pval}{a logical value specifying if p-values should be returned.}

\item{confint}{a logical value specifying if confidence intervals should be
returned.}

\item{rnull}{a null value of relatedness parameter for hypothesis testing
(needed if \code{pval = TRUE}).}

\item{alpha}{significance level for a \ifelse{html}{\out{1 -
&alpha;}}{\eqn{1 - \alpha}} confidence region.}

\item{nr}{an integer specifying precision of the estimate: resolution of
a grid of parameter values (\ifelse{html}{\out{[0, 1]}}{\eqn{[0, 1]}}
divided into \code{nr} equal intervals), over which the likelihood will be
calculated. Ignored if non-null \code{reval} is provided.}

\item{reval}{a vector or a single-row matrix. A grid of parameter values,
over which the likelihood will be calculated.}
}
\value{
A matrix if \code{pval} and \code{confint} are \code{FALSE} and
3-dimensional arrays otherwise. The matrices are lower triangular if
distances are calculated within a dataset. For a 3-dimensional array,
stacked matrices contain relatedness estimates, p-values, and endpoints of
confidence intervals (if requested).
}
\description{
Provides pairwise relatedness estimates within a dataset or
between two datasets along with optional p-values and confidence intervals
(CI).
}
\details{
For this function, \ifelse{html}{\out{M}}{\eqn{M}} is set to 1. If
\code{confint = FALSE}, Newton's method is used to find the estimates,
otherwise the likelihood is calculated for a grid of parameter values.
}
\examples{
coi   <- getCOI(dsmp, lrank = 2)           # estimate COI
afreq <- calcAfreq(dsmp, coi, tol = 1e-5)  # estimate allele frequencies

# subset of samples for faster processing
i1 <- 1:15     # from Maputo
i2 <- 31:40    # from Inhambane
isub <- c(i1, i2)

# matrix is returned
dres1 <- ibdDat(dsmp[isub], coi[isub], afreq, pval = FALSE)
dim(dres1)

# test a null hypothesis H0: r = 0, change precision
dres2 <- ibdDat(dsmp[isub], coi[isub], afreq, pval = TRUE, rnull = 0,
                nr = 1e2)
dim(dres2)

# test H0: r = 0.2, include 99\% confidence intervals
dres3 <- ibdDat(dsmp[isub], coi[isub], afreq, pval = TRUE, confint = TRUE,
                rnull = 0.2, alpha = 0.01)
dres3[2, 1, ]

# pairwise relatedness between two datasets, H0: r = 0
drbetween <- ibdDat(dsmp[i1], coi[i1], afreq,
                    dsmp2 = dsmp[i2], coi2 = coi[i2])
dim(drbetween)
drbetween[1, 2, ]
sum(is.na(drbetween[, , 1]))

}
\seealso{
\code{\link{ibdPair}} for genetic relatedness between two samples
and \code{\link{ibdEstM}} for estimating the number of related pairs of
strains.
}
