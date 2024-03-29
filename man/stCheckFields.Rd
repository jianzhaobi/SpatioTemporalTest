\name{stCheckFields}
\alias{stCheckFields}
\title{Test if fields exist in an object.}
\usage{
  stCheckFields(x, what, name = "Object")
}
\arguments{
  \item{x}{Object to test.}

  \item{what}{A character vector naming that should occur
  in \code{names(x)}.}

  \item{name}{Character string to be pasted into the error
  message describing \code{x}.}
}
\value{
  Nothing
}
\description{
  Test if named fields exist in \code{name(x)}, if not the
  function fails with a suitable error message.
}
\examples{
##load data
  data(mesa.model)
  ##names present in dta
  names(mesa.model$locations)

  ##check for some names
  stCheckFields(mesa.model$locations, c("ID","x","lat"))
  ##check for non-existant names
  try( stCheckFields(mesa.model$locations, c("ID","x","test")) )
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other object checking utilities:
  \code{\link{stCheckClass}}, \code{\link{stCheckCovars}},
  \code{\link{stCheckObs}}, \code{\link{stCheckSTcovars}}
}

