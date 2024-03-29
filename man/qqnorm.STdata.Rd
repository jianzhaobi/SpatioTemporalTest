\name{qqnorm.predCVSTmodel}
\alias{qqnorm.predCVSTmodel}
\alias{qqnorm.STdata}
\alias{qqnorm.STmodel}
\title{QQ-norm for \code{STdata}/\code{STmodel}/\code{predCVSTmodel} objects}
\usage{
  \method{qqnorm}{predCVSTmodel} (y, ID = "all",
    main = "Q-Q plot for CV residuals", group = NULL,
    col = 1, norm = FALSE, line = 0, org.scale = TRUE, ...)

  \method{qqnorm}{STdata} (y, ID = "all",
    main = "Q-Q plot for observations", group = NULL,
    col = 1, line = 0, ...)

  \method{qqnorm}{STmodel} (y, ID = "all",
    main = "Q-Q plot for observations", group = NULL,
    col = 1, line = 0, ...)
}
\arguments{
  \item{norm}{\code{TRUE}/\code{FALSE}, plot normalised
  (mean=0, sd=1) or raw cross-validation residuals. If
  \code{norm=TRUE} a 0-1 line is added, to indicate what
  normalised residuals should look like.}

  \item{org.scale}{\code{TRUE}/\code{FALSE} scatter plots
  on the original untransformed scale, or using
  \code{exp(y)}. Only relevant if \code{x} was computed
  using \code{transform} in \code{\link{predictCV.STmodel}}
  (as pass through argument to
  \code{\link{predict.STmodel}})}

  \item{y}{\code{STdata}/\code{STmodel}/\code{predCVSTmodel}
  object for the qqnorm.}

  \item{ID}{The location for which we want to norm-plot
  observations/residuals or \code{"all"} to plot for all
  locations.}

  \item{main}{Title of the plot}

  \item{group}{Do the norm-plot both for all data and then
  for each subset defined by the factor/levels in group
  variable.}

  \item{col}{Colour of points in the plot, either a scalar
  or a vector with length matching the number of
  observations/residuals.}

  \item{line}{If non-zero add a
  \code{\link[stats:qqline]{qqline}} with \code{lty=line},
  to the plot; if 0 \emph{do not} add a line.}

  \item{...}{Arguments passed on to the plotting function,
  \code{\link[stats:qqnorm]{qqnorm}}.}
}
\value{
  Nothing
}
\description{
  \code{\link[stats:qqnorm]{qqnorm}} method for classes
  \code{STdata}/\code{STmodel}/\code{predCVSTmodel}. Used
  for data and residual analysis of the cross validation.
}
\examples{
################################
## Example for STdata/STmodel ##
################################
##load data
data(mesa.model)

##standard plot
qqnorm(mesa.model)
##add a line, and group (and colour) by AQS/FIXED
par(mfrow=c(2,2))
obs.type <- mesa.model$locations$type[match(mesa.model$obs$ID,
                                            mesa.model$locations$ID)]
qqnorm(mesa.model, line=1, group=obs.type, col=obs.type)

##colour code by season and split by type
##First create a vector dividing data into four seasons
I.season <- as.factor(as.POSIXlt(mesa.model$obs$date)$mon+1)
levels(I.season) <- c(rep("Winter",2), rep("Spring",3), 
                      rep("Summer",3), rep("Fall",3), "Winter") 

par(mfrow=c(2,2))
qqnorm(mesa.model, line=1, col=I.season, group=obs.type)
legend("bottomright", legend=as.character(levels(I.season)),
       pch=1, col=1:nlevels(I.season))

###############################
## Example for predCVSTmodel ##
###############################
##load data
data(pred.cv.mesa)

##standard plot
par(mfrow=c(1,1))
qqnorm(pred.cv.mesa, line=3)
##or for the normalised residuals
qqnorm(pred.cv.mesa, line=3, norm=TRUE)

##add a line, and group by AQS/FIXED
par(mfrow=c(2,2))
qqnorm(pred.cv.mesa, line=1, group=obs.type)

##and for normalised residuals, colour-coded by season
par(mfrow=c(2,2))
qqnorm(pred.cv.mesa, line=2, norm=TRUE,
       group=obs.type, col=I.season)
legend("bottomright", legend=as.character(levels(I.season)),
       pch=1, col=1:nlevels(I.season))
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
  \code{\link{scatterPlot.predCVSTmodel}},
  \code{\link{scatterPlot.STdata}},
  \code{\link{scatterPlot.STmodel}},
  \code{\link{summary.predCVSTmodel}}

  Other STdata methods: \code{\link{createSTdata}},
  \code{\link{plot.STdata}}, \code{\link{plot.STmodel}},
  \code{\link{print.STdata}},
  \code{\link{print.summary.STdata}},
  \code{\link{scatterPlot.predCVSTmodel}},
  \code{\link{scatterPlot.STdata}},
  \code{\link{scatterPlot.STmodel}},
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
  \code{\link{scatterPlot.predCVSTmodel}},
  \code{\link{scatterPlot.STdata}},
  \code{\link{scatterPlot.STmodel}},
  \code{\link{simulate.STmodel}},
  \code{\link{summary.STmodel}}
}

