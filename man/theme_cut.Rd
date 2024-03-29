% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/theme_helpers.R
\name{theme_cut}
\alias{theme_cut}
\alias{theme_cut_top}
\alias{theme_cut_bottom}
\title{Remove elements at the top or bottom of a ggplot}
\usage{
theme_cut_top()

theme_cut_bottom()
}
\description{
\code{theme_cut_top()} and \code{theme_cut_bottom()} are helper functions
that remove ggplot elements at the top and bottom of plots to allow multiple
panels to be stacked together. \code{theme_cut_top()} removes the facet
labels and extra margin at the top of a plot, and \code{theme_cut_bottom()}
removes the X-axis title, text, lines, and ticks and the extra margin at the
bottom of a plot.
}
\examples{
library(ggplot2)

df <- data.frame(x = 1:5, y = 1:5, z = c("a", "b", "c", "b", "c"))
p <- ggplot(df, aes(x, y, color = z)) + geom_point()

p1 <- p + theme_cut_bottom()
p2 <- p + theme_cut_top()

}
