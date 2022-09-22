# crthemes 0.0.2 (2022-09-22)

- Added a new three-color palette named `contrast3`
- Fixed an issue with `base_scale` where the `width` parameter was being overwritten unnecessarily
    - Now the `base_scale` in `theme_cr()` reliably makes plot elements bigger or smaller, while `base_scale` in `crsave()` scales the plot size to match the scale applied in `theme_cr()` *if the `width` is not provided*
- Added additional helper functions `theme_cut_*` to remove plot elements from the tops and bottoms of figure panels
    - Useful for stacking plots that can't easily be faceted but share the same X-axis
- Added a helper function `fix_bold()` to reapply bold text to plots with math-formatted labels

# crthemes 0.0.1 (2021-12-10)

- First released version!
- Created the package and the core functions: `theme_cr()`, `scale_color_cr()` and `scale_fill_cr()`, and `crsave()`
- Included standard fonts and color palettes and functions for accessing them
- Wrote a series of tests for the included functions and started automated checking with GitHub Actions
- Added convenience functions for heat maps, bar graphs, and range frame axes to better align them with the theme
