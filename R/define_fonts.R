define_fonts <- function(symbol = TRUE) {
  systemfonts::register_font(
    name = "Roboto Plot",
    plain = system.file("fonts", "Roboto-Regular.ttf", package = "crthemes"),
    bold = system.file("fonts", "Roboto-Medium.ttf", package = "crthemes"),
    italic = system.file("fonts", "Roboto-Italic.ttf", package = "crthemes"),
    bolditalic = system.file("fonts", "Roboto-MediumItalic.ttf", package = "crthemes"),
    features = systemfonts::font_feature(
      ligatures = "standard",
      numbers = "tabular"
    )
  )

  if (symbol) {
    systemfonts::register_font(
      name = "symbol",
      plain = system.file("fonts", "Roboto-Regular.ttf", package = "crthemes"),
      bold = system.file("fonts", "Roboto-Medium.ttf", package = "crthemes"),
      italic = system.file("fonts", "Roboto-Italic.ttf", package = "crthemes"),
      bolditalic = system.file("fonts", "Roboto-MediumItalic.ttf",
                               package = "crthemes"),
      features = systemfonts::font_feature(
        ligatures = "standard",
        numbers = "tabular"
      )
    )
  }
}
