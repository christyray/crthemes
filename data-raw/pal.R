# Empty palette list
pal <- list()

# Default -----------------------------------------------------------------

color <- c("blue", "red", "green", "orange", "yellow")
hex <- c("#544C7A", "#9C2748", "#599595", "#D96C3D", "#E6B450")

pal$default$colors <- tibble::tibble(color, hex)
pal$default$properties <- tibble::tibble(
  "Name" = "default",
  "Key" = TRUE,
  "Named" = FALSE,
  "Type" = "Default",
  "Length" = length(hex),
  "Brightness" = "Standard"
)

# Receptors Standard ------------------------------------------------------

species <- c("IL6", "IL8", "IL6R", "IL8R",
              "IL6R-Ab", "IL8R-Ab", "IL6R-Ab-IL8R")
color <- c("lightblue", "lightred", "darkblue", "darkred",
           "green", "orange", "yellow")
hex <- c("#8AB2C5", "#EC9A85", "#544C7A", "#9C2748",
             "#599595", "#D96C3D", "#E6B450")

pal$receptors$colors <- tibble::tibble(species, color, hex)
pal$receptors$properties <- tibble::tibble(
  "Name" = "receptors",
  "Key" = TRUE,
  "Named" = TRUE,
  "Type" = "Receptors",
  "Length" = length(hex),
  "Brightness" = "Standard"
)

# Receptors Dark ----------------------------------------------------------

species <- c("IL6R", "IL8R", "IL6R-Ab", "IL8R-Ab", "IL6R-Ab-IL8R")
color <- c("blue", "red", "green", "orange", "yellow")
hex <- c("#433D5F", "#6A1D33", "#406868", "#A04924", "#BA8720")

pal$receptors_dark$colors <- tibble::tibble(species, color, hex)
pal$receptors_dark$properties <- tibble::tibble(
  "Name" = "receptors_dark",
  "Key" = FALSE,
  "Named" = TRUE,
  "Type" = "Receptors",
  "Length" = length(hex),
  "Brightness" = "Dark"
)

# Receptors Light ---------------------------------------------------------

species <- c("IL6R", "IL8R", "IL6R-Ab", "IL8R-Ab", "IL6R-Ab-IL8R")
color <- c("blue", "red", "green", "orange", "yellow")
hex <- c("#8179A9", "#C96984", "#8AB7B7", "#E1997A", "#ECCB88")

pal$receptors_light$colors <- tibble::tibble(species, color, hex)
pal$receptors_light$properties <- tibble::tibble(
  "Name" = "receptors_light",
  "Key" = FALSE,
  "Named" = TRUE,
  "Type" = "Receptors",
  "Length" = length(hex),
  "Brightness" = "Light"
)

# Neutral -----------------------------------------------------------------

color <- c("darkgray", "lightgray")
hex <- c("#353B3C", "#C2C2C2")

pal$neutral$colors <- tibble::tibble(color, hex)
pal$neutral$properties <- tibble::tibble(
  "Name" = "neutral",
  "Key" = TRUE,
  "Named" = FALSE,
  "Type" = "Neutral",
  "Length" = length(hex),
  "Brightness" = "Standard"
)

# Single Highlight --------------------------------------------------------

species <- c("highlight", "neutral")
color <- c("blue", "lightgray")
hex <- c("#38788C", "#C2C2C2")

pal$highlight1$colors <- tibble::tibble(species, color, hex)
pal$highlight1$properties <- tibble::tibble(
  "Name" = "highlight1",
  "Key" = TRUE,
  "Named" = TRUE,
  "Type" = "Highlight",
  "Length" = length(hex),
  "Brightness" = "Standard"
)

# Double Highlight --------------------------------------------------------

species <- c("highlight1", "highlight2", "neutral1", "neutral2")
color <- c("blue", "green", "lightgray", "darkgray")
hex <- c("#38788C", "#90B350", "#C2C2C2", "#353B3C")

pal$highlight2$colors <- tibble::tibble(species, color, hex)
pal$highlight2$properties <- tibble::tibble(
  "Name" = "highlight2",
  "Key" = TRUE,
  "Named" = TRUE,
  "Type" = "Highlight",
  "Length" = length(hex),
  "Brightness" = "Standard"
)

# Contrast ----------------------------------------------------------------

species <- c("highlight1", "highlight2")
color <- c("blue", "green")
hex <- c("#38788C", "#90B350")

pal$contrast$colors <- tibble::tibble(species, color, hex)
pal$contrast$properties <- tibble::tibble(
  "Name" = "contrast",
  "Key" = TRUE,
  "Named" = TRUE,
  "Type" = "Contrast",
  "Length" = length(hex),
  "Brightness" = "Standard"
)

# Antibodies Standard -----------------------------------------------------

species <- c("Tocilizumab", "10H2", "BS1", "BS2")
color <- c("blue", "red", "green", "orange")
hex <- c("#38788C", "#A63F4D", "#90B350", "#D99857")

pal$antibodies$colors <- tibble::tibble(species, color, hex)
pal$antibodies$properties <- tibble::tibble(
  "Name" = "antibodies",
  "Key" = TRUE,
  "Named" = TRUE,
  "Type" = "Antibodies",
  "Length" = length(hex),
  "Brightness" = "Standard"
)

# Antibodies Dark ---------------------------------------------------------

species <- c("Tocilizumab", "10H2", "BS1", "BS2")
color <- c("blue", "red", "green", "orange")
hex <- c("#275361", "#6F323A", "#64773F", "#A16B36")

pal$antibodies_dark$colors <- tibble::tibble(species, color, hex)
pal$antibodies_dark$properties <- tibble::tibble(
  "Name" = "antibodies_dark",
  "Key" = FALSE,
  "Named" = TRUE,
  "Type" = "Antibodies",
  "Length" = length(hex),
  "Brightness" = "Dark"
)

# Antibodies Light --------------------------------------------------------

species <- c("Tocilizumab", "10H2", "BS1", "BS2")
color <- c("blue", "red", "green", "orange")
hex <- c("#68A4B6", "#C07983", "#B2CA85", "#E5B88B")

pal$antibodies_light$colors <- tibble::tibble(species, color, hex)
pal$antibodies_light$properties <- tibble::tibble(
  "Name" = "antibodies_light",
  "Key" = FALSE,
  "Named" = TRUE,
  "Type" = "Antibodies",
  "Length" = length(hex),
  "Brightness" = "Light"
)

# Compartments Standard ---------------------------------------------------

species <- c("blood1", "blood2", "tissue1", "tissue2", "tumor1", "tumor2")
color <- c("darkblue", "lightblue", "darkorange", "lightorange",
           "darkgreen", "lightgreen")
hex <- c("#376C95", "#AFD8E9", "#BD694C", "#EFCABD", "#50AB99", "#B6E2DD")

pal$compartments$colors <- tibble::tibble(species, color, hex)
pal$compartments$properties <- tibble::tibble(
  "Name" = "compartments",
  "Key" = TRUE,
  "Named" = TRUE,
  "Type" = "Compartments",
  "Length" = length(hex),
  "Brightness" = "Standard"
)

# Default Large -----------------------------------------------------------

color <- c("blue", "salmon", "magenta", "green",
           "yellow", "copper", "teal")
hex <- c("#8AB2C5", "#EC9A85", "#86466D", "#678448",
         "#E6CF5C", "#AD772B", "#2D7480")

pal$large$colors <- tibble::tibble(color, hex)
pal$large$properties <- tibble::tibble(
  "Name" = "large",
  "Key" = TRUE,
  "Named" = FALSE,
  "Type" = "Large",
  "Length" = length(hex),
  "Brightness" = "Standard"
)

# Large Dark --------------------------------------------------------------

color <- c("blue", "salmon", "magenta", "green",
           "yellow", "copper", "teal")
hex <- c("#437287", "#9F513E", "#502A42", "#3E4F2B",
         "#A78F1A", "#67471A", "#1B454D")

pal$large_dark$colors <- tibble::tibble(color, hex)
pal$large_dark$properties <- tibble::tibble(
  "Name" = "large_dark",
  "Key" = FALSE,
  "Named" = FALSE,
  "Type" = "Large",
  "Length" = length(hex),
  "Brightness" = "Dark"
)

# Large Light -------------------------------------------------------------

color <- c("blue", "salmon", "magenta", "green",
           "yellow", "copper", "teal")
hex <- c("#AECAD7", "#F2B7A9", "#B5739C", "#95B375",
         "#EDDD8D", "#D6A259", "#6EABB6")

pal$large_light$colors <- tibble::tibble(color, hex)
pal$large_light$properties <- tibble::tibble(
  "Name" = "large_light",
  "Key" = FALSE,
  "Named" = FALSE,
  "Type" = "Large",
  "Length" = length(hex),
  "Brightness" = "Light"
)

# Extra Large 1 -----------------------------------------------------------

color <- c("navyblue", "red", "oceanblue", "brown", "olivegreen",
           "royalblue", "orange", "skyblue", "peach", "forestgreen")
hex <- c("#49556E", "#A64E59", "#56AEBF", "#76594C", "#A3A686",
         "#1F7A99", "#CC8041", "#85ACCC", "#E6B3AC", "#266E4B")

pal$extralarge1$colors <- tibble::tibble(color, hex)
pal$extralarge1$properties <- tibble::tibble(
  "Name" = "extralarge1",
  "Key" = FALSE,
  "Named" = FALSE,
  "Type" = "Extra Large",
  "Length" = length(hex),
  "Brightness" = "Standard"
)

# Extra Large 1 Dark ------------------------------------------------------

color <- c("navyblue", "red", "oceanblue", "brown", "olivegreen",
           "royalblue", "orange", "skyblue", "peach", "forestgreen")
hex <- c("#333C4D", "#75373E", "#357D8C", "#533E35", "#76795A",
         "#16556B", "#955928", "#467BA6", "#B35C50", "#1A4D35")

pal$extralarge1_dark$colors <- tibble::tibble(color, hex)
pal$extralarge1_dark$properties <- tibble::tibble(
  "Name" = "extralarge1_dark",
  "Key" = FALSE,
  "Named" = FALSE,
  "Type" = "Extra Large",
  "Length" = length(hex),
  "Brightness" = "Dark"
)

# Extra Large 1 Light -----------------------------------------------------

color <- c("navyblue", "red", "oceanblue", "brown", "olivegreen",
           "royalblue", "orange", "skyblue", "peach", "forestgreen")
hex <- c("#7684A4", "#C48189", "#88C6D2", "#A98778", "#BFC1AB",
         "#4DA3BF", "#DCA67A", "#A9C5DB", "#EECAC5", "#69BF95")

pal$extralarge1_light$colors <- tibble::tibble(color, hex)
pal$extralarge1_light$properties <- tibble::tibble(
  "Name" = "extralarge1_light",
  "Key" = FALSE,
  "Named" = FALSE,
  "Type" = "Extra Large",
  "Length" = length(hex),
  "Brightness" = "Light"
)

# Extra Large 2 -----------------------------------------------------------

color <- c("brightred", "navyblue", "yellow", "green", "copper",
           "skyblue", "brickred", "lavender", "sand", "gray")
hex <- c("#CC7079", "#3C6C90", "#D3BC69", "#54A595", "#B87249",
         "#629BC6", "#7C3E37", "#8F9ECC", "#E3C0AF", "#97A5A4")

pal$extralarge2$colors <- tibble::tibble(color, hex)
pal$extralarge2$properties <- tibble::tibble(
  "Name" = "extralarge2",
  "Key" = FALSE,
  "Named" = FALSE,
  "Type" = "Extra Large",
  "Length" = length(hex),
  "Brightness" = "Standard"
)

# Extra Large 2 Dark ------------------------------------------------------

color <- c("brightred", "navyblue", "yellow", "green", "copper",
           "skyblue", "brickred", "lavender", "sand", "gray")
hex <- c("#A33B45", "#2A4B65", "#AC9132", "#3B7469", "#814F32",
         "#376E98", "#572B26", "#657AB8", "#C47B56", "#677675")

pal$extralarge2_dark$colors <- tibble::tibble(color, hex)
pal$extralarge2_dark$properties <- tibble::tibble(
  "Name" = "extralarge2_dark",
  "Key" = FALSE,
  "Named" = FALSE,
  "Type" = "Extra Large",
  "Length" = length(hex),
  "Brightness" = "Dark"
)

# Extra Large 2 Light -----------------------------------------------------

color <- c("brightred", "navyblue", "yellow", "green", "copper",
           "skyblue", "brickred", "lavender", "sand", "gray")
hex <- c("#DC9AA1", "#659AC3", "#E3D194", "#83C5B8", "#D09B7C",
         "#8FB9DA", "#B3726B", "#AFBADD", "#EDD3C6", "#B4C3C2")

pal$extralarge2_light$colors <- tibble::tibble(color, hex)
pal$extralarge2_light$properties <- tibble::tibble(
  "Name" = "extralarge2_light",
  "Key" = FALSE,
  "Named" = FALSE,
  "Type" = "Extra Large",
  "Length" = length(hex),
  "Brightness" = "Light"
)

# Write data to R/sysdata.R
usethis::use_data(pal, overwrite = TRUE, internal = TRUE)
