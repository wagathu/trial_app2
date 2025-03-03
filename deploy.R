# Authenticate
rsconnect::setAccountInfo(name = "wagathu",
                          token = "04B78DEBBED7CA750FE1C4410ADDB92E",
                          secret = "6W+Dln3QZqEJ3XW2AGjcmu0aw9Pnea3rTdQqKusF"
)

rsconnect::deployApp(appFiles = c("app.R", "data"), forceUpdate = TRUE)
