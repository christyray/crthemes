#' Modification of legend keys for bar plots
#'
#' This is an extension of \code{\link[ggplot2]{draw_key_polygon}()} from
#' \code{\link[ggplot2]{ggplot2}} to modify the spacing between legend keys on
#' bar graphs and other graphs where the `fill` aesthetic is used.
#'
#' @inheritParams ggplot2::draw_key_polygon
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
#'     geom_col(key_glyph = "polygon2")

draw_key_polygon2 <- function(data, params, size) {
  lwd <- min(data$size, min(size) / 4)

  grid::rectGrob(
    width = grid::unit(0.8, "npc"),
    height = grid::unit(0.8, "npc"),
    gp = grid::gpar(
      col = data$colour,
      fill = scales::alpha(data$fill, data$alpha),
      lty = data$linetype,
      lwd = lwd * ggplot2::.pt,
      linejoin = "mitre"
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
  base_size <- base_scale*12

  ggplot2::guide_colourbar(
    draw.ulim = FALSE,
    draw.llim = FALSE,
    barheight = 12*base_scale,
    ticks.linewidth = 1*base_scale
  )
}
