library(ggplot2)

# scale_color_cr() --------------------------------------------------------

test_that("color scale is applied to graph", {
  df <- data.frame(x = 1:5, y = 1:5, z = c("IL6", "IL8", "IL6R", "IL6", "IL8R"))
  p <- ggplot(df, aes(x, y, color = z)) +
    geom_point()

  expect_snapshot_plot("default colors, no matching",
    p + scale_color_cr("default") + theme_cr(cairo = TRUE, font = "")
  )

  expect_snapshot_plot("select colors by color name",
    p + scale_color_cr(
      "receptors",
      ncol = NULL, species = NULL,
      colors = c("orange", "green", "darkblue", "yellow")
    ) + theme_cr(cairo = TRUE, font = "")
  )

  expect_snapshot_plot("select colors by species name",
    p + scale_color_cr(
      "receptors",
      ncol = NULL, colors = NULL,
      species = unique(df$z)
    ) + theme_cr(cairo = TRUE, font = "")
  )

  expect_snapshot_plot("select colors by number",
    p + scale_color_cr(
      "receptors",
      colors = NULL, species = NULL,
      ncol = c(2,5)
    ) + theme_cr(cairo = TRUE, font = "")
  )

  expect_snapshot_plot("can rename color legend with name argument",
    p + scale_color_cr(
      "receptors",
      colors = NULL, species = NULL, ncol = NULL,
      name = "Species"
    ) + theme_cr(cairo = TRUE, font = "")
  )

  expect_snapshot_plot("alpha value modifies color",
    p + scale_color_cr(
      "receptors",
      colors = NULL, species = NULL,
      ncol = c(2,5),
      alpha = 0.5
    ) + theme_cr(cairo = TRUE, font = "")
  )

  expect_snapshot_plot("alpha also works in geom_point",
    ggplot(df, aes(x, y, color = z)) +
      geom_point(alpha = 0.5) +
      scale_color_cr(
        "receptors",
        species = NULL, colors = NULL,
        ncol = c(2,5)
      ) + theme_cr(cairo = TRUE, font = "")
  )
})

# scale_fill_cr() ---------------------------------------------------------

test_that("fill scale is applied to graph", {
  df <- data.frame(
    x = factor(c("IL6R", "IL8R", "IL6R-Ab", "IL8R-Ab", "IL6R-Ab-IL8R"),
               levels = c("IL6R", "IL8R", "IL6R-Ab", "IL8R-Ab", "IL6R-Ab-IL8R")),
    y = c(0.45, 0.78, 0.61, 0.31, 0.72))
  p <- ggplot(df, aes(x, y, fill = x)) +
    geom_col()

  expect_snapshot_plot("default fill, no matching",
    p + scale_fill_cr("default") + theme_cr(cairo = TRUE, font = "")
  )

  expect_snapshot_plot("select fill by color name",
    p + scale_fill_cr(
      "receptors",
      species = NULL, ncol = NULL,
      colors = c("orange", "green", "darkblue", "yellow", "lightblue")
    ) + theme_cr(cairo = TRUE, font = "")
  )

  expect_snapshot_plot("select fill by species name",
    p + scale_fill_cr(
      "receptors",
      ncol = NULL, colors = NULL,
      species = unique(df$x)
    ) + theme_cr(cairo = TRUE, font = "")
  )

  expect_snapshot_plot("select fill by number",
    p + scale_fill_cr(
      "receptors",
      colors = NULL, species = NULL,
      ncol = c(2,6)
    ) + theme_cr(cairo = TRUE, font = "")
  )

  expect_snapshot_plot("can rename fill legend with name argument",
    p + scale_fill_cr(
      "receptors",
      colors = NULL, species = NULL, ncol = NULL,
      name = "Species"
    ) + theme_cr(cairo = TRUE, font = "")
  )

  expect_snapshot_plot("alpha value modifies fill",
    p + scale_fill_cr(
      "receptors",
      colors = NULL, species = NULL,
      ncol = c(2,6),
      alpha = 0.5
    ) + theme_cr(cairo = TRUE, font = "")
  )

  expect_snapshot_plot("alpha also works in geom_col",
    ggplot(df, aes(x, y, fill = x)) +
      geom_col(alpha = 0.5) +
      scale_fill_cr(
        "receptors",
        colors = NULL, species = NULL,
        ncol = c(2,6)
      ) + theme_cr(cairo = TRUE, font = "")
  )
})

# scale_cr() and theme_cr() -----------------------------------------------

test_that("scale and theme functions can be added together", {
  df <- data.frame(x = 1:5, y = 1:5, z = c("IL6", "IL8", "IL6R", "IL6", "IL8R"))
  p <- ggplot(df, aes(x, y, color = z)) +
    geom_point()

  expect_snapshot_plot("theme and color scale",
    p + scale_color_cr("receptors") + theme_cr(cairo = TRUE, font = "")
  )

  df <- data.frame(
    x = factor(c("IL6R", "IL8R", "IL6R-Ab", "IL8R-Ab", "IL6R-Ab-IL8R"),
               levels = c("IL6R", "IL8R", "IL6R-Ab", "IL8R-Ab", "IL6R-Ab-IL8R")),
    y = c(0.45, 0.78, 0.61, 0.31, 0.72))
  p <- ggplot(df, aes(x, y, fill = x)) +
    geom_col()

  expect_snapshot_plot("theme and fill scale",
    p + scale_fill_cr("receptors") + theme_cr(cairo = TRUE, font = "")
  )

})
