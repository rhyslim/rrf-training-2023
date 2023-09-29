
# Libraries

# Step 1. Install necessary packages
#install.packages("pacman")
# packages <- c("here","haven","tidyr","dplyr")
# pacman::p_load(packages, character.only = TRUE, install = FALSE)
# Change to TRUE to install packages

# Working directory (don't have to use "here" if you don't want to)
  my_folder <- here('data')
  here('data')
# Reading data

  df <- read_dta(here('data',
                      "LWH_FUP2.dta"))
  
# Your solution goes here
  
# Exercise 1. To check if a dataset or column have unique values:
  
  print("01. tyding")
  
  # See summary to see if any missing data
  summary(df)
  
  # See number of rows and variables in full dataset
  nrow (df)
  ncol (df)
  
  # See number of unique combinations 
  n_distinct(df)
  n_distinct(df['ID_05'])
  n_distinct(df['key'])
  
  # key seems to be the input #, ID_05 seems to be household ID
  
# Exercise 2. Fix duplicates
  
  #id_vars = c(df['ID_03'],df['ID_05'],
              #df['ID_06'],df['ID_07'],
              #df['ID_08'],df['ID_09'],df['ID_10'])
  
  # Identify duplicates based on the 'ID_05'
  duplicatedID_05 <- df %>%
    group_by(df['ID_05']) %>%
    filter(n() > 1)
  print(duplicatedID_05)
  
  # Remove any duplicated observations
  df2 <- df %>% distinct(ID_05, ID_06, ID_07, ID_08, ID_09, ID_10, .keep_all = TRUE)
  summary(df2)

  n_distinct(df2)
  n_distinct(df2['ID_05'])
  
  # Document why for removing duplicates
  fileConn <- file("01.duplicate.why.txt")
  writeLines(c("duplicating responses across the items"), fileConn)
  close(fileConn)
  
# Exercise 3. Create tidy datasets
  
  # Split the untidy dataset into tidy datasets
  
  df_cattle <- df2 [, c("ID_03", "ID_05",
                        "ID_06", "ID_07",
                        "ID_08", "ID_09", 
                        "ID_10", "AA01_1", "AA01_2", "AA02_1", "AA02_2")]
  
  #assets_df <- df %>%
    #select(any_of(c(id_vars,
                    #asset_vars))) %>%
    #pivot_longer(cols = any_of(asset_vars),
                 #names_to = c('.value',
                              #'asset')
                 #names_sep = '_')
  
  print("tidying complete")

  
  