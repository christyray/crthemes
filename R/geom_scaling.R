#' @importFrom ggthemes GeomRangeFrame

geom_scaling <- function(scale_factor, base_colour="gray20") {
  ggplot2::update_geom_defaults("point", list(size = 1.75*scale_factor^1.4))
  ggplot2::update_geom_defaults("line", list(size = 1*scale_factor))
  ggplot2::update_geom_defaults("smooth", list(size = 1*scale_factor))
  ggplot2::update_geom_defaults("segment", list(size = 1*scale_factor))
  ggplot2::update_geom_defaults("RangeFrame", list(
    size = 0.5*scale_factor,
    colour = "gray20"
  ))
}
