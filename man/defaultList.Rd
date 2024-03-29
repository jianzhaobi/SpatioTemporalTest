\name{defaultList}
\alias{defaultList}
\title{Add Default Elements to Incomplete list}
\usage{
  defaultList(x, prototype = list())
}
\arguments{
  \item{x}{A list}

  \item{prototype}{A list with named elements, any elements
  missing from \code{x} are replaced with corresponding
  elements from \code{prototype}.}
}
\value{
  Updated version of \code{x}
}
\description{
  Given two lists elemets (by name) missing from the first
  are copied from the second list (if present). Is used to
  create default lists, ensuring that all elements expected
  in the list are present with reasonable values (if not
  user specified).
}
\examples{
defaultList(list(a=1,b=4), list(a=3,c="a",d=4))
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other utility functions: \code{\link{convertCharToDate}}
}

