
# pal_select() ------------------------------------------------------------

test_that("palette must be a length 1 character vector", {
  expect_error(pal_select(2))
  expect_error(pal_select())
  expect_error(pal_select(c("receptors", "antibodies")))
})

test_that("palette must be included in the pal data set", {
  expect_error(pal_select("example"))
  expect_type(pal_select("receptors"), "character")
})

test_that("pal_select() cannot use multiple selection schemes", {
  expect_error(pal_select("receptors", ncol = 1, colors = "lightblue"))
  expect_error(pal_select("receptors", ncol = 1, species = "IL6"))
  expect_error(pal_select("receptors", colors = "green", species = "IL8R"))
})

test_that("pal_select() accepts one number or two numbers for ncol", {
  expect_error(pal_select("receptors", ncol = 2:4))
})

test_that("pal_select() returns hex codes corresponding to hex column", {
  expect_equal(
    unname(pal_select("receptors")),
    pal[["receptors"]][["colors"]]$hex
  )
})

test_that("pal_select() returns a named vector", {
  expect_named(pal_select("receptors"))
})

test_that("pal_select() uses names based on how user selected colors", {
  expect_named(
    pal_select("receptors"),
    pal[["receptors"]][["colors"]]$color
  )
  expect_named(
    pal_select("receptors", ncol = 2),
    c("lightblue", "lightred")
  )
  expect_named(
    pal_select("receptors", ncol = c(2,3)),
    c("lightred", "darkblue")
  )
  expect_named(
    pal_select("receptors", colors = c("green", "orange", "yellow")),
    c("green", "orange", "yellow")
  )
  expect_named(
    pal_select("receptors", species = c("IL6R", "IL6R-Ab", "IL6R-Ab-IL8R")),
    c("IL6R", "IL6R-Ab", "IL6R-Ab-IL8R")
  )
})

test_that("pal_select() warns if wrong argument is used", {
  expect_warning(pal_select("receptors", colors = c("IL6", "IL8R")))
  expect_warning(pal_select("receptors", species = c("yellow", "lightred")))
})

test_that("pal_select() adds alpha to hex code when requested", {
  expect_equal(
    pal_select("receptors", ncol = 1),
    c("lightblue" = "#8AB2C5FF")
  )
  expect_equal(
    pal_select("receptors", ncol = c(2,2), alpha = 0.75),
    c("lightred" = "#EC9A85BF")
  )
  expect_equal(
    pal_select("receptors", ncol = c(5,6), alpha = 0.5),
    c("green" = "#59959580", "orange" = "#D96C3D80")
  )
})


# pal_names() -------------------------------------------------------------

test_that("pal_names() returns a character vector", {
  expect_type(pal_names(), "character")
  expect_equal(pal_names(), names(pal))
})

# pal_table() -------------------------------------------------------------

test_that("pal_table() returns a tibble with all palettes", {
  expect_s3_class(pal_table(), "tbl_df")
  expect_equal(nrow(pal_table()), length(names(pal)))
})

# pal_colors() ------------------------------------------------------------

test_that("pal_colors() returns a tibble with color information", {
  expect_s3_class(pal_colors("receptors"), "tbl_df")
  expect_equal(names(pal_colors("receptors")), c("species", "color", "hex"))
})

# pal_preview() -----------------------------------------------------------

# Quoted code will be evaluated by the helper function after the PNG device is
# initialized - allows code to write to PNG file correctly
expect_snapshot_plot("basic color matrix",
  'pal_preview("receptors")'
)

expect_snapshot_plot("species instead of colors",
  'pal_preview("receptors", label = "species")'
)

expect_snapshot_plot("subset of colors",
  'pal_preview("receptors", ncol = 4)'
)

expect_snapshot_plot("species with subset of colors",
  'pal_preview(
    "receptors",
    species = c("IL8R", "IL8R-Ab", "IL6R-Ab-IL8R"),
    label = "species"
  )'
)

expect_snapshot_plot("specify columns",
  'pal_preview("receptors", columns = 2)'
)

expect_snapshot_plot("change alpha",
  'pal_preview("receptors", alpha = 0.5)'
)

expect_snapshot_plot("different palette",
  'pal_preview("antibodies_dark", label = "species")'
)
