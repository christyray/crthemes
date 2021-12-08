library(ggplot2)

# theme_cr() --------------------------------------------------------------

test_that("fonts are registered when theme is called", {
  systemfonts::clear_registry()
  theme_cr()
  expect_gt(nrow(font_table()), 0)
})

test_that("symbol font is only registered if requested", {
  systemfonts::clear_registry()
  theme_cr(symbol = FALSE)
  expect_equal(nrow(dplyr::filter(font_table(), .data$family == "symbol")), 0)

  theme_cr(symbol = TRUE)
  expect_gt(nrow(dplyr::filter(font_table(), .data$family == "symbol")), 0)
})

test_that("font must be included in registry", {
  expect_error(theme_cr(font = "unknown"))
})

# font_names() ------------------------------------------------------------

test_that("font_names() returns a character vector", {
  expect_type(font_names(), "character")
  expect_snapshot_text("font_names output", font_names())
})

# font_table() ------------------------------------------------------------

test_that("font_table() returns a tibble with all registered fonts", {
  expect_s3_class(font_table(), "tbl_df")
  table <- dplyr::select(font_table(), !features)
  expect_snapshot_text("font_table output", table)
})

# font_styles() -----------------------------------------------------------

test_that("font_styles() returns a vector with font style information", {
  expect_type(font_styles("Roboto Medium"), "character")
  expect_snapshot_text("font_styles output", font_styles("Roboto Medium"))
})

# Visual tests ------------------------------------------------------------

test_that("requested font is previewed", {
  skip_if(
    options("RStudioGD.backend") != "ragg",
    message = "font_preview() is only tested in interactive mode"
  )
  systemfonts::clear_registry()
  font_register()
  expect_snapshot_ragg("preview default font", font_preview())
  expect_snapshot_ragg("preview Roboto Bold", font_preview("Roboto Bold"))
  expect_snapshot_ragg("preview Roboto Light", font_preview("Roboto Light"))
  expect_snapshot_ragg("preview Roboto Serif",
                       font_preview("Roboto Serif Regular")
  )

  systemfonts::clear_registry()
  font_register()
  expect_snapshot_ragg("symbols are system default font", font_preview())

  systemfonts::clear_registry()
  font_register()
  symbol_register(font = "Roboto Bold")
  expect_snapshot_ragg("symbols are Roboto Bold", font_preview("Roboto Bold"))
})

test_that("font is applied to theme", {
  df <- data.frame(x = 1:5, y = 1:5)
  p <- ggplot(df, aes(x, y)) +
    geom_point() +
    labs(
      x = "X-Axis Label",
      y = "Y-Axis Label",
      color = "Legend",
      subtitle = "Subtitle Text",
      caption = "Caption Text",
      tag = "A"
    )

  expect_snapshot_ragg("default font is Roboto Regular",
    p + theme_cr()
  )

  expect_snapshot_ragg("bolder font",
    p + theme_cr(font = "Roboto Bold")
  )

  expect_snapshot_ragg("lighter font",
    p + theme_cr(font = "Roboto Light")
  )

  expect_snapshot_ragg("serif font",
    p + theme_cr(font = "Roboto Serif Regular")
  )

})

test_that("symbol font is used on plot when requested", {
  df <- data.frame(
    x = 1:5,
    y = 1:5,
    z = c("alpha", "beta", "alpha", "gamma", "beta")
  )
  p <- ggplot(df, aes(x, y, color = z)) +
    geom_point() +
    scale_color_discrete(labels = scales::label_parse())

  systemfonts::clear_registry()
  expect_snapshot_ragg("symbols are system default font on ggplot",
                       p + theme_cr(symbol = FALSE)
  )


  systemfonts::clear_registry()
  expect_snapshot_ragg("symbols are Roboto Bold font on ggplot",
                       p + theme_cr(font = "Roboto Bold", symbol = TRUE)
  )
})
