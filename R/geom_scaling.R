#' @importFrom ggthemes GeomRangeFrame

geom_scaling <- function(
    scale_factor, font = "Roboto Regular", base_colour="gray20"
  ) {
  ggplot2::update_geom_defaults("point", list(size = 1.75*scale_factor^1.4))
  ggplot2::update_geom_defaults("line", list(size = 1*scale_factor))
  ggplot2::update_geom_defaults("abline", list(
    size = 0.65*scale_factor,
    color = base_colour
  ))
  ggplot2::update_geom_defaults("vline", list(
    size = 0.65*scale_factor,
    color = base_colour
  ))
  ggplot2::update_geom_defaults("hline", list(
    size = 0.65*scale_factor,
    color = base_colour
  ))
  ggplot2::update_geom_defaults("smooth", list(size = 1*scale_factor))
  ggplot2::update_geom_defaults("segment", list(size = 1*scale_factor))
  ggplot2::update_geom_defaults("text", list(
    size = 4.5*scale_factor,
    family = font,
    fontface = "bold",
    color = base_colour
  ))
  ggplot2::update_geom_defaults("RangeFrame", list(
    size = 0.5*scale_factor,
    colour = base_colour
  ))
}
