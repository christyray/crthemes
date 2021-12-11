#' Wrapper function to save a ggplot with particular defaults
#'
#' @param plot_object A ggplot object
#' @param path File name or file path to save the file; defaults to the working
#'   directory and the `plot_object` variable name
#' @param type Type of file to save the graphic to; defaults to the path
#'   extension or `PNG` if no type or extension given
#' @param device Which graphics device to use for saving; uses default devices
#'   for main file types
#' @param base_scale Scaling factor for the plot output, written to be
#'   compatible with the theme scaling; factor of 1 corresponds to a 6" x 4"
#'   image
#' @param width Width of plot image; default is 6"
#' @param ratio Aspect ratio of plot image; default is 1.5
#' @param units Units for plot width; default is "in"
#' @param dpi Resolution for plot image in pixels per inch; default is 600
#' @param ... Other arguments to be passed to the graphics device function or
#'   \code{\link[ggplot2]{ggsave}}
#'
#' @export

crsave <- function(plot_object, path = NULL, type = NULL, device = NULL,
                   base_scale = 1, width = NULL, ratio = 1.5, units = "in",
                   dpi = 600, ...) {

  plotname <- deparse1(substitute(plot_object, environment()))
  file <- path_create(plotname, path = path, type = type)
  path <- file[[1]]
  type <- file[[2]]

  device <- device %||% device_select(type)

  width <- width %||% 6 * base_scale
  height <- width / ratio

  ggplot2::ggsave(
    path,
    plot = plot_object,
    device = device,
    width = width,
    height = height,
    units = units,
    dpi = dpi,
    ...
  )
}

#' Helper function to create path for saving the ggplot file
#'
#' @inheritParams crsave
#'
#' @param plotname Plot object variable name converted to a character vector

path_create <- function(plotname, path = NULL, type = NULL) {

  type <- type %keepnull% tolower(type)

  # No path or extension given; default to PNG
  if (is.null(path) && is.null(type)) {
    type <- "png"
  }

  # No path given; create path to working directory with variable name
  path <- path %||%
    paste0(getwd(), "/", plotname)

  # Path given; get extension name
  if (grepl(".*\\.(.{2,4})$", path)) {
    ext <- tolower(sub(".*\\.(.{2,4})$", "\\1", path))

    # Rebuild path with lowercase extension
    basename <- sub("(.*)\\..{2,4}$", "\\1", path)
    path <- paste0(basename, ".", ext)

    # Path and extension both given and not the same; throw error
    if (!is.null(type) && type != ext) {
      stop("The extension of `path` and `type` are not the same")
    }

    # Extension given; use with path to create full path
  } else if (!is.null(type)) {
    ext <- tolower(type)
    path <- paste0(path, ".", ext)
  }

  list(path, tolower(ext))
}

#' Helper function to select default graphics device from file type
#'
#' @inheritParams crsave

device_select <- function(type) {
  switch(type,
         png = ragg::agg_png,
         jpeg = ragg::agg_jpeg,
         jpg = ragg::agg_jpeg,
         tiff = ragg::agg_tiff,
         tif = ragg::agg_tiff,
         svg = svglite::svglite,
         eps = grDevices::cairo_ps,
         pdf = grDevices::cairo_pdf,
         stop("Selected `device` does not exist")
  )
}
