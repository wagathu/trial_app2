# Authenticate
rsconnect::setAccountInfo(name = "wagathu",
               token = "EED42A134EDEDCE0E74B0297DBB5D1E9",
               secret = "lEprluutegILA9RlMAVnfRA3+xAd/O3PNkkxyE+1"
               )
# Deploy
rsconnect::deployApp(appFiles = c("app.R", "data"))
