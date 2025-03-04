
# Importing packages ------------------------------------------------------

pacman::p_load(
  data.table,
  googlesheets4,
  googledrive,
  lubridate
)

# Importing packages ------------------------------------------------------

googlesheets4::gs4_auth(
  cache = ".secrets",
  email = "briannjuguna133@gmail.com"
)
url <- "https://docs.google.com/spreadsheets/d/1rqkgsSAXkAy3eUfL5HKaDRP7VNa_5sBSgf2W_H6gdzY/edit?gid=0#gid=0"
df <- read_sheet(url)
fwrite(df, "data/dd.csv")


