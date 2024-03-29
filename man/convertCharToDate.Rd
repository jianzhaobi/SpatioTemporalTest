\name{convertCharToDate}
\alias{convertCharToDate}
\title{Convert Character to Dates}
\usage{
  convertCharToDate(x)
}
\arguments{
  \item{x}{character vector to convert to dates}
}
\value{
  a vector of dates, or of doubles or \code{NULL}.
}
\description{
  Attempts to convert input vector to Date, if that fails
  tries to convert to double. If conversion induces
  \code{NA} the function returns \code{NULL} indicating a
  failure.
}
\examples{
##a vector of dates is returned as is
convertCharToDate( seq(as.Date("2012-01-01"),as.Date("2012-01-31"),by=5) )

##if given as chracter vectors Date is returned
convertCharToDate( c("2012-01-01","2012-01-05","2012-01-10","2012-01-12") )

##double is returned as is
convertCharToDate( rnorm(5) )

##other things result in NULL
convertCharToDate( c("a","b","c") )
convertCharToDate( c("2012-01-01", "2012-01-05", "a", "2012-01-12") )
convertCharToDate( c(1,2,3,"d") )
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other utility functions: \code{\link{defaultList}}
}

