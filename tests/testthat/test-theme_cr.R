library(ggplot2)
library(ggthemes)

test_that("theme_cr runs", {
  expect_s3_class(theme_cr(), "theme")
})

# Visual Tests ------------------------------------------------------------

test_that("theme_cr is applied", {
  df <- data.frame(x = 1:5, y = 1:5)
  p <- ggplot(df, aes(x, y)) +
    geom_point() +
    theme_cr(cairo = TRUE, font = "")
  expect_doppelganger("theme_cr",
    p
  )
})

test_that("plot and font scaling is correct", {
  df <- data.frame(x = 1:5, y = 1:5, z = c("a", "a", "b", "b", "a"))
  p <- ggplot(df, aes(x, y, color = z)) +
    geom_point() +
    labs(
      x = "X-Axis Label",
      y = "Y-Axis Label",
      color = "Legend",
      subtitle = "Subtitle Text",
      caption = "Caption Text",
      tag = "A"
    )

  expect_snapshot_plot("plot and font are default size",
    p + theme_cr(cairo = TRUE, font = ""),
    width = 6, height = 4
  )

  expect_snapshot_plot("plot and font are large, font is scaled",
    p + theme_cr(plot_scale = 1.5, cairo = TRUE, font = ""),
    width = 9, height = 6
  )

  expect_snapshot_plot("plot and font are small, font is scaled",
    p + theme_cr(plot_scale = 2/3, cairo = TRUE, font = ""),
    width = 4, height = 2.667
  )

  expect_snapshot_plot("normal plot with large font",
    p + theme_cr(plot_scale = 1, font_scale = 1.5, cairo = TRUE, font = ""),
    width = 6, height = 4
  )

  expect_snapshot_plot("normal plot with small font",
    p + theme_cr(plot_scale = 1, font_scale = 2/3, cairo = TRUE, font = ""),
    width = 6, height = 4
  )

  expect_snapshot_plot("small plot with normal font",
    p + theme_cr(plot_scale = 2/3, font_scale = 1.5, cairo = TRUE, font = ""),
    width = 4, height = 2.667
  )

  expect_snapshot_plot("large plot with normal font",
    p + theme_cr(plot_scale = 1.5, font_scale = 2/3, cairo = TRUE, font = ""),
    width = 9, height = 6
  )

})

test_that("plot and font scaling is correctly applied after plotting", {
  df <- data.frame(x = 1:5, y = 1:5, z = c("a", "a", "b", "b", "a"))
  p <- ggplot(df, aes(x, y, color = z)) +
    geom_point() +
    labs(
      x = "X-Axis Label",
      y = "Y-Axis Label",
      color = "Legend",
      subtitle = "Subtitle Text",
      caption = "Caption Text",
      tag = "A"
    )

  expect_snapshot_plot("plot and font are default size",
    p + theme_cr(cairo = TRUE, font = ""),
    width = 6, height = 4
  )

  expect_snapshot_plot("apply scaling to large plot",
    p + theme_cr(cairo = TRUE, font = "") + apply_scaling(plot_scale = 1.5),
    width = 9, height = 6
  )

  expect_snapshot_plot("apply scaling to small plot",
    p + theme_cr(cairo = TRUE, font = "") + apply_scaling(plot_scale = 2/3),
    width = 4, height = 2.667
  )

  expect_snapshot_plot("increase font size",
    p + theme_cr(cairo = TRUE, font = "") + apply_scaling(font_scale = 1.5),
    width = 6, height = 4
  )

  expect_snapshot_plot("decrease font size",
    p + theme_cr(cairo = TRUE, font = "") + apply_scaling(font_scale = 2/3),
    width = 6, height = 4
  )

  expect_snapshot_plot("zoom in on plot",
    p + theme_cr(cairo = TRUE, font = "") + apply_scaling(plot_scale = 1.5),
    width = 6, height = 4
  )

  expect_snapshot_plot("zoom out on plot",
    p + theme_cr(cairo = TRUE, font = "") + apply_scaling(plot_scale = 2/3),
    width = 6, height = 4
  )

})

test_that("geom_rangeframe is applied", {
  df <- data.frame(x = 1:5, y = 1:5, z = c("a", "a", "b", "b", "a"))
  p <- ggplot(df, aes(x, y, color = z)) +
    geom_point() +
    coord_cartesian(clip = "off")

  expect_snapshot_plot("geom_rangeframe is applied to plot",
    p + geom_rangeframe(colour = "gray20") +
      theme_rangeframe(cairo = TRUE, font = "")
  )

  expect_snapshot_plot("geom_rangeframe is scaled",
    p + geom_rangeframe(colour = "gray20") +
      theme_rangeframe(plot_scale = 1.5, cairo = TRUE, font = ""),
    width = 9, height = 6
  )

  expect_snapshot_plot("rangeframe limits are used",
    p + geom_rangeframe_cr(xlim = c(0,6), ylim = c(2,4), colour = "gray20") +
      theme_rangeframe(cairo = TRUE, font = "")
  )
})
