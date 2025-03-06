
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
dropbox_token <- "sl.u.AFn3lPlPQAmaOdasThpASdawqAnINf-2qITSeDntsEA3-gDdx-4u7vgbGh7bV9dooEnLA-CCN1uKmna8A8FZK0y1umvZI9FZ5GuougkKKor1n3P5k2fNlzdkIbcwZhGGXOGXLajdA-Q9V1uuGTGkmH5ntdUiv2QLIaglnx5_m-118k15S_sY7Z0JarYlsrZLALXwpJwgfwhP2dWflf6k-Va_HzS287XUGu4xWIsZdcxQTCaR7d7ix4NpLpTt3xytiejFvcipjeGZIJ2pdly0NoayCIdOJsQ8mkRnkrb7_-3BjwiLFFULSwyOCCiGe-pujtEMEB2L4k44Nv_Qm_ONqWVqSIWqFBiwQJE6rJM6RNOIT1kvBOeoZwDL6EpvGr0VJL5RpDutcpu5c4w2rhFQkDoEe4aQdlZdpVpWtCCwkBOEm3AY-lrE29pNNi8_1oXVWPe6v9KcZ2z29r40d5bnNRnk_8gbvgwWiPeJQg8V4Zj-SUQgaMPbYgB0jdQyI5D9m-FIZjMEukn9-LF9mLCzgIC4-whSsFzJ6FKYcklq0qbPqwC5mQCvlzzA_sU-7JwLj3dE0wfzgPjQsDkSjpApSCsyZKnUlHbnVuKx6kSMEfaCkUtBeCEwhJc0AjKWkTH3Xz9PxpQh3T-jGFo6VybQI_p81vjjGnePDtaFcIun9xGlhXmrQq3318EglqCg4JDcXCPePgwuYpAu9n0jmeAUjdZ-HVWv7gNuSl_JimBhElc-4x5pLIqeLtOn4igVEl2oCG55HgQMkp79UrUz2OBEDPsLciXz_wpZsd-P0ba4gnuG1q1-Cp9O2SvGLQ0hfztZ-cdq8zRFbkovvWzPhYOKVyNgThwlvFbl_lrhC1wp1FRjcQye-2O0FyhAiI5JJs4bJYJ19dM59iHereuu897JLa1Rh9887OSUmErE4UhSpIffqpsB-7m6j7ZO_7NAWTIYUHx9UJvruA0Z-seCG2v9WDOpptfBtOlmB_u6I2dGQ9srH5DUpN-G-mdpVSlIHBr4YsCi99yRgAiqyEAhQR0rHz3NucSaieUn2-GMVprg7Nr0-kiC-rKy8xjzp0bh_eRMoAzIKUXziaAcS_QEggltfOWX3WokQpDEGkkuW58fGTwYedzgzKiI4r5y6NQuUnxTRpcNqSj4FC85QY6tlbdAAA_zkvuoLy9ygiUN4RccJOGJP9iOovQ2nd8AtagJveiaw3BVgUASJCOJM720RSI3cHgEXxcUSJEMeB0Kp3oGzXuGvu445hQQX1JL2lH40H8KPbdauLpysLoRIQXi_Ysn_pH4P11mGR4NbFLlDhp6kcD0NCZEAOh783_XIcMBMYKBLbokBa4kGIFhMgBr0zk61L6zXsdy1wiNExWzoNw1g2720F-7eeQqIiwYGj8lxp_X4kFD-FPhYmNjpvmhhYGE1_EADqDZBjzHcXyl_W4GKYmhBA"

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
    date2 = stringr::str_extract(date2, "\\d+\\-\\d+\\-\\d{2}") |> 
      lubridate::ydm()
  )]
fwrite(df, "data/dd.csv", row.names = F)
