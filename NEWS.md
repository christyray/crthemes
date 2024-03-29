# crthemes (Development Version)

# crthemes 0.1.2 (2023-03-28)

- Added `"errorbar"`, `"crossbar"`, `"linerange"`, and `"pointrange"` to the list of geoms that are automatically scaled based on the theme scale factor
- Changed the name of the theme scale factor argument from `base_scale` to `plot_scale` for better clarity
- Updated the image scaling in the `crsave()` function to use the `scaling` argument from the `ragg` package and to be handled more intuitively overall
    - The standard approach should now be to use `plot_scale` in `theme_cr()` to handle making the plot look reasonable inside R, and then to use `width`, `ratio`, and `scaling` to export the image at the desired sizing

# crthemes 0.1.1 (2023-02-21)

- Hotfix to incorporate necessary changes after updating to `tidyselect` v1.2.0 and `ggplot2` v3.4.0

# crthemes 0.1.0 (2023-02-21)

- Updated the package to work with the facet styling from `ggh4x` instead of `ggplot`
    - Specifically using `clip = "off"` by default, so the border width is now halved so it will display appropriately with the clipping off
- Added a function to apply the plot and font scaling factors to a plot without modifying other theme elements
    - Useful for scaling plots that are already fully styled before saving
- Fixed the `theme_cut_*()` functions to be more specific and interact correctly with theme scaling
    - Also fixed Y-axis facet styling so it is not impacted by the cut functions
- Added additional color palettes and modified the `contrast3` palette to be more distinct
- Added plot size scaling for `abline`, `vline`, `hline`, and `text` geoms, so they will now automatically scale as the plot size changes
    - Also set default color and plot for these geoms, similar to the original geoms

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
