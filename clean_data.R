
# Importing packages ------------------------------------------------------

pacman::p_load(
  data.table,
  googlesheets4,
  lubridate,
  rsconnect
)

# Importing packages ------------------------------------------------------

url <- "https://docs.google.com/spreadsheets/d/1grVW04UUk-O73s-3Qs3DUV4MnF1RFNvlhyd_XIfXbQ4/edit#gid=0"
df <- read_sheet(url)
fwrite(data, "data/dd.csv")
