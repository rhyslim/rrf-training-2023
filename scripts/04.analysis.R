
# Libraries
# Step 1. Install necessary packages
# install.packages("pacman")
# packages <- c("tidyr","dplyr","labelled","stringi",
#              "hmisc","stringr","here","here","haven",
#               "forcats","sjPlot","expss","sjlabelled","expss",
#               "Hmisc","summarytools","labelled","modelsummary",
#               "huxtable","ggplot2","openxlsx")
# pacman::p_load(packages, character.only = TRUE, install = FALSE)
# Change to TRUE to install packages


# Working directory (don't have to use "here" if you don't want to)
  my_folder <- here('data')
  here('data')
  
# Reading data
  datadf <- read_dta(here('data',
                      "LWH_FUP2_analysis.dta"))
  
  summary(datadf)

# Your solution goes here

# Exercise 1. Create summary statistics
  summarystat <- datasummary_skim(datadf)
  
  summarystat
  
  quick_xlsx(
   summarystat,
   file = here(
     "outputs",
     "summary-stats.xlsx"
   )
  )

# Exercise 2. Create balance tables
  
  datasummary_balance(
    ~ livestock,
    data = datadf
  ) %>%
  quick_xlsx(
    file = here(
      "outputs",
      "balance.xlsx"
    )
  )
  
  
# Exercise 3. Create a bar chart
  
  # Check data types
  str(datadf$ID_10)
  str(datadf$CRP10A)
  
  # Convert ID_10 and CRP10A to numeric if necessary
  datadf$ID_10 <- as.numeric(datadf$ID_10)
  datadf$CRP10A <- as.numeric(datadf$CRP10A)
  
  # Create the ggplot
  barchart <- 
    ggplot(datadf,
         aes(x = ID_10,
             y = CRP10A)) +
    geom_col() + 
    labs(title = "Total household earnings across study sites")
  
  barchart
  
  # Save the ggplot to PNG
  ggsave("household_earnings_by_study_sites.png",
         width = 20,
         height = 10,
         units = "cm")
  
  print("04. analysis completed")
  
  