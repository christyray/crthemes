#' Register theme fonts with systemfonts
#'
#' @importFrom magrittr %>%

font_register <- function() {

# Roboto ------------------------------------------------------------------

  systemfonts::register_font(
    name = "Roboto Medium",
    plain = system.file("fonts", "Roboto-Medium.ttf", package = "crthemes"),
    bold = system.file("fonts", "Roboto-Bold.ttf", package = "crthemes"),
    italic = system.file("fonts", "Roboto-MediumItalic.ttf", package = "crthemes"),
    bolditalic = system.file("fonts", "Roboto-BoldItalic.ttf", package = "crthemes"),
    features = systemfonts::font_feature(
      ligatures = "standard",
      numbers = "tabular"
    )
  )

  systemfonts::register_font(
    name = "Roboto Regular",
    plain = system.file("fonts", "Roboto-Regular.ttf", package = "crthemes"),
    bold = system.file("fonts", "Roboto-Medium.ttf", package = "crthemes"),
    italic = system.file("fonts", "Roboto-Italic.ttf", package = "crthemes"),
    bolditalic = system.file("fonts", "Roboto-MediumItalic.ttf", package = "crthemes"),
    features = systemfonts::font_feature(
      ligatures = "standard",
      numbers = "tabular"
    )
  )

  systemfonts::register_font(
    name = "Roboto Light",
    plain = system.file("fonts", "Roboto-Light.ttf", package = "crthemes"),
    bold = system.file("fonts", "Roboto-Regular.ttf", package = "crthemes"),
    italic = system.file("fonts", "Roboto-LightItalic.ttf", package = "crthemes"),
    bolditalic = system.file("fonts", "Roboto-Italic.ttf", package = "crthemes"),
    features = systemfonts::font_feature(
      ligatures = "standard",
      numbers = "tabular"
    )
  )

  systemfonts::register_font(
    name = "Roboto Bold",
    plain = system.file("fonts", "Roboto-Bold.ttf", package = "crthemes"),
    bold = system.file("fonts", "Roboto-Black.ttf", package = "crthemes"),
    italic = system.file("fonts", "Roboto-BoldItalic.ttf", package = "crthemes"),
    bolditalic = system.file("fonts", "Roboto-BlackItalic.ttf", package = "crthemes"),
    features = systemfonts::font_feature(
      ligatures = "standard",
      numbers = "tabular"
    )
  )

# Roboto Serif ------------------------------------------------------------

  systemfonts::register_font(
    name = "Roboto Serif Regular",
    plain = system.file("fonts", "RobotoSlab-Regular.ttf", package = "crthemes"),
    bold = system.file("fonts", "RobotoSlab-Medium.ttf", package = "crthemes"),
    features = systemfonts::font_feature(
      ligatures = "standard",
      numbers = "tabular"
    )
  )

  systemfonts::register_font(
    name = "Roboto Serif Medium",
    plain = system.file("fonts", "RobotoSlab-Medium.ttf", package = "crthemes"),
    bold = system.file("fonts", "RobotoSlab-Bold.ttf", package = "crthemes"),
    features = systemfonts::font_feature(
      ligatures = "standard",
      numbers = "tabular"
    )
  )
}

#' Register selected font family as the symbol font
#'
#' @param font Font family to be registered as the symbol font, defaults
#'   to "Roboto Medium"

symbol_register <- function(font = "Roboto Regular") {
  font <- dplyr::filter(
    systemfonts::registry_fonts(),
    .data$family == font
  )
  systemfonts::register_font(
    name = "symbol",
    plain = font$path[font$style == "Regular"],
    bold = font$path[font$style == "Bold"],
    italic = font$path[font$style == "Italic"],
    bolditalic = font$path[font$style == "Bold Italic"],
    features = systemfonts::font_feature(
      ligatures = "standard",
      numbers = "tabular"
    )
  )
}
