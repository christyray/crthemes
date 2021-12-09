#' Select from the defined color palettes
#'
#' This selects hex codes from the palettes defined in the internal \code{pal}
#' dataset. The list of available palettes can be previewed with
#' \code{\link{pal_names}()}. Subsets of colors can be selected with the
#' \code{ncol}, \code{colors}, or \code{species} arguments. Only one selection
#' method can be used in the function call. If no selection method is provided,
#' the function will return the full color palette with color names.
#'
#' @param palette Character vector of length 1 defining the palette to select
#'   colors from; use \code{\link{pal_names}()} to see a list of available
#'   palettes, default palette is named "default"
#' @param ncol Range of colors to select from \code{palette}; if only one number
#'   is provided, it will be the number of colors selected; can only use one
#'   selection technique
#' @param colors Names of colors to select from \code{palette}, given as a
#'   character vector; can only use one selection technique
#' @param species Names of species to select from \code{palette} (e.g., "IL6" or
#'   "Tocilizumab"), given as a character vector; can only use one selection
#'   technique
#' @param alpha new alpha level in \[0,1].  If alpha is `NA`, existing alpha
#'   values are preserved. Default is `1`. Uses \code{\link[scales]{alpha}()} to
#'   set the alpha value
#'
#' @return A named character vector with the hex codes of the selected colors.
#'   Color names are given for \code{ncol} and \code{colors} selections, and
#'   species names are given for \code{species} selection.
#'
#' @importFrom rlang .data .env
#' @export
#'
#' @examples
#' pal_select("receptors")
#' pal_select("receptors", ncol = 3)
#' pal_select("receptors", ncol = c(2,5))
#' pal_select("receptors", colors = c("lightred", "red", "orange"))
#' pal_select("receptors", species = c("IL8", "IL8R", "IL8R-Ab"))

pal_select <- function(palette = "default", ncol = NULL, colors = NULL,
                       species = NULL, alpha = 1) {

  pal_check(palette)

  if (sum(!is.null(ncol), !is.null(colors), !is.null(species)) > 1) {
    stop(
      "Can only provide values for one of `ncol`, `colors`, or `species`"
    )
  } else if (!is.null(ncol)) {
    if (length(ncol) > 2) {
      stop(
        "`ncol` can only be 1 number (the number of colors to return),
           or 2 numbers (the start and end of the range of colors to return)"
        )
    } else if (length(ncol) == 1) {
      ncol <- c(1,ncol)
    }
    pal_out <- pal[[palette]][["colors"]][ncol[1]:ncol[2], c("color", "hex")]
  } else if (!is.null(colors)) {
    pal_out <- dplyr::filter(
      pal[[palette]][["colors"]],
      .data$color %in% colors
    ) %>%
      dplyr::arrange(match(.data$color, colors))

    if (nrow(pal_out) == 0) {
      warning(
        "No entries matched `colors` argument. Did you mean `species` instead?"
      )
    }

    pal_out <- pal_out[c("color", "hex")]

  } else if (!is.null(species)) {
    pal_out <- dplyr::filter(
      pal[[palette]][["colors"]],
      .data$species %in% .env$species
    ) %>%
      dplyr::arrange(match(.data$species, .env$species))

    if (nrow(pal_out) == 0) {
      warning(
        "No entries matched `species` argument. Did you mean `colors` instead?"
      )
    }

    pal_out <- pal_out[c("species", "hex")]

  } else {
    pal_out <- pal[[palette]][["colors"]][c("color", "hex")]
  }
  pal_out <- tibble::deframe(pal_out)

  # Apply provided alpha value
  return(scales::alpha(pal_out, alpha))
}

#' Check if the palette argument is formatted correctly
#'
#' @inheritParams pal_select

pal_check <- function(palette = "default") {
  if (!is.character(palette)) {
    stop("`palette` must be a character vector of length 1 specifying a color
         palette contained in `pal`")
  } else if (length(palette) > 1) {
    stop("`palette` must define a single palette to use, not multiple")
  }

  palette <- match.arg(palette, choices = names(pal))
}
