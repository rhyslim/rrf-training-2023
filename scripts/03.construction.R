
# Libraries
# Step 1. Install necessary packages
# install.packages("pacman")
# packages <- c("tidyr","dplyr","labelled","stringi",
#              "hmisc","stringr","dplyr","here","here","haven",
#               "forcats","sjPlot","expss","sjlabelled","expss",
#               "Hmisc","summarytools","labelled")
# pacman::p_load(packages, character.only = TRUE, install = FALSE)
# Change to TRUE to install packages

# Working directory (don't have to use "here" if you don't want to)
  my_folder <- here('data')
  here('data')
# Reading data

  householdsdf <- read_dta(here('data',
                      "LWH_FUP2_households_clean.dta"))

  plotsdf <- read_dta(here('data',
                                "LWH_FUP2_plot_clean.dta"))
  
# Your solution goes here
  
# Deal with value labels
  householdsdf <- as_factor(householdsdf)
  plotsdf <- haven::as_factor(plotsdf)
  
  #plotsdf <- plotsdf %>%
    #mutate(ID_07 = haven::as_factor(ID_07))
  
  summary(householdsdf)
  summary(plotsdf)


# Output 1. Household income

# Adding the sum
  summary (householdsdf)
  
  householdincome <- householdsdf %>%
    rowwise () %>%
    mutate(totalincome = sum(across(INC_01:INC_12)))

  householdincome <- householdsdf %>%
    rowwise () %>%
    mutate(totalincome = rowSums(across(INC_01:INC_12)), na.rm = TRUE)
  
  view(dfSummary(householdincome))
  
# Output 2. Harvest of dry beans for households that grew that crop
  view(dfSummary(plotsdf))
  drybeanshh <- plotsdf %>%
    filter(A_CROP=="Dry Beans")
  view(dfSummary(drybeanshh))

# Output 3. Average household crop sales per vilage
  
  
# Output 4. Earnings for the subset of households that sold crops
  
  
  print ("03. construction completed")
  

  