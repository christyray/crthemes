# Helper functions to use expect_snapshot_file()

# Create a file from the code, and return the path
save_png <- function(plot_object, width = 6, height = 4) {
  path <- tempfile(fileext = ".png")

  if (requireNamespace("ragg", quietly = TRUE)) {
    ragg::agg_png(path, width, height, units = "in", res = 300)
  } else {
    png(path, width, height, units = "in", res = 300)
  }

  if ("ggplot" %in% class(plot_object)) {
    print(plot_object)
  } else if ("character" %in% class(plot_object)) {
    eval(parse(text=plot_object))
  }
  on.exit(dev.off())

  path
}

# Wrapper for expect_snapshot_file() that announces the file before it generates
# the plot, ensures that if the plot code does not run correctly, testthat will
# not delete the previous snapshot
expect_snapshot_plot <- function(name, plot_object, width = 6, height = 4) {

  # Add name as plot title
  if ("ggplot" %in% class(plot_object)) {
    plot_object <- plot_object + ggplot2::ggtitle(name)
  }

  # Clean up name
  name <- tolower(name)
  name <- gsub(" ", "-", name)
  name <- gsub(",", "", name)
  name <- paste0(name, ".png")

  announce_snapshot_file(name)

  path <- save_png(plot_object, width = width, height = height)
  expect_snapshot_file(path, name)
}
