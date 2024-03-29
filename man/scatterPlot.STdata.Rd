\name{scatterPlot.predCVSTmodel}
\alias{scatterPlot.predCVSTmodel}
\alias{scatterPlot.STdata}
\alias{scatterPlot.STmodel}
\title{scatterPlot for \code{STdata}/\code{STmodel}/\code{predCVSTmodel} objects}
\usage{
  \method{scatterPlot}{predCVSTmodel} (x, covar = NULL,
    trend = NULL, pch = 1, col = 1, cex = 1, lty = 1,
    subset = NULL, group = NULL, add = FALSE,
    smooth.args = NULL, STdata,
    type = c("obs", "res", "res.norm"), org.scale = TRUE,
    ...)

  \method{scatterPlot}{STdata} (x, covar = NULL,
    trend = NULL, pch = 1, col = 1, cex = 1, lty = 1,
    subset = NULL, group = NULL, add = FALSE,
    smooth.args = NULL, ...)

  \method{scatterPlot}{STmodel} (x, covar = NULL,
    trend = NULL, pch = 1, col = 1, cex = 1, lty = 1,
    subset = NULL, group = NULL, add = FALSE,
    smooth.args = NULL, ...)
}
\arguments{
  \item{type}{What to use in the scatter plot, valid
  options are \code{"obs"} for observations, \code{"res"}
  residuals, and \code{"res.norm"} for normalised
  residuals.}

  \item{STdata}{\code{STdata} or \code{STmodel} containing
  covariates and trend against which to plot.}

  \item{org.scale}{\code{TRUE}/\code{FALSE} scatter plots
  on the original untransformed scale, or using
  \code{exp(y)}. Only relevant if \code{x} was computed
  using \code{transform} in \code{\link{predictCV.STmodel}}
  (as pass through argument to
  \code{\link{predict.STmodel}})}

  \item{x}{\code{STdata}/\code{STmodel}/\code{predCVSTmodel}
  object to plot.}

  \item{covar,trend}{Plot observations as a function of?
  Only \emph{one} of these should be not \code{NULL}.
  \code{covar} uses location covariates, and \code{trend}
  uses temporal trend (or dates); \code{trend=0} uses a
  temporal intercept (i.e. a constant).}

  \item{pch,cex}{Point and point size for the plot, a
  single value or \code{nlevels(group)}}

  \item{col,lty}{Color of points and smooth lines. A single
  value or \code{nlevels(group)+1} values; the last value
  is used for fitting a line to \emph{all} data. Use
  \code{lty=NA} to supress smooth lines.}

  \item{subset}{A subset of locations for which to plot
  observations as a function of covariates.}

  \item{group}{A vector of factors of the same length as
  the number of observations (typically
  \code{length(x$obs$obs)}, or
  \code{length(x$pred.obs$obs)}) used to group data and fit
  different smooths to each group.}

  \item{add}{Add to existing plot}

  \item{smooth.args}{List of arguments for
  \code{\link[stats:loess.smooth]{loess.smooth}}.}

  \item{...}{Additional parameters passed to
  \code{\link[graphics:plot]{plot}}.}
}
\value{
  Nothing
}
\description{
  Does a scatterPlot of observations/residuals against
  covariates (either geographic or temporal trends), adding
  a spline fit (similar to
  \code{\link[stats:scatter.smooth]{scatter.smooth}}.
}
\examples{
################################
## Example for STdata/STmodel ##
################################
##load data
data(mesa.model)

par(mfrow=c(2,2))
##plot observations as a function of longitude for an STmodel object
scatterPlot(mesa.model, covar="long")

##as a function of the first temporal trend, subset to only AQS sites
##and fit for each location
scatterPlot(mesa.model, trend=1, col=c(1:25,1), pch=19, cex=.1,
            group=mesa.model$obs$ID, lty=c(rep(2,25),1),
            subset=with(mesa.model$locations, ID[type=="AQS"]))

##if plotting against the distance to coast, we might have to change the
##smooting.
suppressWarnings( scatterPlot(mesa.model, covar="km.to.coast") )
##better
scatterPlot(mesa.model, covar="km.to.coast", col=c(NA,2), add=TRUE,
            smooth.args=list(span=4/5,degree=2))

##Lets group data by season
##First create a vector dividing data into four seasons
I.season <- as.factor(as.POSIXlt(mesa.model$obs$date)$mon+1)
levels(I.season) <- c(rep("Winter",2), rep("Spring",3), 
                      rep("Summer",3), rep("Fall",3), "Winter") 
scatterPlot(mesa.model, covar="log10.m.to.a1", col=c(2:5,1),
            group=I.season)
legend("bottomleft", c(levels(I.season),"All"), col=c(2:5,1), pch=1)


###############################
## Example for predCVSTmodel ##
###############################
##load data
data(pred.cv.mesa)

##simple case of residuals against temporal trends
par(mfrow=c(2,1))
scatterPlot(pred.cv.mesa, trend=1, STdata=mesa.model, type="res")

##colour coded by season
I.season <- as.factor(as.POSIXlt(pred.cv.mesa$pred.obs$date)$mon+1)
levels(I.season) <- c(rep("Winter",2), rep("Spring",3), 
                      rep("Summer",3), rep("Fall",3), "Winter") 

scatterPlot(pred.cv.mesa, trend=1, STdata=mesa.model, type="res",
            group=I.season, col=c(2:5,1), lty=c(1,1,1,1,2),
            smooth.args=list(span=.1,degree=2))
            
##or as function of covariates
par(mfcol=c(2,2))
scatterPlot(pred.cv.mesa, , type="res", covar="log10.m.to.a1",
            STdata=mesa.model, group=I.season, col=c(2:5,1))
scatterPlot(pred.cv.mesa, type="res", covar="km.to.coast",
            STdata=mesa.model, group=I.season, col=c(2:5,1),
            smooth.args=list(span=4/5,degree=1))

##let's compare to the original observations
scatterPlot(pred.cv.mesa, covar="log10.m.to.a1", STdata=mesa.model,
            group=I.season, col=c(2:5,1), type="obs")
scatterPlot(pred.cv.mesa, covar="km.to.coast", STdata=mesa.model,
            group=I.season, col=c(2:5,1), type="obs",
            smooth.args=list(span=4/5,degree=1))
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other predCVSTmodel methods: \code{\link{estimateCV}},
  \code{\link{estimateCV.STmodel}},
  \code{\link{plot.predCVSTmodel}},
  \code{\link{plot.predictSTmodel}},
  \code{\link{predictCV}}, \code{\link{predictCV.STmodel}},
  \code{\link{print.predCVSTmodel}},
  \code{\link{print.summary.predCVSTmodel}},
  \code{\link{qqnorm.predCVSTmodel}},
  \code{\link{qqnorm.STdata}},
  \code{\link{qqnorm.STmodel}},
  \code{\link{summary.predCVSTmodel}}

  Other STdata methods: \code{\link{createSTdata}},
  \code{\link{plot.STdata}}, \code{\link{plot.STmodel}},
  \code{\link{print.STdata}},
  \code{\link{print.summary.STdata}},
  \code{\link{qqnorm.predCVSTmodel}},
  \code{\link{qqnorm.STdata}},
  \code{\link{qqnorm.STmodel}},
  \code{\link{summary.STdata}}

  Other STmodel methods: \code{\link{c.STmodel}},
  \code{\link{createSTmodel}}, \code{\link{estimate}},
  \code{\link{estimate.STmodel}}, \code{\link{estimateCV}},
  \code{\link{estimateCV.STmodel}}, \code{\link{MCMC}},
  \code{\link{MCMC.STmodel}}, \code{\link{plot.STdata}},
  \code{\link{plot.STmodel}},
  \code{\link{predict.STmodel}}, \code{\link{predictCV}},
  \code{\link{predictCV.STmodel}},
  \code{\link{print.STmodel}},
  \code{\link{print.summary.STmodel}},
  \code{\link{qqnorm.predCVSTmodel}},
  \code{\link{qqnorm.STdata}},
  \code{\link{qqnorm.STmodel}},
  \code{\link{simulate.STmodel}},
  \code{\link{summary.STmodel}}
}

