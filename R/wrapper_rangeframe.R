#' Wrapper function for geom_rangeframe to allow custom limits
#'
#' By default, \code{\link[ggthemes]{geom_rangeframe}} uses the range of the x
#' and y data to set the range for the axis frame. This function instead uses
#' the provided `xlim` and `ylim` to create a data frame to provide new limits
#' to the range frame.
#'
#' @param xlim Vector of length 2, gives the minimum and maximum values for the
#'   range frame on the x axis
#' @param ylim Vector of length 2, gives the minimum and maximum values for the
#'   range frame on the y axis
#' @param ... Additional parameters for \code{\link[ggthemes]{geom_rangeframe}}
#'
#' @details Just like \code{\link[ggthemes]{geom_rangeframe}}, this should be
#'   used with `coord_cartesian(clip="off")` in order to correctly draw the
#'   lines.
#'
#' @export
#'
#' @examples
#' library(ggplot2)
#' library(ggthemes)
#'
#' df <- data.frame(x = 1:5, y = 1:5, z = c("a","b","c","b","c"))
#' p <- ggplot(df, aes(x, y, color = z)) + geom_point()
#' p + geom_rangeframe_cr(xlim = c(0,6), ylim = c(1,6), colour = "gray20")
#'

geom_rangeframe_cr <- function(xlim, ylim, ...) {
  data <- data.frame(x = xlim, y = ylim)
  ggthemes::geom_rangeframe(
    data = data,
    ggplot2::aes(.data$x, .data$y),
    inherit.aes = TRUE,
    ...
  )
}

#' Theme modification when using geom_rangeframe
#'
#' Modifies select aspects of theme_cr() to make it work better with the
#' \code{\link[ggthemes]{geom_rangeframe}} from the
#' \code{\link[ggthemes]{ggthemes}} package.
#'
#' @inheritParams theme_cr
#'
#' @export
#'
#' @examples
#' library(ggplot2)
#' library(ggthemes)
#'
#' df <- data.frame(x = 1:5, y = 1:5, z = c("a", "b", "c", "b", "c"))
#' p <- ggplot(df, aes(x, y, color = z)) + geom_point() +
#'     geom_rangeframe(colour = "gray20")
#'
#'\dontrun{
#' p + theme_rangeframe()
#'}

theme_rangeframe <- function(base_scale = 1, font_scale = 1,
                             font = "Roboto Regular", symbol = TRUE,
                             cairo = FALSE) {

    # Define sizing based on input scale
  base_size <- base_scale*12

  # Apply the font scale to the font size
  font_size <- base_size*font_scale

  theme_cr(base_scale = base_scale, font_scale = font_scale, font = font,
           symbol = symbol, cairo = cairo) +
    theme(axis.line = element_blank(),
          axis.ticks = element_line(linewidth = base_scale*0.5),
          axis.ticks.length = unit(font_size/2, "pt")
    )
}
