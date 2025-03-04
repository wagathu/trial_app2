
# Importing packages ------------------------------------------------------

pacman::p_load(
  data.table,
  googlesheets4,
  googledrive,
  lubridate
)

# Importing packages ------------------------------------------------------

options(gargle_oauth_cache = ".secrets")
drive_auth(cache = ".secrets", email = "briannjuguna133@gmail.com")
gs4_auth(token = drive_token())

gs4_auth(path = "/Users/macuser/Dropbox/personal things/mykey.json")  
url <- "https://docs.google.com/spreadsheets/d/1rqkgsSAXkAy3eUfL5HKaDRP7VNa_5sBSgf2W_H6gdzY/edit?gid=0#gid=0"
df <- read_sheet(url)
fwrite(df, "data/dd.csv")
