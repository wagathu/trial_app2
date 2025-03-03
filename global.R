
# Importing packages ------------------------------------------------------

pacman::p_load(
  dplyr,
  highcharter,
  googlesheets4,
  shiny,
  data.table
)


# Importing data ----------------------------------------------------------

data <- fread("data/dd.csv")
