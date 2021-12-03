#' Print information and previews of the color palettes
#'
#' \code{pal_names()} displays the list of the palette names currently included
#' in \code{pal}. \code{pal_table()} generates a formatted \code{tibble} with
#' information on the properties of all of the included palettes.
#' \code{pal_colors()} displays the palette tibble for the selected palette.
#' \code{pal_preview()} displays a simple preview of the selected colors in the
#' graphics window, based on the \code{\link[scales]{show_col}()} function from
#' the \code{\link[scales]{scales}} package.
#'
#' @inheritParams pal_select
#' @param label What text to use for the color preview labels, options are
#'   \code{color}, \code{hex}, or \code{species}, default is \code{color}
#' @param columns How many columns to use for the color preview, defaults to
#'   approximately square
#'
#' @section Table Format:
#'   For \code{pal_table()}: \describe{\item{\code{Name}}{The palette name, used
#'   in the \code{pal_*()} functions} \item{\code{Key}}{Logical value, if the
#'   palette is one of the main, standard palettes} \item{\code{Named}}{Logical
#'   value, if the palette table contains a \code{name} column with species
#'   names} \item{\code{Type}}{Factor, what category of information should be
#'   depicted each palette} \item{\code{Length}}{Integer, number of colors in
#'   palette} \item{\code{Brightness}}{Factor, is palette the Standard version,
#'   Light, or Dark}}
#'
#' @export
#'
#' @examples
#' pal_preview("antibodies", label = "species", columns = 2)
#' pal_preview("receptors", species = c("IL6R", "IL6R-Ab"), label = "hex")

pal_preview <- function(palette = names(pal), ncol = NULL, colors = NULL,
                        species = NULL, alpha = 1, label = NULL, columns = NULL) {
  pal_check(palette)

  label <- match.arg(label, choices = c("color", "species", "hex"))

  pal_cr <- pal_select(palette = palette, ncol = ncol, colors = colors,
                           species = species, alpha = alpha)

  # Select only the non-alpha component of the hex code for matching
  pal_hex <- substr(pal_cr, 1, 7)

  labels <- dplyr::filter(
    pal[[palette]][["colors"]],
    .data$hex %in% pal_hex
  )[[label]]

  color_preview(pal_cr, labels = labels, columns = columns)
  invisible("")
}

#' @rdname pal_preview
#' @export
pal_names <- function() {
  names(pal)
}

#' @rdname pal_preview
#' @export
pal_colors <- function(palette = names(pal)) {

  pal_check(palette)

  pal[[palette]][["colors"]]
}

#' @rdname pal_preview
#' @export
pal_table <- function() {
  table <- do.call(rbind, lapply(pal, "[[", "properties"))
  table$Type <- factor(table$Type)
  table$Brightness <- factor(table$Brightness)
  table
}

#' Quick matrix preview of colors
#'
#' Adapted from \code{\link[scales]{show_col}()} from the
#' \code{\link[scales]{scales}} package. Modified to allow for custom labels.
#'
#' @param colors A character vector of colors
#' @param labels A character vector of labels corresponding to \code{colors}
#' @param columns Number of columns. If not supplied, tried to be as square as
#'   possible.
#'
#' @importFrom graphics par rect text

# Copy of the show_col function from scales package; modified to allow for
# custom labels
color_preview <- function(colors, labels, columns) {
  n <- length(colors)

  # Calculate the number of columns if it was not provided
  ncol <- columns %||% ceiling(sqrt(length(colors)))
  nrow <- ceiling(n / ncol)

  colors <- c(colors, rep(NA, nrow * ncol - length(colors)))
  colors <- matrix(colors, ncol = ncol, byrow = TRUE)
  labels <- c(labels, rep(NA, nrow * ncol - length(labels)))
  labels <- matrix(labels, ncol = ncol, byrow = TRUE)

  old <- par(pty = "s", mar = c(0, 0, 0, 0))
  on.exit(par(old))

  size <- max(dim(colors))
  plot(c(0, size), c(0, -size), type = "n", xlab = "", ylab = "", axes = FALSE)
  rect(col(colors) - 1, -row(colors) + 1, col(colors), -row(colors),
       col = colors, border = NULL)

  # Farver package is used to set the labels to black or white depending on
  # how dark the background color is
  hcl <- farver::decode_colour(colors, "rgb", "hcl")
  label_col <- ifelse(hcl[, "l"] > 50, "black", "white")

  text(col(colors) - 0.5, -row(colors) + 0.5, labels, cex = 1, col = label_col)
}
