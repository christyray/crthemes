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
    strip.text.x = element_blank(),
    strip.background.x = element_blank()
  )
}

#' @rdname theme_cut
#' @export
theme_cut_bottom <- function() {
  theme(
    plot.margin = margin(b = 0),
    axis.title.x.bottom = element_blank(),
    axis.text.x.bottom = element_blank(),
    axis.line.x.bottom = element_blank(),
    axis.ticks.x.bottom = element_blank()
  )
}

#' Reapply the bold font to titles and axes that contain formatted math text
#'
#' Formatted math text ignores the \code{face} argument of
#' \code{\link{element_text}()} and is only styled in bold if the
#' \code{\link{plotmath}} function \code{bold()} is used. To work around that
#' limitation for the various titles in the plot, this function applies the font
#' family that is one step "more bold" to the titles.
#'
#' The required font will be added to the current R session's font registry if
#' is had not been already (see
#' \code{\link[systemfonts:register_font]{registry_fonts()}}). The required font
#' must be included with the theme.
#'
#' @param font Font family that was used in \code{\link{theme_cr}()}, given as
#'   a character vector. The font must be included in the theme fonts; use
#'   \code{\link{font_names}()} to see a list of included fonts and
#'   \code{\link{font_preview}()} to preview a selected font.
#' @param symbol Should the theme overwrite the system default Symbol font with
#'   the theme default font? If \code{TRUE}, \code{fix_bold()} will overwrite
#'   the Symbol font with the bolded font, and this change will persist until
#'   the end of the R session or until
#'   \code{\link[systemfonts:register_font]{clear_registry()}} is used.
#'
#' @return A list containing the theme properties.
#'
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @importFrom ggplot2 theme element_text
#' @export
#'
#' @examples
#' library(ggplot2)
#'
#' df <- data.frame(x = 1:5, y = 1:5, z = c("a", "b", "c", "b", "c"))
#' p <- ggplot(df, aes(x, y, color = z)) +
#'   geom_point() +
#'   labs(
#'   x = bquote(Delta ~ log[10]("Parameter")),
#'   y = "Y-Axis Label",
#'   color = "Legend",
#'   subtitle = "Subtitle Text",
#'   caption = "Caption Text",
#'   tag = "A",
#'   title = bquote(alpha ~ "Regular Text" ~ 1/3)
#' )
#'
#'\dontrun{
#' p + theme_cr() # Uses default scaling and font
#' p + theme_cr(font = "Roboto Medium") # Bolder font
#'}

fix_bold <- function(font = "Roboto Regular", symbol = TRUE) {

  # Determine which font family is used as the bold face for the theme font
  font_path <- systemfonts::registry_fonts() %>%
    dplyr::filter(.data$family == font, .data$style == "Bold")

  # Remove path to get just the file name for the font
  font_path <- gsub(".*/", "", font_path$path)

  # Format the font name without the extension and with correct spaces
  font_name <- gsub("\\.[a-zA-Z]{3,4}", "", font_path)
  font_name <- gsub("-|_", " ", font_name)

  # If the font is not currently registered, register it as a separate family
  if (!font_name %in% font_names()) {
    systemfonts::register_font(
      name = font_name,
      plain = system.file("fonts", font_path, package = "crthemes"),
      features = systemfonts::font_feature(
        ligatures = "standard",
        numbers = "tabular"
      )
    )
  }

  # Register the bold font as the symbol font if updating the symbol font was
  # requested - generally, symbols are more likely to be used in the bolded
  # labels than elsewhere on the plot
  if (symbol == TRUE) {
    symbol_register(font_name)
  }

  # Update the theme elements that are normally styled as bold to use the bold
  # font family
  # Using the "plain" face because the font itself is bold - otherwise, the bold
  # would essentially be applied twice
  theme_bold <- theme(
    axis.title = element_text(family = font_name, face = "plain"),
    legend.title = element_text(family = font_name, face = "plain"),
    strip.text = element_text(family = font_name, face = "plain"),
    plot.title = element_text(family = font_name, face = "plain"),
    plot.tag = element_text(family = font_name, face = "plain")
  )

  return(theme_bold)
}
