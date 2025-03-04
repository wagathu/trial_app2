
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
dropbox_token <- "sl.u.AFmTq29waIDImI7QPdh6t4XpUARfQHSNLHZ_1y3i3n3NpiIPmPIyA2YaW01z8AQP5ql8a5VeCyv8qZ71SDX4sLXRM46cyz8bp5WmZgJVtm7IEixFhjC3uS9zfmItVhzl9ArWsedRsDIyih8D7sss04tovsczswUtPhz-LpGZnQV4TdWNI6Gst6bgbLR7jeb5R-AJh4Fi7UY-QO2n90ZAbPBDTK1U6KzqSMByQDGh9ZgyQ_BX0xmmianhsmY_MtCziQlyRf0WWvmd0c05XD3V2fZJDkVZDLMfW-T-z6IiyoOQ2YGVd8g11hO_NZqIcHPn94kwMegD_zi5C5nht7zC7aFyE3trlmc7KZjZqgtqQH7yFjOLWU6N7rIrmHzGMHX9hHdqenDCLoB4ur4kf1zssyhSOXNjF9YTaqzbOUIYQoXD7lScZceanP8gl2AmekRpkf0rHG3RpZrj6sSDM4SonQee89HHOl0Y095I3ZzZz01hwrFtluUVGOBMlpaFotRKWr8SWgG6AzBA6YXpru0BM7-1SIA4u65SFqUeSiPGx23fwpMynjHoJ3KtPetYSvyOgiYoQeAOq-K8MDPlWInmaJfkg4BP9ncDT9V_C6qMocXhPxddL0RLUvlBKO3SABkVUfQXFgZBzwbzkKpA-mrYhRhhK6tqrvJ9BXAfJdMr5EEIW5abgcAznqfShw4T4rljVI_W4SvoZxmRw7OIHsThPh7Ybwd5A-gig6OpAtG9rgyU2fpda3u_EoKRt9O_FMcvHEU4_tP2-SDScz7xAOK_OHPuUA0NU8yZ9qoHMkNVL1QVO3TUKS0IiRCfEveltVqTyhpDWGxivGI3w6nJoLu4o18f-YejVt3Mlg7DXqw31H0NjWoWoNX4TkFng4TXYq4NGQYgxCaIt0lxTv-ntQ_OZ6LsDHRHdsQxJtdpMxdffv6qlCTKHWHPiMdFBhfQif7hS04IzB_Ng-xhidCkQMhWAzxWeROcDQZIx4pFQOxBr7wEL0GZqHjMv0UBoIonhOb8KdVuNUzh8KlpnNysq04YbiNFgRZvycoGYXjrNbYBM5a8PV7NFjCcf9Dl2Y924Hce3YyxFgGNrfs9iz6Upt6gavqzHw0zSE3Ht4vpeJAeuEEeYXS2gfeHTMRLH6e0YpdMODvlMLSz9oAlFjrx3qFEEMbzjgJyzerHeClSdREmfoOBMgQUwwE-gcNTWnJtLKW4ZAUBTRlCGcmqRJ2e-D0uGoWsuDrJh7vQ0lkmHnXH8HWMEnFOHZpcuUmO0gGhKzJsUk_3PZ855kPmZSiQDF81qHzd76r2vGDkYiUEb-d2SA0SZl-ViNZEuusJa4MoKZLN332DHkGMd4CwejgnxDufwVBXt58u_2wRSANOM4PNmulOrIgmQCGagzG5_ORE_HspnwoTpIDP169sQLHZgQlHHyNve9bUjcfIZpcRBDXC6MRDbg"
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
