geom_scaling <- function(scale_factor) {
  ggplot2::update_geom_defaults("point", list(size = 1.75*scale_factor^1.4))
  ggplot2::update_geom_defaults("line", list(size = 1*scale_factor))
  ggplot2::update_geom_defaults("smooth", list(size = 1*scale_factor))
  ggplot2::update_geom_defaults("segment", list(size = 1*scale_factor))
}
