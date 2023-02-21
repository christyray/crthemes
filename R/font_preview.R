#' Print information and previews of the fonts
#'
#' \code{font_names()} displays the list of the fonts currently included in
#' \code{font_register()}. \code{font_table()} generates a formatted
#' \code{tibble} with information on the properties of all of the included
#' fonts. \code{font_styles()} displays the included styles for a selected font.
#' \code{font_preview()} displays a simple preview of the selected font in the
#' graphics window. The preview requires the \code{\link[ragg]{ragg}} package
#' and the RStudio graphics backend to be set to `AGG` to display correctly.
#'
#' @param font Which font family to preview; defaults to "Roboto Medium"
#'
#' @section Table Format: For \code{font_table()}:
#'   \describe{\item{\code{family}}{The font family name, used in the
#'   \code{font_*()} functions} \item{\code{style}}{The included styles for each
#'   font family} \item{\code{weight}}{If the style is bold or normal weight}
#'   \item{\code{italic}}{If the style is italicized or not}
#'   \item{\code{features}}{What font features are included in the registered
#'   fonts (like ligatures, tabular numbers, etc.)}}
#'
#' @export
#'
#' @examples
#' \dontrun{
#' font_preview(font = "Roboto Light")
#' }

font_preview <- function(font = "Roboto Regular") {
  if (options("RStudioGD.backend") != "ragg") {
    warning("The RStudio device must be set to `AGG` to display fonts correctly.
         You can change the device under:
         Tools > Global Options > General > Graphics > Backend")
  }

  ggplot2::ggplot(NULL, ggplot2::aes(x = 1, y = 1)) +
    ggplot2::ylim(0.5, 1.5) +
    ggplot2::annotate(
      geom = "text",
      x = 1, y = 1.4,
      label = deparse1(bquote("Regular Text")),
      parse = TRUE,
      family = font,
      size = 12
    ) +
    ggplot2::annotate(
      geom = "text",
      x = 1, y = 1.2,
      label = deparse1(bquote(bold("Bold Text"))),
      parse = TRUE,
      family = font,
      size = 12
    ) +
    ggplot2::annotate(
      geom = "text",
      x = 1, y = 1,
      label = deparse1(bquote(italic("Italic Text"))),
      parse = TRUE,
      family = font,
      size = 12
    ) +
    ggplot2::annotate(
      geom = "text",
      x = 1, y = 0.8,
      label = deparse1(bquote(bolditalic("Bold-Italic Text"))),
      parse = TRUE,
      family = font,
      size = 12
    ) +
    ggplot2::annotate(
      geom = "text",
      x = 1, y = 0.6,
      label = deparse1(bquote(
        alpha ~ "," ~ omega ~ "," ~ infinity ~ "," ~ partialdiff
      )),
      parse = TRUE,
      family = font,
      size = 12
    ) +
    ggplot2::theme_void()
}

#' @rdname font_preview
#' @export
font_names <- function() {
  sort(unique(systemfonts::registry_fonts()$family))
}

#' @rdname font_preview
#' @export
font_styles <- function(font = "Roboto Regular") {
  table <- dplyr::filter(
    systemfonts::registry_fonts(),
    .data$family == font
  )
  table$style
}

#' @rdname font_preview
#' @export
font_table <- function() {
  systemfonts::registry_fonts() %>%
    dplyr::select(
      "family",
      "style",
      "weight",
      "italic",
      "features"
    ) %>%
    dplyr::arrange(.data$family)
}
