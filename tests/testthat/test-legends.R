library(ggplot2)

# Fill Legend -------------------------------------------------------------

test_that("legend spacing is increased with key function", {
  df <- data.frame(
    x = factor(c("IL6R", "IL8R", "IL6R-Ab", "IL8R-Ab", "IL6R-Ab-IL8R"),
               levels = c("IL6R", "IL8R", "IL6R-Ab", "IL8R-Ab", "IL6R-Ab-IL8R")),
    y = c(0.45, 0.78, 0.61, 0.31, 0.72))
  p <- ggplot(df, aes(x, y, fill = x))

  expect_snapshot_plot("bar graph legend spacing default",
    p + geom_col()
  )

  expect_snapshot_plot("bar graph legend spacing increased",
    p + geom_col(key_glyph = key_scale())
  )

  expect_snapshot_plot("bar graph legend spacing increased more",
    p + geom_col(key_glyph = key_scale(0.5))
  )
})

test_that("legend spacing scales with plot scale", {
  df <- data.frame(
    x = factor(c("IL6R", "IL8R", "IL6R-Ab", "IL8R-Ab", "IL6R-Ab-IL8R"),
               levels = c("IL6R", "IL8R", "IL6R-Ab", "IL8R-Ab", "IL6R-Ab-IL8R")),
    y = c(0.45, 0.78, 0.61, 0.31, 0.72))
  p <- ggplot(df, aes(x, y, fill = x))

  expect_snapshot_plot("bar graph plot size normal",
    p + geom_col(key_glyph = "polygon2") + theme_cr(cairo = TRUE, font = "")
  )

  expect_snapshot_plot("bar graph plot size increased",
    p + geom_col(key_glyph = "polygon2") +
      theme_cr(base_scale = 1.5, cairo = TRUE, font = ""),
    width = 9, height = 6
  )

  expect_snapshot_plot("bar graph plot size decreased",
    p + geom_col(key_glyph = "polygon2") +
      theme_cr(base_scale = 2/3, cairo = TRUE, font = ""),
    width = 4, height = 2.667
  )
})

# Heatmap Legend ----------------------------------------------------------

test_that("heatmap legend is longer", {
  p <- ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
    geom_raster()

  expect_snapshot_plot("heatmap legend default",
    p + scale_fill_binned() +
      theme_cr(cairo = TRUE, font = "")
  )

  expect_snapshot_plot("heatmap legend theme applied",
    p + scale_fill_binned(guide = heatmap_legend()) +
      theme_cr(cairo = TRUE, font = "")
  )
})

test_that("heatmap legend scales with plot scale", {
  p <- ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
    geom_raster()

  expect_snapshot_plot("heatmap legend plot size normal",
    p + theme_cr(cairo = TRUE, font = "") +
      scale_fill_binned(guide = heatmap_legend())
  )

  expect_snapshot_plot("heatmap legend plot size increased",
    p + theme_cr(base_scale = 1.5, cairo = TRUE, font = "") +
      scale_fill_binned(guide = heatmap_legend(base_scale = 1.5)),
    width = 9, height = 6
  )

  expect_snapshot_plot("heatmap legend plot size decreased",
    p + theme_cr(base_scale = 2/3, cairo = TRUE, font = "") +
      scale_fill_binned(guide = heatmap_legend(base_scale = 2/3)),
    width = 4, height = 2.667
  )
})
