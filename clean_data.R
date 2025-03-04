
# Importing packages ------------------------------------------------------

pacman::p_load(
  data.table,
  googlesheets4,
  googledrive,
  lubridate
)

# Importing packages ------------------------------------------------------


gs4_auth_configure(api_key = "9c1c7493a4bfa59827d042410d7956a64591bf56")
url <- "https://docs.google.com/spreadsheets/d/1rqkgsSAXkAy3eUfL5HKaDRP7VNa_5sBSgf2W_H6gdzY/edit?gid=0#gid=0"
df <- read_sheet(url)
fwrite(df, "data/dd.csv")


