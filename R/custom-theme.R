library(ggplot2)

theme_custom <- function(base_size = 11, ...) {
  theme_minimal(base_family = "Roboto Condensed", base_size = base_size) +
    theme(
      plot.background = element_rect(color = "#F8F8F8"),
      plot.margin = margin(t = 2, l = 2, r = 50, b = 2)
    )  
}

# Theme with smaller font size for GIFs
theme_custom_gif <- function(...) {
  theme_custom(base_size = 8)
}