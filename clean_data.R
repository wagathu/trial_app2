
# Importing packages ------------------------------------------------------

pacman::p_load(
  data.table,
  googlesheets4,
  googledrive,
  lubridate
)

# Importing packages ------------------------------------------------------

# google-drive
t <- gargle::credentials_service_account(Sys.getenv("GOOGLE_SHEETS_KEY"))
googledrive::drive_auth(token = t)
googlesheets4::gs4_auth(token = t)
url <- "https://docs.google.com/spreadsheets/d/1rqkgsSAXkAy3eUfL5HKaDRP7VNa_5sBSgf2W_H6gdzY/edit?gid=0#gid=0"
df <- read_sheet(url)
fwrite(df, "data/dd.csv")


