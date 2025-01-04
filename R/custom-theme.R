library(ggplot2)
library(ggtext)

theme_custom <- function(base_size = 11, ...) {
  theme_minimal(base_family = "Roboto Condensed", base_size = base_size) +
    theme(
      plot.background = element_rect(color = "#F8F8F8"),
      plot.margin = margin(t = 2, l = 2, r = 50, b = 2),
      plot.title = element_markdown(face = "bold"),
      plot.title.position = "plot",
      plot.subtitle = element_markdown(),
      plot.caption = element_markdown()
    )  
}

# Theme with smaller font size for GIFs
theme_custom_gif <- function(...) {
  theme_custom(base_size = 8)
}


# Color palette
color_pal <- c("#1b1b3a", "#216869", "#c17dfa", "#FA8334", "#9EC5AB", "#F2CD5D", "#21D19F")
