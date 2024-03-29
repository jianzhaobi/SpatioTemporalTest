\name{stCheckCovars}
\alias{stCheckCovars}
\title{Check a data.frame of Covariates}
\usage{
  stCheckCovars(covars, ID.unique = character(0))
}
\arguments{
  \item{covars}{data.frame containing covariates, to be
  checked.}

  \item{ID.unique}{vector with unique IDs that HAVE to be
  present in the covariates, typically the observation
  locations.}
}
\value{
  Updated \code{covars} data.frame.
}
\description{
  Checks that data.frame of covariates is valid, making
  sure that all locations specified in \code{ID.unique}
  exist. The function will attempt to name each row in
  \code{covars} using 1) \code{covars$ID}, 2)
  \code{rownames(covars)}, and 3)
  \code{as.character(1:dim(covars)[1])}. The field
  \code{covars$ID} is added if missing and \code{rownames}
  are removed.
}
\examples{
##load data
  data(mesa.model)

  ##check covariates
  tmp <- stCheckCovars( mesa.model$locations, mesa.model$locations$ID )
  str(tmp)
  ##require non-existant site
  try( stCheckCovars( mesa.model$locations, "Bad.Site" ) )
  ##drop the ID
  mesa.model$locations$ID <- NULL
  tmp <- stCheckCovars( mesa.model$locations )
  ##ID:s infered from rownames (1-25)
  str(tmp)
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other object checking utilities:
  \code{\link{stCheckClass}}, \code{\link{stCheckFields}},
  \code{\link{stCheckObs}}, \code{\link{stCheckSTcovars}}
}

