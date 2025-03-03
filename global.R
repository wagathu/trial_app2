
# Importing packages ------------------------------------------------------

pacman::p_load(
  dplyr,
  highcharter,
  shiny,
  data.table
)

# Importing data ----------------------------------------------------------

data <- fread("data/dd.csv")
