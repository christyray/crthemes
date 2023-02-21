#' Modification of legend keys for bar plots
#'
#' \code{draw_key_polygon2()} is an extension of
#' \code{\link[ggplot2]{draw_key_polygon}()} from \code{\link[ggplot2]{ggplot2}}
#' to modify the spacing between legend keys on bar graphs and other graphs
#' where the `fill` aesthetic is used. It does this by scaling down the legend
#' keys within their allotted space.
#'
#' \code{key_scale()} is a wrapper function to allow the specific scaling of the
#' legend keys to be modified inside the \code{geom} function.
#'
#' The core part of this approach that differs from the standard `ggplot2`
#' polygon key is that the width and height are changed to `unit(scale, "npc")`
#' instead of `unit(1, "npc")`, where `scale` has a default value of `0.8`. This
#' makes the width and height of the fill key take up 80 percent (or the `scale`
#' value, if different) of the key space instead of 100 percent of the key
#' space. This makes the key fill slightly smaller, giving the appearance of
#' increased space between the keys.
#'
#' @inheritParams ggplot2::draw_key_polygon
#' @param scale Scaling factor for the height and width of the legend key within
#'   its allotted space. Defaults to 0.8, which gives the key 80 percent of the
#'   allotted height and width.
#'
#' @return A grid grob.
#'
#' @export
#'
#' @examples
#' library(ggplot2)
#'
#' df <- data.frame(
#'     x = factor(c("IL6R", "IL8R", "IL6R-Ab", "IL8R-Ab", "IL6R-Ab-IL8R"),
#'           levels = c("IL6R", "IL8R", "IL6R-Ab", "IL8R-Ab", "IL6R-Ab-IL8R")),
#'     y = c(0.45, 0.78, 0.61, 0.31, 0.72))
#' p <- ggplot(df, aes(x, y, fill = x)) +
#'     geom_col(key_glyph = key_scale())

key_scale <- function(scale = 0.8) {
  function(data, params, size) {

    # data, params, and size do not exist in the function environment, so R will
    # look outside the function into the ggplot environment for their values
    draw_key_polygon2(data = data, params = params, size = size, scale = scale)
  }
}

#' @rdname key_scale
#' @export

draw_key_polygon2 <- function(data, params, size, scale = 0.8) {
  lwd <- min(data$size, min(size) / 4)

  grid::rectGrob(
    width = grid::unit(scale, "npc"),
    height = grid::unit(scale, "npc"),
    gp = grid::gpar(
      col = data$colour %||% NA,
      fill = scales::alpha(data$fill, data$alpha),
      lty = data$linetype %||% 1,
      lwd = lwd * ggplot2::.pt,
      linejoin = params$linejoin %||% "mitre",
      lineend = params$lineend %||% "butt"
    ))
}

#' Legend theme and appearance tweaking for heatmaps
#'
#' Changes to details of how heatmap legends are drawn to better match the rest
#' of the custom theme
#'
#' @inheritParams theme_cr
#'
#' @export
#'
#' @examples
#' library(ggplot2)
#'
#' p <- ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
#'     geom_raster() +
#'     scale_fill_distiller(palette = "YlGn", guide = heatmap_legend())

heatmap_legend <- function(base_scale = 1, font = "Roboto Regular") {

  ggplot2::guide_colourbar(
    barheight = 12*base_scale,
    ticks.linewidth = 0.5*base_scale
  )
}
