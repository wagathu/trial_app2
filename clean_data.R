
# Importing packages ------------------------------------------------------

pacman::p_load(
  data.table,
  googlesheets4,
  googledrive,
  lubridate,
  httr,
  jsonlite,
  stringr
)

# Importing packages ------------------------------------------------------

# Set your access token
dropbox_token <- "sl.u.AFkK_Jpv1I4__Q4j_PMNMoqL4YLG1YXtdpi8aNoCNdKcqvVASs1d5gMhBflyR1Cv5APDrxSS6OJhd-R2C0YsVmq7xUUeqcJcj_UjioOhivx2BdHhMGDrcIvASzS0TkEBaefecfy11fYy9JhXvx1aWm6W9gL7PvtNWQ7t9VS_FZsmMWMRRe93i54d3sQ_8UL6Iv6gb5FOHZaPSlsSOg0J-thewQwq6qDe_0oyYFsdkOaewa3Anx8V1ux7YsxKlj0avXQh0-4xmut7l_Yxc0hsAqKt1PkIuM01kYZqfg9W_EHjx04zL95hg_Q4OyWILhU2X06qniBT4qdSszQbdawJhSyFoDPENb0RpzyHuF4t5QMyTGj1cJvhiKBknBMneBXPb13QjQ_HgOtCV7EYi0cex5D8JIb4fLOlSI91GzLDjaOYl4bdIR9KYA-jKR2eLjJvpbeRc18MvT42Pz2MvRs1fQptXNsl9xe_U-4JmHBSor8JCgcwOaT_Di6ur4gFTr51XcBaDwc0KLSORlibyenPk0hmb_LQYQ9Ej7qy9wqQ1vRxIEpv-ZhMsGMZJbiEEJfogv8KV5kd-fUdTWsTiFM-y3Gf4hdjUGfC8JLula2th44ewJg8Qhez4_I-mmDsjEsZ8lUZNnBShK6WGmd10lJKCh7OUu2p6fedBhHgQHEJzfY3ZcdppYlUNA9C6bybF8tZwVgQmK_tp_Iwsc0mgrMGuMwrx1CIb45u7uvlDTgjy2RQUNrhb0ugFk55vKX3TKDiXXiDjE_pMiMLGdloHVS0wMyZK1O1zeIMZmncu-R5_GwYOeeHP0HT6wRNWgXE_-2ur2s8wPtwBcS7rpZZktxNgOv1CZp6_yA2gUVEUd24UiRBH_FPfeXArqqMyVRev2rj9W7iNoo1Xp90cYF3m03sD8i4e98N1DRVzKn9aLTytlCABAzxAUmV5bjuBAU1VeCyFAjhkvFbi22DPfom92iWPEqAfIigkkFTJVa4SyRTvVJz5fTz9hYTIe1T3PNFcCt8YUPoUz4P02EMbBYtFGJ_LZWNzqMKM5U47wKlPW-Ed-cDZ7XcKTckcmuRvW7nds3CVVuMyusfZRZWOj_nvjoHLs7qMfeRDRfdW1YEq6fpZ0jLwmgs7J6303EbRMELK2fXUQlBgnjLr-wVT-HdEvqUNpoO_cqTtFVIFrMVgd9ZowwOiVfyy6G-LNV9TeFQ54QZsCjpA0oUloF2oPcgy_a5HEnsuWT39_zBbfd-_BGxl6HULtUHK4dibn4ysfegc7nX5BcqAZ4YLy8MoMoRmF9HnCOoipGDhkzFR8N195PMBbsBe8_RvoZEyNjel4Pkl1KQeQTdGv0dX8fZVzZOsOUfupe7NfC6tOc1Q5PYUyrQo-AhB6wqHE_5LYgi14zQBiQdrigovBWjZBboHDKYI-ReEh-mA0WNyuKzQ96sPA9bWZLszQ"
# File path in your Dropbox (relative to the app folder)
file_path <- "/data/dd.csv"

# Dropbox API endpoint
url <- "https://content.dropboxapi.com/2/files/download"

# Make API request
response <- httr::POST(
  url,
  add_headers(
    "Authorization" = paste("Bearer", dropbox_token),
    "Dropbox-API-Arg" = jsonlite::toJSON(list(path = file_path), auto_unbox = TRUE)
  ),
  accept("application/octet-stream")
)

content_data <- content(response, "text", encoding = "UTF-8")
df <- read.csv(text = content_data) |> 
  data.table() |> 
  _[, let(
    date = stringr::str_extract(date, "\\d+\\-\\d+\\-\\d{2}") |> 
      lubridate::ydm()
  )]
fwrite(df, "data/dd.csv", row.names = F)
