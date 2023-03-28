library(ggplot2)

test_that("geoms scale with plot size", {
  txt <- data.frame(displ = c(2, 4, 6), hwy = c(15, 32, 29), cyl = c(4, 6, 8))
  p <- ggplot(ggplot2::mpg, aes(displ, hwy, color = as.factor(cyl))) +
    geom_point(alpha = 0.6) +
    geom_smooth(se = FALSE, method = "loess", formula = "y ~ x") +
    geom_vline(xintercept = 3, linetype = "dashed") +
    geom_text(data = txt, label = c("Label1", "Label2", "Label3")) +
    labs(
      x = "X-Axis Label",
      y = "Y-Axis Label",
      color = "Legend",
      subtitle = "Subtitle Text",
      caption = "Caption Text",
      tag = "A"
    ) +
    guides(color = guide_legend(override.aes = aes(label = "")))

  expect_snapshot_ragg("smallest size",
                       p + theme_cr(plot_scale = 0.5),
                       width = 3, height = 2
  )

  expect_snapshot_ragg("small size",
                       p + theme_cr(plot_scale = 2/3),
                       width = 4, height = 2.667
  )

  expect_snapshot_ragg("normal size",
                       p + theme_cr(plot_scale = 1),
                       width = 6, height = 4
  )

  expect_snapshot_ragg("large size",
                       p + theme_cr(plot_scale = 1.5),
                       width = 9, height = 6
  )

  expect_snapshot_ragg("largest size",
                       p + theme_cr(plot_scale = 2),
                       width = 12, height = 8
  )

  df <- data.frame(x = 1:5, y = 1:5, z = c("a", "a", "b", "b", "a"))
  eb <- ggplot(df, aes(x, y, color = z, ymin = y - 1, ymax = y + 1)) +
    geom_point() +
    geom_errorbar()

  expect_snapshot_ragg("smallest size error bar",
                       eb + theme_cr(plot_scale = 0.5),
                       width = 3, height = 2
  )

  expect_snapshot_ragg("small size error bar",
                       eb + theme_cr(plot_scale = 2/3),
                       width = 4, height = 2.667
  )

  expect_snapshot_ragg("normal size error bar",
                       eb + theme_cr(plot_scale = 1),
                       width = 6, height = 4
  )

  expect_snapshot_ragg("large size error bar",
                       eb + theme_cr(plot_scale = 1.5),
                       width = 9, height = 6
  )

  expect_snapshot_ragg("largest size error bar",
                       eb + theme_cr(plot_scale = 2),
                       width = 12, height = 8
  )

})

test_that("geoms scale with plot size, base R graphics", {
  txt <- data.frame(displ = c(2, 4, 6), hwy = c(15, 32, 29), cyl = c(4, 6, 8))
  p <- ggplot(ggplot2::mpg, aes(displ, hwy, color = as.factor(cyl))) +
    geom_point(alpha = 0.6) +
    geom_smooth(se = FALSE, method = "loess", formula = "y ~ x") +
    geom_vline(xintercept = 3, linetype = "dashed") +
    geom_text(data = txt, label = c("Label1", "Label2", "Label3")) +
    labs(
      x = "X-Axis Label",
      y = "Y-Axis Label",
      color = "Legend",
      subtitle = "Subtitle Text",
      caption = "Caption Text",
      tag = "A"
    ) +
    guides(color = guide_legend(override.aes = aes(label = "")))

  expect_snapshot_plot("smallest size base R",
                       p + theme_cr(plot_scale = 0.5, cairo = TRUE, font = ""),
                       width = 3, height = 2
  )

  expect_snapshot_plot("small size base R",
                       p + theme_cr(plot_scale = 2/3, cairo = TRUE, font = ""),
                       width = 4, height = 2.667
  )

  expect_snapshot_plot("normal size base R",
                       p + theme_cr(plot_scale = 1, cairo = TRUE, font = ""),
                       width = 6, height = 4
  )

  expect_snapshot_plot("large size base R",
                       p + theme_cr(plot_scale = 1.5, cairo = TRUE, font = ""),
                       width = 9, height = 6
  )

  expect_snapshot_plot("largest size base R",
                       p + theme_cr(plot_scale = 2, cairo = TRUE, font = ""),
                       width = 12, height = 8
  )

})
