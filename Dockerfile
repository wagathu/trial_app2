FROM rocker/shiny:4.4.0
RUN install2.r rsconnect tibble dplyr stringr data.table googlesheets4 lubridate pacman
WORKDIR /home/trial_app2
COPY app.R app.R 
COPY data data
COPY deploy.R deploy.R
COPY global.R global.R
CMD Rscript deploy.R
