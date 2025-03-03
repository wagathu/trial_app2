
# Importing packages ------------------------------------------------------

pacman::p_load(
  data.table,
  googlesheets4,
  lubridate,
  rsconnect
)

# Importing packages ------------------------------------------------------

gs4_auth(path = Sys.getenv("GOOGLE_SHEETS_KEY"))
url <- "https://docs.google.com/spreadsheets/d/1F6ND2aDM2PCHADnKDcuUqEPMNKYO0BZsOD8EH9-q-EM/edit?gid=0#gid=0"
df <- read_sheet(url)
fwrite(df, "data/dd.csv")
