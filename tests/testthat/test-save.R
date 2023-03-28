library(ggplot2)

# path_create() -----------------------------------------------------------

test_that("path_create will build a default path", {
  expect_type(path_create("plot"), "list")
  expect_length(path_create("plot"), 2)
  expect_equal(path_create("plot")[[2]], "png")
})

test_that("path_create will get extension from file path", {
  expect_equal(path_create("plot", path = "plot.jpeg")[[2]], "jpeg")
  expect_equal(path_create("plot", path = "plot.TIFF")[[2]], "tiff")
  expect_equal(path_create("plot", path = "plOt.pnG")[[1]], "plOt.png")
  expect_equal(path_create("plot", path = "plOt.pnG")[[2]], "png")
})

test_that("path_create will create file path from extension", {
  expect_equal(
    path_create("plot", type = "jpeg")[[1]],
    paste0(getwd(), "/", "plot.jpeg")
  )
  expect_equal(
    path_create("plot", type = "PNG")[[1]],
    paste0(getwd(), "/", "plot.png")
  )
  expect_equal(
    path_create("plOt", type = "TIff")[[1]],
    paste0(getwd(), "/", "plOt.tiff")
  )
})

test_that("path_create throws an error if the extensions don't match", {
  expect_error(path_create("plot", path = "test.jpg", type = "png"))
  expect_equal(path_create("plot", path = "test.jpg", type = "JPG")[[2]], "jpg")
  expect_equal(path_create("plot", path = "TeSt.JpG", type = "jpg")[[2]], "jpg")
})

# device_select() ---------------------------------------------------------

test_that("device_select correctly selects graphics device", {
  expect_equal(device_select("jpg"), ragg::agg_jpeg)
  expect_equal(device_select("tiff"), ragg::agg_tiff)
  expect_equal(device_select("pdf"), cairo_pdf)
  expect_error(device_select("unknown"))
})

# Visual tests ------------------------------------------------------------

# All of these will be skipped with automated checking because anything that
# relies on ragg for plotting isn't compatible

test_that("crsave can save ggplots", {
  df <- data.frame(x = 1:5, y = 1:5, z = c("a", "b", "c", "b", "c"))
  p <- ggplot(df, aes(x, y, color = z)) +
    geom_point() +
    theme_cr()

  expect_snapshot_crplot("save as png", p, "png")
  expect_snapshot_crplot("save as jpeg", p, "jpeg")
  expect_snapshot_crplot("save as jpg", p, "jpg")

})

test_that("crsave can save with cairographics", {
  df <- data.frame(x = 1:5, y = 1:5, z = c("a", "b", "c", "b", "c"))
  p <- ggplot(df, aes(x, y, color = z)) +
    geom_point() +
    theme_cr(cairo = TRUE, font = "Helvetica")

  # The expect_snapshot_file() function has not been working with testthat, but
  # the saved PDF output is still working correctly - will have to save and
  # compare manually
  # expect_snapshot_crplot("save as pdf", p, "pdf")
  expect_snapshot_crplot("save as svg", p, "svg")

})

test_that("different devices work", {
  df <- data.frame(x = 1:5, y = 1:5, z = c("a", "b", "c", "b", "c"))
  p <- ggplot(df, aes(x, y, color = z)) +
    geom_point() +
    theme_cr(cairo = TRUE, font = "Helvetica")

  expect_snapshot_crplot("R png device", p, "png", device = png)

})

test_that("aspect ratio, width, and scaling are applied", {
  df <- data.frame(x = 1:5, y = 1:5, z = c("a", "b", "c", "b", "c"))
  p <- ggplot(df, aes(x, y, color = z)) +
    geom_point() +
    theme_cr()

  expect_snapshot_crplot("different width, wider", p, "png", width = 9)
  expect_snapshot_crplot("different ratio, square", p, "png", ratio = 1)
  expect_snapshot_crplot("different scale, smaller", p, "png", base_scale = 0.5)
  expect_snapshot_crplot("different units, smaller", p, "png", units = "cm")
  expect_snapshot_crplot("different resolution, worse", p, "png", dpi = 100)
})

test_that("theme and save scaling interact correctly", {
  df <- data.frame(x = 1:5, y = 1:5, z = c("a", "b", "c", "b", "c"))
  p <- ggplot(df, aes(x, y, color = z)) +
    geom_point()

  expect_snapshot_crplot("scaled up theme and save",
    p + theme_cr(plot_scale = 2), "png", width = 12
  )

  expect_snapshot_crplot("scaled down theme and save, large font",
    p + theme_cr(plot_scale = 0.5, font_scale = 2), "png", width = 3
  )
})
