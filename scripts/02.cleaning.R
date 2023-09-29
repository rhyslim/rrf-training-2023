
# Libraries
  # Step 1. Install necessary packages
  # install.packages("pacman")
  # packages <- c("here","haven","tidyr","dplyr","forcats"
  #              "sjPlot","expss","sjlabelled","expss","Hmisc")
  # pacman::p_load(packages, character.only = TRUE, install = FALSE)
  # Change to TRUE to install packages

# Working directory (don't have to use "here" if you don't want to)
  my_folder <- here('data')
  here('data')
# Reading data

  householdsdf <- read_dta(here('data',
                      "LWH_FUP2_households.dta"))
  
  assetsdf <- read_dta(here('data',
                               "LWH_FUP2_assets.dta"))
  
  plotsdf <- read_dta(here('data',
                               "LWH_FUP2_plots.dta"))
  
# Your solution goes here
  
  print("02. cleanging")
  
# Exercise 1. Encode choice questions and ensure correct data types
  str(householdsdf)
  str(assetsdf)
  str(plotsdf)
  
  # Assetsdf: Set variable labels for AA_01 and AA_02
  summary(assetsdf)
  # label(assetsdf$AA_01) <- "cattle purchase"
  # label(assetsdf$AA_02) <- "cattle count"
  
  # Assetsdf: Set level labels for AA_01 
  # assetsdf$AA_01 <- factor(assetsdf$AA_01, 
  #                         levels = c (-88, -66, 0, 1),
  #                         levels = c ("Missing", "Don't Know", "No", "Yes"))
  # summary(assetsdf$AA_01)
  
  assetsdf$AA_01
  
  print("cleaning complete")

  