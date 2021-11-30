#' Base customized theme
#'
#' The default customized theme for figure creation. This is also used as the
#' base theme for additional modifications, such as for bar graphs and heat
#' maps.
#'
#' This builds off of the \code{\link[ggplot2]{theme_gray}} function from the
#' \code{\link[ggplot2]{ggplot2}} package. It overrides components of the
#' \code{theme_gray} function with the function-specified components, resulting
#' in a completely custom theme. It uses the packaged fonts by default.
#'
#' @param base_scale Scaling factor for the plot as a whole. A value of 1
#'   corresponds to a font size of 12 pt.
#' @param font_scale Scaling factor for the font as compared to the plot. A
#'   value of 1 will scale the font to the plot size. Larger numbers make the
#'   font large compared to the plot size; smaller numbers make the font small
#'   compared to the plot size.
#' @param symbol Should the theme overwrite the system default Symbol font with
#'   the theme default font? If \code{TRUE}, \code{theme_custom()} will
#'   overwrite the Symbol font, and this change will persist until the end of
#'   the R session or until
#'   \code{\link[systemfonts:register_font]{clear_registry()}} is used.
#'
#' @return A list containing the theme properties.
#' @export
#' @importFrom ggplot2 theme_gray %+replace% theme element_line element_rect
#'   element_text element_blank margin rel
#' @importFrom grid unit
theme_custom <- function(base_scale = 1, font_scale = 1, symbol = TRUE) {

  # Define sizing based on input scale
  base_size <- base_scale*12
  base_line_size <- base_size/50
  base_rect_size <- base_size/50

  # Apply the font scale to the font size
  font_size <- base_size*font_scale

  base_colour <- "gray20"
  base_colour_light <- "gray80"

  define_fonts(symbol = symbol)
  base_family <- "Roboto Plot"

  theme_gray() %+replace%
    theme(
      line = element_line(
        colour = base_colour,
        size = base_line_size,
        linetype = 1,
        lineend = "butt"
      ),
      rect = element_rect(
        fill = "transparent",
        colour = base_colour,
        size = base_rect_size,
        linetype = 1
      ),
      text = element_text(
        family = base_family,
        face = "plain",
        colour = base_colour,
        size = font_size,
        lineheight = 1,
        hjust = 0.5,
        vjust = 0.5,
        angle = 0,
        margin = margin()
      ),

      axis.line = element_line(
        colour = base_colour,
        size = base_line_size*2,
        linetype = 1,
        lineend = "butt"
      ),
      axis.text = element_text(
        size = rel(0.85),
        color = base_colour
      ),
      axis.text.x = element_text(
        margin = margin(t = font_size/4),
        vjust = 1
      ),
      axis.text.x.top = element_text(
        margin = margin(b = font_size/4),
        vjust = 0
      ),
      axis.text.y = element_text(
        margin = margin(r = font_size/4),
        hjust = 1
      ),
      axis.text.y.right = element_text(
        margin = margin(l = font_size/4),
        hjust = 0
      ),
      axis.ticks = element_line(colour = base_colour),
      axis.ticks.length = unit(font_size/4, "pt"),
      axis.title = element_text(
        size = rel(1.05),
        face = "bold",
        colour = base_colour),
      axis.title.x = element_text(
        margin = margin(t = font_size/2),
        vjust = 1
      ),
      axis.title.x.top = element_text(
        margin = margin(b = font_size/2),
        vjust = 0
      ),
      axis.title.y = element_text(
        angle = 90,
        margin = margin(r = font_size*0.75),
        vjust = 0
      ),
      axis.title.y.right = element_text(
        angle = -90,
        margin = margin(l = font_size*0.75),
        vjust = 1
      ),

      legend.background = element_rect(
        fill = "transparent",
        colour = "transparent"),
      legend.spacing = unit(font_size*2, "pt"),
      legend.margin = margin(font_size/2, font_size/2, font_size/2, font_size/2),
      legend.key = element_rect(
        fill = "transparent",
        colour = "transparent"
      ),
      legend.key.size = unit(font_size*1.6, "pt"),
      legend.text = element_text(size = rel(0.85)),
      legend.title = element_text(size = rel(1.05), face = "bold", hjust = 0),
      legend.position = "right",
      legend.justification = "center",
      legend.box = NULL,
      legend.box.margin = margin(0, 0, 0, 0),
      legend.box.background = element_blank(),
      legend.box.spacing = unit(font_size, "pt"),

      panel.background = element_rect(
        fill = "transparent",
        colour = "transparent"
      ),
      panel.border = element_blank(),
      panel.grid = element_line(
        colour = base_colour_light,
        size = base_line_size
      ),
      panel.grid.minor = element_blank(),
      panel.spacing = unit(font_size, "pt"),
      panel.ontop = FALSE,

      strip.background = element_rect(
        fill = "transparent",
        colour = base_colour,
        size = base_line_size*4
      ),
      strip.text = element_text(
        colour = base_colour,
        face = "bold",
        margin = margin(font_size/4, font_size/4, font_size/4, font_size/4)
      ),
      strip.text.y = element_text(angle = -90),
      strip.text.y.left = element_text(angle = 90),
      strip.placement = "inside",
      strip.switch.pad.grid = unit(font_size/4, "pt"),
      strip.switch.pad.wrap = unit(font_size/4, "pt"),

      plot.background = element_rect(
        fill = "transparent",
        color = "transparent"
      ),
      plot.title = element_text(
        size = rel(1.25),
        face = "bold",
        hjust = 0.5,
        vjust = 1,
        margin = margin(b = font_size/2)
      ),
      plot.title.position = "panel",
      plot.subtitle = element_text(
        size = rel(0.95),
        hjust = 0.5,
        vjust = 1,
        margin = margin(b = font_size/2)
      ),
      plot.caption = element_text(
        size = rel(0.8),
        hjust = 1,
        vjust = 1,
        margin = margin(t = font_size/2)
      ),
      plot.caption.position = "panel",
      plot.tag = element_text(
        size = rel(1.25),
        face = "bold",
        hjust = 0.5,
        vjust = 0.5
      ),
      plot.tag.position = "topleft",
      plot.margin = margin(font_size, font_size, font_size, font_size),

      complete = TRUE
    )
}
