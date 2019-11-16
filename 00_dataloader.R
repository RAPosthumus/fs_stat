remotes::install_github("tylermorganwall/rayshader")
library(rayshader)
library(ggplot2)
library(tidyverse)
library(readr)
library(plot3D)
fs_stat <- read_delim("fs_stat.csv", ";",
                      escape_double = FALSE, locale = locale(decimal_mark = ",",
                      grouping_mark = ".", asciify = TRUE),
                      trim_ws = TRUE)


dat <- fs_stat %>% gather(F, value, -1)
mi <- min(dat$value, na.rm = TRUE)
ma <- max(dat$value, na.rm = TRUE)

datplot <- ggplot(dat) +
  geom_point(
    aes(x = S, y = F, color = value, alpha = 0.9, size = value / ma)
    ) +
  scale_color_continuous(limits = c(mi, ma)) + theme(legend.position = "none")
 
  

plot_gg(datplot, width = 5, raytrace = FALSE, preview = TRUE)

plot_gg(datplot, width = 5, multicore = TRUE, windowsize = c(800, 800),
        zoom = 0.95, phi = 35, theta = 30, sunangle = 225, soliddepth = -100)
