\docType{data}
\name{mesa.model}
\alias{mesa.model}
\title{Example of a \code{STmodel} structure}
\format{A list with elements, a detailed description of each elements is
given in details below}
\source{
  Contains monitoring data from the \strong{MESA Air}
  project, see Cohen et.al. (2009) and
  \code{\link{mesa.data.raw}} for details.
}
\description{
  Example of a model structure holding observations,
  geographic covariates, observation locations, smooth
  temporal trends, spatio-temporal covariates, and
  covariance specifications for the model.
}
\details{
  A \code{STmodel} object consists of a list with, some or
  all of, the following elements: \describe{ \item{obs}{A
  data.frame with columns: \describe{ \item{obs}{The value
  of each observation.} \item{date}{The observations time,
  preferably of class \code{\link[base:Date]{Date}}.}
  \item{ID}{A \code{character}-class giving observation
  locations; should match elements in \code{locations$ID}.}
  \item{idx}{match between \code{obs$ID} and
  \code{locations$ID} for faster computations.} } The
  data.frame is sorted by \code{date} and \code{idx}.  }
  \item{locations.list,locations}{Specification of
  locations and data.frame with locations for observations
  (and predictions), see \code{\link{processLocation}}.  }
  \item{D.nu,D.beta}{Distance matrices for the locations in
  the, possibly different coordinate systems for beta- and
  nu-fields. See \code{\link{processLocation}}.  }
  \item{cov.beta,cov.nu}{Covariance structure for beta- and
  nu-fields, see \code{\link{updateCovf}}.  }
  \item{LUR.list,LUR}{Specification of covariates for the
  beta-fields and a list with covariates for each of the
  beta-fields, see \code{\link{processLUR}} and
  \code{\link{createLUR}}.  } \item{trend,trend.fnc}{The
  temporal trends with \emph{one of the} columns being
  named \code{date}, preferably of class
  \code{\link[base:Date]{Date}} providing the time
  alignment for the temporal trends.} \item{F}{A matrix
  contaning smooth temporal trends for each observation;
  elements taken from \code{trend}.}

  \item{ST.list,ST,ST.all}{Spatio-termporal covariates,
  \code{NULL} if no covariates. For the observations and
  all space-time locations respectively, see
  \code{\link{processST}} and \code{\link{createST}}.  }
  \item{old.trend,fit.trend}{Additional components added if
  the observations have been detrended, see
  \code{\link{detrendSTdata}}.  } }
}
\examples{
##load the data
data(mesa.model)

##examine components
names(mesa.model)
print(mesa.model)
summary(mesa.model)

##requested geographic and spatio-temporal covariates
mesa.model$LUR.list
mesa.model$ST.list

##covariates for the temporal intercept
head(mesa.model$LUR$const)
##...and the two smooth temporal trends
head(mesa.model$LUR$V1)
head(mesa.model$LUR$V2)

##Some important dimensions of the model
loglikeSTdim(mesa.model)
}
\references{
  M. A. Cohen, S. D. Adar, R. W. Allen, E. Avol, C. L.
  Curl, T.  Gould, D. Hardie, A. Ho, P. Kinney, T. V.
  Larson, P. D. Sampson, L.  Sheppard, K. D. Stukovsky, S.
  S. Swan, L. S. Liu, J. D. Kaufman. (2009) Approach to
  Estimating Participant Pollutant Exposures in the
  Multi-Ethnic Study of Atherosclerosis and Air Pollution
  (MESA Air). Environmental Science & Technology: 43(13),
  4687-4693.
}
\seealso{
  \code{\link{createSTmodel}} for creation of
  \code{STmodel} objects. \cr \code{\link{createSTdata}}
  for creation of the originating \code{STdata} object.

  Other example data: \code{\link{est.cv.mesa}},
  \code{\link{est.mesa.model}},
  \code{\link{MCMC.mesa.model}},
  \code{\link{mesa.data.raw}},
  \code{\link{pred.mesa.model}}
}
\keyword{datasets}

