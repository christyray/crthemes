#' @importFrom ggthemes GeomRangeFrame

geom_scaling <- function(
    scale_factor, font = "Roboto Regular", base_colour="gray20"
  ) {
  ggplot2::update_geom_defaults("point", list(size = 1.75*scale_factor^1.4))
  ggplot2::update_geom_defaults("line", list(linewidth = 1*scale_factor))
  ggplot2::update_geom_defaults("abline", list(
    linewidth = 0.65*scale_factor,
    color = base_colour
  ))
  ggplot2::update_geom_defaults("vline", list(
    linewidth = 0.65*scale_factor,
    color = base_colour
  ))
  ggplot2::update_geom_defaults("hline", list(
    linewidth = 0.65*scale_factor,
    color = base_colour
  ))
  ggplot2::update_geom_defaults("smooth", list(linewidth = 1*scale_factor))
  ggplot2::update_geom_defaults("segment", list(linewidth = 1*scale_factor))
  ggplot2::update_geom_defaults("text", list(
    size = 4.5*scale_factor,
    family = font,
    fontface = "bold",
    color = base_colour
  ))
  ggplot2::update_geom_defaults("errorbar", list(
    # Although the default width can be updated, it currently is not applied to
    # the plots and is instead always 0.5
    width = 0.25*scale_factor,
    linewidth = 0.5*scale_factor,
    color = "gray40"
  ))
  ggplot2::update_geom_defaults("errorbarh", list(linewidth = 0.5*scale_factor))
  ggplot2::update_geom_defaults("crossbar", list(linewidth = 0.5*scale_factor))
  ggplot2::update_geom_defaults("linerange", list(linewidth = 0.5*scale_factor))
  ggplot2::update_geom_defaults("pointrange", list(linewidth = 0.5*scale_factor))
  ggplot2::update_geom_defaults("RangeFrame", list(
    size = 0.5*scale_factor,
    colour = base_colour
  ))
}
