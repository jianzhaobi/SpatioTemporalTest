\name{stCheckObs}
\alias{stCheckObs}
\title{Check an \code{obs} data.frame.}
\usage{
  stCheckObs(obs)
}
\arguments{
  \item{obs}{\code{data.frame} to be checked.}
}
\value{
  Nothing
}
\description{
  Checks that a observation data.frame is valid.
}
\details{
  A valid observation data.frame needs to fullfill:
  \itemize{ \item{Contains fields \code{obs}, \code{date},
  and \code{ID}} \item{All elements in \code{obs$obs} are
  finte} \item{\code{obs$date} is one of \code{Date},
  \code{numeric}, or \code{integer}} \item{\code{obs$ID} is
  \code{character}} \item{No duplicated observations (same
  \code{ID} and \code{date})} }
}
\examples{
##load data
  data(mesa.model)

  ##check observations
  stCheckObs( mesa.model$obs )
  ##some possible failures
  mesa.model$obs <- rbind(mesa.model$obs, mesa.model$obs[1,])
  try( stCheckObs( mesa.model$obs ) )
  mesa.model$obs$obs[1] <- NaN
  try( stCheckObs( mesa.model$obs ) )
  mesa.model$obs$date <- as.character( mesa.model$obs$date )
  try( stCheckObs( mesa.model$obs ) )
  mesa.model$obs$date <- NULL
  try( stCheckObs( mesa.model$obs ) )
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other object checking utilities:
  \code{\link{stCheckClass}}, \code{\link{stCheckCovars}},
  \code{\link{stCheckFields}},
  \code{\link{stCheckSTcovars}}
}

