# Skip visual tests if vdiffr is not installed (since it is only listed in
# Suggests)

expect_doppelganger = function(title, fig, ...) {
  testthat::skip_if_not_installed("vdiffr")
  vdiffr::expect_doppelganger(title = title, fig = fig, ...)
}
