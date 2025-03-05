
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
dropbox_token <- "sl.u.AFmYx7crTkcshtQ30wrVOIdxEQv0iNj--lIcbl0OVmKqtjmXP1snQMTCCsulJE0R90vAn1KOLxamxIuirvXgDlepynkopXb_Jsp4k0_mjmzH51fEOqnNeuTLMv86LnVcacndPud77OR3MboYttXX3ivwVKwmAyjD6xKk9CR95TuQfgQU1xq0hQYk9fJE2LqQ1PAUIj11uQUmU1Hr_xHL1QOBgM4ScJ4Dirn4gBD4kHxFmr6fmJoyxyyxp7ij1YHGOVmeoSI7ltBds2oz_dHUc2nLOMu5GhbAJDnNqbAU4IpM5rCjUkLHLo1pNpJqUtC1pNwAPODNDsdhY67UhzYNiF5qz-w4wx0eZljJ1GNcxbP1GVdAlxCV2EUmg-BwH8rcTXZBF4TywQLcOnaRCrdyhAuIFRRoLNd8I7Eu9gecHg0cQNMnzxlgq6o8RveKd9M1w8PWZN89eeNW3ggEwcB3tRD7AH35NQ2O6yQweU7yEfm_PPdoL4G4HOhw4_nRBcjoMR9f5EOrF5LEDLcOCOhjq6c9M1cvJz_0Bbr_GTCiLcgFptAAliC1CDXzppIzcZcOogHQ6KN2Nf4CmT7b7t7SGC2YSldSKlWSxa4MZaFLGW39gtOAF26x7erfi54OQvaboFrIV1NXWNR1ebhMpu4_FMQcZwK0AYyHfbQzLrY_ZIfq4hRM9o0wXsYKHwMx-A9cKECH_MwETW4kWPn0vfu712hAqOm4pUYnzCV3fymZ1Y9g6vGv1Ry0t2tZPmk3CsJ9U-byoxXNw4jdf_VNiS4iBruNjrMBZxUJnmFPzMyL686jPCVqwx39CUwds7UyYB10-PfT9DNhh9YwDn2m55ozqs46FOD429ITflc2pA160L6f-3Y0HRU4qQysayk6ktUm04aRV7dhRouWbBKTpUn0byBD_JFDuHO4unepKxW6I9lOGQzdNTVOovb72ZEnZic8ndpXqC9F_lEZjFrfe7cWS9hILsloIDiBZsvNVFjWwdgr3UXHVIx4aH-JecxMnJiDhvkUQ3hQ6xsB8M2tAAZgIf76qciJMs-bVM9tBfjMlkNaQGSmTXRugIYiPk7BBo25Q8MJg2-jPrNPKq8Hs08NzTrSNOHg4Ggj6IryNnQIzIM4X4Y-HUAbKXnnE48psRgSGosnypXT-sQxPUZEaLPby7B7b2hAqs2WabXci1UytCa8CAWDC0Pzx_Qq990ulmeMdfyBjPGlTdqdnVUZH6iZbfuuG7L0_gYcdn_hSwvoAjO_JC82qH5yIHWMH0ehjnuyLhrZueQzLKrdMVks8PKdfJvEDX5jwpjGViBU9qq2E8i8GpI9vmexGni-HcJ0byroVysplIxFDez5lJ6QidIT0EukVvAKZ7SW__DCZb5IlgT45eA2up_lgd4WyCpbYZ6HW5Z-7cHxxcTxI6PpdZcqhMe0ISwtxY66ncPsUkiSI89xuw"
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
