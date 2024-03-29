\docType{data}
\name{pred.mesa.model}
\alias{pred.mesa.model}
\title{Example of a \code{predictSTmodel} structure}
\format{A list with elements, see the return description in
  \code{\link{predict.STmodel}}.}
\source{
  Contains parametere estimates for the Spatio-Temporal
  model applied to monitoring data from the \strong{MESA
  Air} project, see Cohen et.al. (2009) and
  \code{\link{mesa.data.raw}} for details.
}
\description{
  Example of a predictions for the model in
  \code{\link{mesa.model}} using
  \code{\link{predict.STmodel}}. Two sets of predictions
  are presented, \code{pred.mesa.model} and
  \code{pred.mesa.model.obs}.
}
\examples{
##load data
data(mesa.model)
data(est.mesa.model)

##find regression parameters using GLS
x.reg <- predict(mesa.model, est.mesa.model, only.pars = TRUE)
str(x.reg$pars)

\dontrun{
  ##compute predictions at all locations, including beta-fields
  pred.mesa.model <- predict(mesa.model, est.mesa.model,
                             pred.var=TRUE)
}
##Let's load precomputed results instead.
data(pred.mesa.model)

##study results
print(pred.mesa.model)
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
  \code{\link{predict.STmodel}} for prediction. \cr
  \code{\link{createSTmodel}} for creation of the
  originating \code{STmodel} object.

  Other example data: \code{\link{est.cv.mesa}},
  \code{\link{est.mesa.model}},
  \code{\link{MCMC.mesa.model}},
  \code{\link{mesa.data.raw}}, \code{\link{mesa.model}}
}
\keyword{datasets}

