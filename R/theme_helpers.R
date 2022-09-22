#' Convenience functions to remove space between plot and axes
#'
#' \code{expand0()} and \code{expand1()} are a convenience functions that call
#' \code{expansion(mult = c(0,0))} and \code{expansion(mult = c(0,0.1))},
#' respectively, to remove space between the plot and the axes. See
#' \code{\link[ggplot2]{expansion}()} for more information on setting the space
#' between the plotted data and the axes.
#'
#' @export
#'
#' @examples
#' library(ggplot2)
#'
#' p <- ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
#'     geom_raster() +
#'     scale_fill_distiller(palette = "YlGn") +
#'     scale_x_continuous(expand = expand0()) +
#'     scale_y_continuous(expand = expand0())
#'
#' df <- data.frame(
#'     x = factor(c("IL6R", "IL8R", "IL6R-Ab", "IL8R-Ab", "IL6R-Ab-IL8R"),
#'           levels = c("IL6R", "IL8R", "IL6R-Ab", "IL8R-Ab", "IL6R-Ab-IL8R")),
#'     y = c(0.45, 0.78, 0.61, 0.31, 0.72))
#' p <- ggplot(df, aes(x, y, fill = x)) +
#'     geom_col() +
#'     scale_y_continuous(expand = expand1())

expand0 <- function() {
  ggplot2::expansion(mult = c(0,0))
}

#' @rdname expand0
#' @export

expand1 <- function() {
  ggplot2::expansion(mult = c(0,0.1))
}

#' Remove elements at the top or bottom of a ggplot
#'
#' \code{theme_cut_top()} and \code{theme_cut_bottom()} are helper functions
#' that remove ggplot elements at the top and bottom of plots to allow multiple
#' panels to be stacked together. \code{theme_cut_top()} removes the facet
#' labels and extra margin at the top of a plot, and \code{theme_cut_bottom()}
#' removes the X-axis title, text, lines, and ticks and the extra margin at the
#' bottom of a plot.
#'
#' @importFrom ggplot2 theme element_blank margin
#'
#' @examples
#' library(ggplot2)
#'
#' df <- data.frame(x = 1:5, y = 1:5, z = c("a", "b", "c", "b", "c"))
#' p <- ggplot(df, aes(x, y, color = z)) + geom_point()
#'
#' p1 <- p + theme_cut_bottom()
#' p2 <- p + theme_cut_top()
#'
#' @name theme_cut
NULL

#' @rdname theme_cut
#' @export
theme_cut_top <- function() {
  theme(
    plot.margin = margin(t = 0),
    strip.text = element_blank(),
    strip.background = element_blank()
  )
}

#' @rdname theme_cut
#' @export
theme_cut_bottom <- function() {
  theme(
    plot.margin = margin(b = 0),
    axis.title.x = element_blank(),
    axis.text.x = element_blank(),
    axis.line.x = element_blank(),
    axis.ticks.x = element_blank()
  )
}
