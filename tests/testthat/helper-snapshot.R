# Helper functions to use expect_snapshot_file()

# Plots -------------------------------------------------------------------

# Create a file from the code, and return the path
save_png <- function(plot_object, width = 6, height = 4) {
  path <- tempfile(fileext = ".png")

  ragg::agg_png(path, width, height, units = "in", res = 300)

  if ("ggplot" %in% class(plot_object)) {
    print(plot_object)
  } else if ("character" %in% class(plot_object)) {
    eval(parse(text = plot_object))
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

# Text Files --------------------------------------------------------------

save_txt <- function(data_object) {
  path <- tempfile(fileext = ".txt")
  write.table(data_object, path)
  path
}

expect_snapshot_text <- function(name, data_object) {

  # Clean up name
  name <- tolower(name)
  name <- gsub(" ", "-", name)
  name <- gsub(",", "", name)
  name <- paste0(name, ".txt")

  announce_snapshot_file(name)
  path <- save_txt(data_object)
  expect_snapshot_file(path, name)
}

# Package Save Function ---------------------------------------------------
save_test <- function(plot_object, type, ...) {
  path <- tempfile(fileext = paste0(".", type))
  crsave(plot_object, path = path, type = type, ...)
  path
}

expect_snapshot_crplot <- function(name, plot_object, type, ...) {

  # Add name as plot title
  if ("ggplot" %in% class(plot_object)) {
    plot_object <- plot_object + ggplot2::ggtitle(name)
  }

  # Clean up name
  name <- tolower(name)
  name <- gsub(" ", "-", name)
  name <- gsub(",", "", name)
  name <- paste0(name, ".", type)

  announce_snapshot_file(name)

  path <- save_test(plot_object, type, ...)
  expect_snapshot_file(path, name)
}
