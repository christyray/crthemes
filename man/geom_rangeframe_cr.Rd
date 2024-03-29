% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wrapper_rangeframe.R
\name{geom_rangeframe_cr}
\alias{geom_rangeframe_cr}
\title{Wrapper function for geom_rangeframe to allow custom limits}
\usage{
geom_rangeframe_cr(xlim, ylim, ...)
}
\arguments{
\item{xlim}{Vector of length 2, gives the minimum and maximum values for the
range frame on the x axis}

\item{ylim}{Vector of length 2, gives the minimum and maximum values for the
range frame on the y axis}

\item{...}{Additional parameters for \code{\link[ggthemes]{geom_rangeframe}}}
}
\description{
By default, \code{\link[ggthemes]{geom_rangeframe}} uses the range of the x
and y data to set the range for the axis frame. This function instead uses
the provided \code{xlim} and \code{ylim} to create a data frame to provide new limits
to the range frame.
}
\details{
Just like \code{\link[ggthemes]{geom_rangeframe}}, this should be
used with \code{coord_cartesian(clip="off")} in order to correctly draw the
lines.
}
\examples{
library(ggplot2)
library(ggthemes)

df <- data.frame(x = 1:5, y = 1:5, z = c("a","b","c","b","c"))
p <- ggplot(df, aes(x, y, color = z)) + geom_point()
p + geom_rangeframe_cr(xlim = c(0,6), ylim = c(1,6), colour = "gray20")

}
