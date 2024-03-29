\name{stCheckClass}
\alias{stCheckClass}
\title{Test if an object belongs to given class(es).}
\usage{
  stCheckClass(x, what, name = "Object")
}
\arguments{
  \item{x}{Object to test.}

  \item{what}{A character vector naming classes.}

  \item{name}{Character string to be pasted into the error
  message describing \code{x}.}
}
\value{
  Nothing
}
\description{
  Test if an object belongs to given class(es), and produce
  reasonable error message if not.
}
\examples{
##create a basic object
  x <- 1
  class(x) <- "test"
  ## should be ok
  stCheckClass(x, "test", "x")
  ## this fails
  try( stCheckClass(x, "other", "x") )
}
\author{
  Johan Lindstr�m
}
\seealso{
  Similar to \code{\link[base:inherits]{inherits}}

  Other object checking utilities:
  \code{\link{stCheckCovars}}, \code{\link{stCheckFields}},
  \code{\link{stCheckObs}}, \code{\link{stCheckSTcovars}}
}

