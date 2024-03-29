\name{stCheckSTcovars}
\alias{stCheckSTcovars}
\title{Check an Array/List of Spatio-Temporal Covariates}
\usage{
  stCheckSTcovars(ST, ID.unique = character(0),
    date.unique = integer(0))
}
\arguments{
  \item{ST}{A 3D-\code{array} containing the ST-covariates,
  or a \code{list} of \code{array}:s, the list elements
  have to be of matching sizes and have the same
  \code{rownames} and \code{colnames}; list elemets are
  stacked to form a 3D-array.}

  \item{date.unique}{vector with unique dates/times that
  HAVE to be present in the ST-covariates, typically the
  observation time-points.}

  \item{ID.unique}{vector with unique IDs that HAVE to be
  present in the ST-covariates, typically the observation
  locations and un-observation locations for predictions}
}
\value{
  Updated \code{ST} array
}
\description{
  Checks that array/list of spatio-temporal covariates is
  valid, making sure that at least all locations specified
  in \code{ID.unique} exist. The function will attempt to
  name extract locations ID's from \code{colnames(ST)} and
  observation dates from \code{rownames(ST)} (using
  \code{\link{convertCharToDate}}).
}
\examples{
##load data
  data(mesa.model)

  ##check covariates
  tmp <- stCheckSTcovars( mesa.model$ST.all, mesa.model$locations$ID )
  str(tmp)
  ##require non-existant site
  try( stCheckSTcovars( mesa.model$ST.all, "Bad.Site" ) )
  ##require non-existant site
  try( stCheckSTcovars( mesa.model$ST.all, date.unique=1 ) )
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other object checking utilities:
  \code{\link{stCheckClass}}, \code{\link{stCheckCovars}},
  \code{\link{stCheckFields}}, \code{\link{stCheckObs}}
}

