
# Libraries

  #install.packages("here)
  #install.packages("haven")
  #install.packages("dplyr)
  #install.library("tidyr")
  library(here)
  library(haven)
  library(dplyr)
  library(tidyr)

# Working directory (don't have to use "here" if you don't want to)
  
  my_folder <- here(
    "YOUR",
    "FOLDER",
    "PATH"
  )

# Reading data

  df <- read_dta(here(my_folder,
                      "LWH-_FUP2.dta"))
  
# Your solution goes here
