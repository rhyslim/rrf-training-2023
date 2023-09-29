# main_script.R

# Step 1. Install necessary packages
install.packages("pacman")
packages <- c("tidyr","dplyr","labelled","stringi",
              "stringr","here","haven","forcats",
              "sjPlot","expss","sjlabelled",
              "Hmisc","summarytools","labelled",
              "modelsummary",
              "huxtable","ggplot2","openxlsx",
              "tinytex","rmarkdown","knitr","fixest"
              )
pacman::p_load(packages, character.only = TRUE, install = FALSE)
# Change to TRUE to install packages

# Step 1. Read the data
path <- here('data','state_database.csv')
df <- read.csv(path)

# Step 2. Source scripts for each stage
path <- here('../')
path <- here('script','01.tyding.R')
source(here('scripts',"01.tidying.R"))
source(here('scripts',"02.cleaning.R"))
source(here('scripts',"03.construction.R"))
source(here('scripts',"04.analysis.R"))

# Step 3. print completion message

# Manage dependencies - Isolate project-specific dependencies

