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
    p + geom_col(key_glyph = "polygon2")
  )
})

test_that("legend spacing scales with plot scale", {
  df <- data.frame(
    x = factor(c("IL6R", "IL8R", "IL6R-Ab", "IL8R-Ab", "IL6R-Ab-IL8R"),
               levels = c("IL6R", "IL8R", "IL6R-Ab", "IL8R-Ab", "IL6R-Ab-IL8R")),
    y = c(0.45, 0.78, 0.61, 0.31, 0.72))
  p <- ggplot(df, aes(x, y, fill = x))

  expect_snapshot_plot("bar graph plot size normal",
    p + geom_col(key_glyph = "polygon2") + theme_cr()
  )

  expect_snapshot_plot("bar graph plot size increased",
    p + geom_col(key_glyph = "polygon2") + theme_cr(base_scale = 1.5),
    width = 9, height = 6
  )

  expect_snapshot_plot("bar graph plot size decreased",
    p + geom_col(key_glyph = "polygon2") + theme_cr(base_scale = 2/3),
    width = 4, height = 2.667
  )
})

# Heatmap Legend ----------------------------------------------------------

test_that("heatmap legend is longer", {
  p <- ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
    geom_raster()

  expect_snapshot_plot("heatmap legend default",
    p + scale_fill_distiller(palette = "YlGn")
  )

  expect_snapshot_plot("heatmap legend theme applied",
    p + scale_fill_distiller(palette = "YlGn", guide = heatmap_legend())
  )
})

test_that("heatmap legend scales with plot scale", {
  p <- ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
    geom_raster()

  expect_snapshot_plot("heatmap legend plot size normal",
    p + theme_cr() +
      scale_fill_distiller(palette = "YlGn", guide = heatmap_legend())
  )

  expect_snapshot_plot("heatmap legend plot size increased",
    p + theme_cr(base_scale = 1.5) +
      scale_fill_distiller(palette = "YlGn",
                           guide = heatmap_legend(base_scale = 1.5)),
    width = 9, height = 6
  )

  expect_snapshot_plot("heatmap legend plot size decreased",
    p + theme_cr(base_scale = 2/3) +
      scale_fill_distiller(palette = "YlGn",
                           guide = heatmap_legend(base_scale = 2/3)),
    width = 4, height = 2.667
  )
})
