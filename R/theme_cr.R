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
#'   corresponds to a font size of 12 pt and a figure size of 6" by 4"
#' @param font_scale Scaling factor for the font as compared to the plot. A
#'   value of 1 will scale the font to the plot size. Larger numbers make the
#'   font large compared to the plot size; smaller numbers make the font small
#'   compared to the plot size.
#' @param font Font family to be used in the theme, given as character vector.
#'   The font must be included in the theme fonts; use
#'   \code{\link{font_names}()} to see a list of included fonts and
#'   \code{\link{font_preview}()} to preview a selected font.
#' @param symbol Should the theme overwrite the system default Symbol font with
#'   the theme default font? If \code{TRUE}, \code{theme_cr()} will overwrite
#'   the Symbol font, and this change will persist until the end of the R
#'   session or until \code{\link[systemfonts:register_font]{clear_registry()}}
#'   is used.
#' @param cairo Is a cairographics device being used to save the figure? ("pdf"
#'   and "eps" filetypes) Cairo does not use the font registration from the
#'   \code{\link[systemfonts]{systemfonts}} package, so an alternate cairo-safe
#'   font must be provided and the normal font registration will be skipped.
#'
#' @return A list containing the theme properties.
#'
#' @importFrom ggplot2 theme_gray %+replace% theme element_line element_rect
#'   element_text element_blank margin rel
#' @importFrom grid unit
#' @export
#'
#' @examples
#' library(ggplot2)
#'
#' df <- data.frame(x = 1:5, y = 1:5, z = c("a", "b", "c", "b", "c"))
#' p <- ggplot(df, aes(x, y, color = z)) + geom_point()
#'
#'\dontrun{
#' p + theme_cr() # Uses default scaling and font
#' p + theme_cr(font = "Roboto Medium") # Bolder font
#' p + theme_cr(base_scale = 2) # Multiply height and width of the plot by 2
#' p + theme_cr(font = "Roboto Medium", symbol = FALSE) # Use system Symbol font
#' p + theme_cr(font = "Avenir", cairo = TRUE) # Use a cairo-safe font
#'}

theme_cr <- function(base_scale = 1, font_scale = 1,
                     font = "Roboto Regular", symbol = TRUE, cairo = FALSE) {

  # Import fonts from the font folder
  if (cairo == FALSE) {
    font_register()

    # Register Symbol font if requested
    if (symbol == TRUE) {
      symbol_register(font)
    }
    # Check that selected font is registered
    font <- match.arg(font, choices = font_names())
  } else {
    # Skip font import if using cairographics device
    font = font
  }

  # Define sizing based on input scale
  base_size <- base_scale*12
  base_line_size <- base_size/50
  base_rect_size <- base_size/50

  # Apply the font scale to the font size
  font_size <- base_size*font_scale

  base_colour <- "gray20"
  base_colour_medium <- "gray30"
  base_colour_light <- "gray80"

  # Update the geom sizes based on the plot scaling, update color
  geom_scaling(scale_factor = base_scale, base_colour = base_colour)

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
        family = font,
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
        size = rel(0.9),
        color = base_colour_medium
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
      axis.ticks.length = unit(font_size/3, "pt"),
      axis.title = element_text(
        size = rel(1.1),
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
      legend.text = element_text(size = rel(0.9), color = base_colour_medium),
      legend.title = element_text(
        size = rel(1.1),
        color = base_colour,
        face = "bold",
        hjust = 0
      ),
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
        fill = "white",
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
      plot.margin = margin(font_size, font_size, font_size, font_size)
    )
}
