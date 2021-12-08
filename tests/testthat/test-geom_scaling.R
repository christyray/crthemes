library(ggplot2)

test_that("geoms scale with plot size", {
  p <- ggplot(ggplot2::mpg, aes(displ, hwy, color = as.factor(cyl))) +
    geom_point(alpha = 0.6) +
    geom_smooth(se = FALSE, method = "loess", formula = "y ~ x") +
    labs(
      x = "X-Axis Label",
      y = "Y-Axis Label",
      color = "Legend",
      subtitle = "Subtitle Text",
      caption = "Caption Text",
      tag = "A"
    )

  expect_snapshot_ragg("smallest size",
                       p + theme_cr(base_scale = 0.5),
                       width = 3, height = 2
  )

  expect_snapshot_ragg("small size",
                       p + theme_cr(base_scale = 2/3),
                       width = 4, height = 2.667
  )

  expect_snapshot_ragg("normal size",
                       p + theme_cr(base_scale = 1),
                       width = 6, height = 4
  )

  expect_snapshot_ragg("large size",
                       p + theme_cr(base_scale = 1.5),
                       width = 9, height = 6
  )

  expect_snapshot_ragg("largest size",
                       p + theme_cr(base_scale = 2),
                       width = 12, height = 8
  )

})

test_that("geoms scale with plot size, base R graphics", {
  p <- ggplot(ggplot2::mpg, aes(displ, hwy, color = as.factor(cyl))) +
    geom_point(alpha = 0.6) +
    geom_smooth(se = FALSE, method = "loess", formula = "y ~ x") +
    labs(
      x = "X-Axis Label",
      y = "Y-Axis Label",
      color = "Legend",
      subtitle = "Subtitle Text",
      caption = "Caption Text",
      tag = "A"
    )

  expect_snapshot_plot("smallest size base R",
                       p + theme_cr(base_scale = 0.5, cairo = TRUE, font = ""),
                       width = 3, height = 2
  )

  expect_snapshot_plot("small size base R",
                       p + theme_cr(base_scale = 2/3, cairo = TRUE, font = ""),
                       width = 4, height = 2.667
  )

  expect_snapshot_plot("normal size base R",
                       p + theme_cr(base_scale = 1, cairo = TRUE, font = ""),
                       width = 6, height = 4
  )

  expect_snapshot_plot("large size base R",
                       p + theme_cr(base_scale = 1.5, cairo = TRUE, font = ""),
                       width = 9, height = 6
  )

  expect_snapshot_plot("largest size base R",
                       p + theme_cr(base_scale = 2, cairo = TRUE, font = ""),
                       width = 12, height = 8
  )

})
