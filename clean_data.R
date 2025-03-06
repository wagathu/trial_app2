
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
dropbox_token <- "sl.u.AFlXUvsMKPp7aXlKbKicULHLGCXooZZlqCGZCHVh-rYdKuTIy5_6lqZ53cB1wnZafLiNFvuqAqgLUA9OgUZhaCREuRjfHHQlFkpXRnqwCK-VjID5OJJt-_1gBsmUR0TQQzSQM1zp8yn1e8OqzkUfXYee8TpjGXOOOXOYwTnKT0gdebOvjgeKnv3g5wlJeFB0bCANo73MAgKzwfk7PqztZ3VERRW3c87N7spYCh5he2EzmpvmczVktx96UcY4EXiduQhGPnF4G8-WcCxN7cZxUyhO-bInXXfHr3PSUBpWaC-T58PU5ysN8d-GppHXRF2mmj1bXEgqfbQfMmIqyRE3k4QuKHCJDQuZoRg60S3IkqMOWVI1gaza8MZr-xJRp8L2eQf-ZUaHqoNji3NMhLW5otk8lzqjknfU01jEMJTjzv71xEnQ-FttBsf-wrn-62Yn4vlpEQLSTa36VjfpwtrPn_VFA0W7wx7P9zOZ0R4MNiFNYJ4s0feG8l4HQsWzpl7J5w879oUfFGhvYy9hCkss8C2LgGloIARz0wWZu6_fIP1h3f0Rqzsm_2HLIWHY1wiR1jeA60vNJfWyZebmGJlA2g0WjuT5A4vxc6pAuCwgynRJ6ksuIeA6qc2adr-N_EsmmAjovP5cyqZ-QW5FeUFpDDpgQZL2JdiysXaDMbawHfgfL-QfO8qG7E5nXnErBEkw3a9A18LlvHGVSESKhZDEt7tZrKgWux0LBaZtfKl2MlhluWTrxbrhy6f7QxXfpNwKtPE1IORkSO-WJr5IgfamqnRaz0192InSuvpQ9O5OiWwMPvORq4Acz_IDbCdLkgodCvBtlD3A0dQpPZPhlS2MFIJFD9t5ITe7RHHTGGN6qRPNE-qMPk514mduMWH-2zO35X9MjyQXHuwbOgRZNDzkyTMPizlsR5V0EkO8DJH-McTvGACxlOb1aqq2_M77yN_FQ20fHNI4j61975Y3CivIAx_EelSpYUqPQR6b-JInodp--sm2X-n0uv5P7qNeIc3rWHw7Mgpopl2GB7I6AnDlkwTfpeWczxeNQozV28RR8NLrfng_WEU771OrlPsZAwg37oRkGy5jxEkGtjLOV_RNOi-prFlJk4_ikKIRHWMpHp_kEUPmjqHNCic_uah9j8tsGpuFhpAVNa-vjEGH7BXpMb4hXXC4QQMr0tXPvthOsd-NBozzxw0I-aD0bUZgnou9QoJFyt3AGKMdJsC4AtpYEnR_A9AUNIWMgtPllhyzE2bisXOanOj4oJvxspkBmxwaRQX3IoNEQP7dbL0crHOT3CDma9N52RK7yVYlmtKYyVQ_WeiamUJP_2HDBhVZDXz5Qs2z2qn6EFwXMvBl7_qAOxkspTn-V7io_0VpRCZxi2FVxNz0GWg9SuyJA3iE4eNtgj9GrBWGXtxmQGPPxRGjXVT-Sgmv5iBje6Jw0_dKB2WH9g"
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
    date = stringr::str_extract(date2, "\\d+\\-\\d+\\-\\d{2}") |> 
      lubridate::ydm()
  )]
fwrite(df, "data/dd.csv", row.names = F)
