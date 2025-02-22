library(ggplot2)
library(ggtext)

theme_custom <- function(base_size = 13, ...) {
  theme_minimal(base_family = "Roboto Condensed", base_size = base_size) +
    theme(
      plot.background = element_rect(color = "white", fill = "white"),
      plot.margin = margin(t = 4, l = 6, r = 6, b = 2),
      plot.title = element_markdown(
        family = "Roboto Slab", face = "bold", lineheight = 1.25),
      plot.title.position = "plot",
      plot.subtitle = element_textbox(
        family = "Roboto Slab", lineheight = 1.25, width = 1),
      plot.caption = element_textbox(
        family = "Roboto Slab", hjust = 0, lineheight = 1.1, width = 1,
        margin = margin(t = 4, b = 8)),
      axis.text.x = element_text(family = "Roboto Condensed SemiBold"),
      strip.text = element_text(family = "Roboto Condensed SemiBold", size = 11)
    )  
}

# Theme with smaller font size for GIFs
theme_custom_gif <- function(...) {
  theme_custom(base_size = 11)
}


# Color palette
color_pal <- c("#1b1b3a", "#216869", "#c17dfa", "#FA8334", "#9EC5AB", "#F2CD5D", "#21D19F")

# Parties colors
party_pal <- c(
  "SPD" = "#E3000F",
  "CDU/CSU" = "#000000",
  "CDU" = "#000000",
  "CSU" = "#000000",
  "FDP" = "#FFEF00",
  "Grüne" = "#1AA037",
  "AfD" = "#0489DB",
  "Linke" = "#BD4459",
  "Linke.PDS" = "#BD4459",
  "BSW" = "#F39324"
  )
