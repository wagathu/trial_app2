# Authenticate
rsconnect::setAccountInfo(
  name = Sys.getenv("SHINY_ACC_NAME"),
  token = Sys.getenv("TOKEN"),
  secret = Sys.getenv("SECRET")
)

rsconnect::deployApp(appFiles = c("app.R", "global.R", "data"),
                     forceUpdate = TRUE)
