\name{predict.STmodel}
\alias{predict.STmodel}
\title{Computes Conditional Expectation at Unobserved Locations}
\usage{
  \method{predict}{STmodel} (object, x, STdata = NULL,
    Nmax = 1000, only.pars = FALSE, nugget.unobs = 0,
    only.obs = FALSE, pred.var = TRUE, pred.covar = FALSE,
    beta.covar = FALSE, combine.data = FALSE, type = "p",
    LTA = FALSE, transform = c("none", "unbiased", "mspe"),
    ...)
}
\arguments{
  \item{object}{\code{STmodel} object for which to compute
  predictions.}

  \item{x}{Model parameters for which to compute the
  conditional expectation. Either as a vector/matrix or an
  \code{estimateSTmodel} from
  \code{\link{estimate.STmodel}}.}

  \item{STdata}{\code{STdata}/\code{STmodel} object with
  locations/times for which to predict. If not given
  predictions are computed for locations/times in
  \code{object}}

  \item{Nmax}{Limits the size of matrices constructed when
  computing expectations. Use a smaller value if memory
  becomes a problem.}

  \item{only.pars}{Compute only the regression parameters
  (using GLS) along with the related variance.}

  \item{nugget.unobs}{Value of nugget at unonserved
  locations, either a scalar or a vector with one element
  per unobserved site. \strong{NOTE:} All sites in
  \code{STdata} are considered unobserved!}

  \item{only.obs}{Compute predictions at only locations
  specified by observations in \code{STdata}. Used to limit
  computations when doing cross-validation.
  \code{only.obs=TRUE} \emph{implies}
  \code{pred.covar=FALSE} and \code{combine.data=FALSE}.
  Further \code{\link{createSTmodel}} will be called on any
  \code{STdata} input, possibly \emph{reordering the
  observations.}}

  \item{pred.var,pred.covar}{Compute point-wise prediction
  variances; or compute covariance matrices for the
  predicted time series at each location.
  \code{pred.covar=TRUE} \emph{implies}
  \code{pred.var=TRUE} and sets \code{Nmax} equal to the
  number of timepoints.}

  \item{beta.covar}{Compute the full covariance matrix for
  the latent beta-fields, otherwise only the diagonal
  elements of V(beta|obs) are computed.}

  \item{combine.data}{Combine \code{object} and
  \code{STdata} and predict for the joint set of points,
  see \code{\link{c.STmodel}}.}

  \item{type}{A single character indicating the type of
  prediction to compute. Valid options are "f", "p", and
  "r", for \emph{full}, \emph{profile} or \emph{restricted
  maximum likelihood} (REML). For profile and full the
  predictions are computed assuming that \emph{both}
  covariance parameters and regression parameters are
  known, e.g. \code{E(X|Y,cov_par,reg_par)}; for REML
  predictions are compute assuming \emph{only} covariance
  parameters known, e.g. \code{E(X|Y,cov_par)}. The main
  difference is that REML will have \emph{larger} variances
  due to the additional uncertainty in the regression
  parameters.}

  \item{transform}{Regard field as log-Gaussian and apply
  exponential transformation to predictions. For the final
  expectations two options exist, either a unbiased
  prediction or the (biased) mean-squared error
  predictions.}

  \item{LTA}{Compute long-term temporal averages. Either a
  logical value or a list; if \code{TRUE} then averages at
  each location (and variances if \code{pred.var=TRUE}) are
  computed; otherwise this should be a list with elements
  named after locations and each element containing a
  vector (or list of vectors) with dates over which to
  compute averages. If \code{only.obs=TRUE} averages are
  computed over only the observations.}

  \item{...}{Ignored additional arguments.}
}
\value{
  The function returns a list containing (objects not
  computed will be missing): \item{opts}{Copy of options
  used in the function call.} \item{pars}{A list with
  regression parameters and related variances.  \code{pars}
  contain \code{gamma.E} and \code{alpha.E} with regression
  coefficients for the spatio-temporal model and land-use
  covaraiates; variances are found in \code{gamma.V} and
  \code{alpha.V}; cross-covariance between gamma and alpha
  in \code{gamma.alpha.C}.} \item{beta}{A list with
  estimates of the beta-fields, including the regression
  mean \code{mu}, conditional expectations \code{EX},
  possibly variances \code{VX}, and the full covariance
  matrix \code{VX.full}.} \item{EX.mu}{predictions based on
  the regression parameters, geographic covariates, and
  temporal trends. I.e. only the deterministic part of the
  spatio-temporal model.} \item{EX.mu.beta}{Predictions
  based on the latent-beta fields, but excluding the
  residual nu field.} \item{EX}{Full predictions at the
  space-time locations in \code{object} and/or
  \code{STdata}.} \item{EX.pred}{Only for
  \code{transform!="none"}, full predictions including bias
  correction for prediction error.}
  \item{VX,VX.pred}{Pointwise variances and prediction
  variances (i.e. incl.  contribution from
  \code{nugget.unobs}) for all locations in \code{EX}.}
  \item{VX.full}{A list with (number of locations)
  elements, each element is a (number of timepoints) - by -
  (number of timepoints) temporal covariance matrix for the
  timeseries at each location.}
  \item{MSPE,MSPE.pred}{Pointwise mean-square prediction
  errors for the log-Gaussian fields.}
  \item{log.EX,log.VX.pred,log.VX}{Pointwise predictions
  and variances for the un-transformed fields when
  \code{transform!="none"}} \item{LTA}{A data.frame with
  temporal averages for locations specified by \code{LTA}.
  } \item{I}{A vector with the locations of the
  observations in \code{object} or \code{STdata}. To
  extract predictions at the observations locations use
  \code{EX[I]}.}
}
\description{
  Compute the conditional expectations (i.e. predictions)
  at the unobserved space-time locations. Predictions are
  computed for the space-time locations in \code{object}
  and/or \code{STdata}, conditional on the observations
  (and temporal trends) in \code{object} and parameters
  given in \code{x}.
}
\details{
  In addition to computing the conditional expectation at a
  number of space-time locations the function also computes
  predictions based on only the regression part of the
  model as well as the latent beta-fields.

  Prediction are computed as the conditional expectation of
  a latent field given observations. This implies that
  \code{E(X_i| Y_i) != Y_i}, with the difference being due
  to smoothing over the nugget. Further two possible
  variance can be computed (see below), \code{V(X_i|Y_i)}
  and \code{V(X_i|Y_i)+nugget_i}. Here the nugget for
  unobserved locations needs to be specified as an
  additional argument \code{nugget.nobs}. The two variances
  correspond, losely, to confidence and prediction
  intervals.

  Variances are computed if \code{pred.var=TRUE} point-wise
  variances for the predictions (and the latent
  beta-fields) are computed. If instead
  \code{pred.covar=TRUE} the full covariance matrices for
  each predicted time series is computed; this implies that
  the covariances between temporal predictions at the same
  location are calculated but \emph{not}, due to memory
  restrictions, any covariances between locations.
  \code{beta.covar=TRUE} gives the full covariance matrices
  for the latent beta-fields.

  If \code{transform!="none"} the field is assumed to be
  log-Gaussian and expectations are transformed, and if
  \code{pred.var=TRUE} the mean squared prediction errors
  are given.
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
\author{
  Johan Lindstr�m
}
\seealso{
  Other predictSTmodel methods:
  \code{\link{plot.predCVSTmodel}},
  \code{\link{plot.predictSTmodel}},
  \code{\link{print.predictSTmodel}}

  Other STmodel methods: \code{\link{c.STmodel}},
  \code{\link{createSTmodel}}, \code{\link{estimate}},
  \code{\link{estimate.STmodel}}, \code{\link{estimateCV}},
  \code{\link{estimateCV.STmodel}}, \code{\link{MCMC}},
  \code{\link{MCMC.STmodel}}, \code{\link{plot.STdata}},
  \code{\link{plot.STmodel}}, \code{\link{predictCV}},
  \code{\link{predictCV.STmodel}},
  \code{\link{print.STmodel}},
  \code{\link{print.summary.STmodel}},
  \code{\link{qqnorm.predCVSTmodel}},
  \code{\link{qqnorm.STdata}},
  \code{\link{qqnorm.STmodel}},
  \code{\link{scatterPlot.predCVSTmodel}},
  \code{\link{scatterPlot.STdata}},
  \code{\link{scatterPlot.STmodel}},
  \code{\link{simulate.STmodel}},
  \code{\link{summary.STmodel}}
}

