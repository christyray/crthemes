#' Custom color palette scale functions for ggplot2
#'
#' Uses the provided color \code{palette} for the \code{color} or \code{fill}
#' aesthetics of a ggplot2 object. The function will use
#' \code{\link[ggplot2]{scale_discrete}} when the colors are selected with
#' \code{ncol} or \code{colors} and will use \code{\link[ggplot2]{scale_manual}}
#' when the colors are selected with \code{names}.
#'
#' @inheritParams pal_select
#' @param ... Additional parameters for \code{\link[ggplot2]{discrete_scale}}
#'
#' @examples
#' library(ggplot2)
#'
#' df <- data.frame(x = 1:5, y = 1:5, z = c("IL6", "IL8", "IL6R", "IL6", "IL8"))
#' p <- ggplot(df, aes(x, y, color = z)) + geom_point()
#'
#' # Using the colors without name-matching
#' p + scale_color_cr(palette = "receptors")
#'
#' # Matching the colors to the species names
#' p + scale_color_cr(palette = "receptors", species = unique(df$z))
#'
#' @name scale_cr
NULL

#' @rdname scale_cr
#' @export
scale_color_cr <- function(palette = names(pal), ncol = NULL, colors = NULL,
                           species = NULL, alpha = 1, ...) {

  if (!is.character(palette)) {
    stop("`palette` must be a character vector specifying a color palette
          contained in `pal`")
  }

  palette <- match.arg(palette)
  pal_cr <- pal_select(
    palette,
    ncol = ncol,
    colors = colors,
    species = species,
    alpha = alpha
  )

  if (!is.null(species)) {
    ggplot2::scale_color_manual(values = pal_cr, ...)
  } else {
    ggplot2::discrete_scale(
      "colour",
      "custom",
      scales::manual_pal(unname(pal_cr)),
      ...
    )
  }
}

#' @rdname scale_cr
#' @export
scale_fill_cr <- function(palette = names(pal), ncol = NULL, colors = NULL,
                           species = NULL, alpha = 1, ...) {

  if (!is.character(palette)) {
    stop("`palette` must be a character vector specifying a color palette
          contained in `pal`")
  }

  palette <- match.arg(palette)
  pal_cr <- pal_select(
    palette,
    ncol = ncol,
    colors = colors,
    species = species,
    alpha = alpha
  )

  if (!is.null(species)) {
    ggplot2::scale_fill_manual(values = pal_cr, ...)
  } else {
    ggplot2::discrete_scale(
      "fill",
      "custom",
      scales::manual_pal(unname(pal_cr)),
      ...
    )
  }
}
