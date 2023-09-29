# Workshop: "Think Large, Dive Deep: Mastering Administrative Data"
# Exercise Template
# Instructor: Ruggero Doino (Research Analyst, DIME 3)
# Date: 28th September 2023
# Purpose: 
# 

# 0: Setting R ----

# Clean the workspace
rm(list=ls()) 

# Free Unused R memory
gc()

# Options for avoid scientific notation
options(scipen = 9999)

# Set the same seed for reproducibility
set.seed(123)

# list of package needed
packages <- 
  c( 
    "data.table",
    "dplyr",
    "stringr",
    "lubridate"
  )

# If the package is not installed, then install it 
if (require("pacman")) install.packages("pacman")

# Load the packages 
pacman::p_load(packages, character.only = TRUE, install = TRUE)


# 1: Setting Working Directories ----

# Setting path
if (Sys.getenv("USER") == "ruggerodoino") { # RA (World Bank-DIME)
  
  print("Ruggero has been selected")
  data  <- "/Users/rhyslim/Documents/GitHub/rrf-training-2023/data"
  
}

# 2: DATA SOURCE ----  
# 

# Load offer-level data
data_offer <- fread(
  input            = file.path(data, "data_offers.csv"),
  encoding         = "Latin-1",
  stringsAsFactors = FALSE, 
  colClasses       = c("character", 
                       "character",
                       "character",
                       "factor",
                       "character",
                       "numeric", 
                       "character", 
                       "character",
                       "character"), 
  na.strings       = c("N/A", "Unknown"),
  showProgress     = TRUE
)

# Load payment-level data
data_payments <- fread(
  input            = file.path(data, "data_payments.csv"),
  encoding         = "Latin-1",
  stringsAsFactors = FALSE, 
  colClasses       = c("character", 
                       "numeric", 
                       "character",
                       "character"), 
  na.strings       = c("N/A", "Unknown"),
  showProgress     = TRUE
)

# Load firm-level data
data_firms <- fread(
  input            = file.path(data, "data_firm.csv"),
  encoding         = "Latin-1",
  stringsAsFactors = FALSE, 
  colClasses       = c("character", 
                       "character", 
                       "numeric",
                       "numeric"), 
  na.strings       = c("N/A", "Unknown"),
  showProgress     = TRUE
)

# 3: DATA STRUCTURE ----
#   

{ # offers-level
  
  # Look at the data
  View(head(data_offer))
  
  # Column names
  names(data_offer)
  
  # Data types
  sapply(data_offer, class)
  
  # Some descriptive statistics
  summary(data_offer)
  
  # What's our unit of observation?
  
  # What's the unique Identifier? 
  # Alternative: you can use the function (`eeptools::isid`)
  nrow(data_offer) == uniqueN(data_offer, by = "tender")
  
  # Then, what should we do?
  data_offer[, id_offer := as.character(.I)]
  
  # Ever heard of Law of Large Numbers? Always check your actions!
  nrow(data_offer) == uniqueN(data_offer, by = "id_offer")
  
  # Let's check our unit of analysis
  View(head(data_offer))
  
}

{ # payment-level
  
  # Look at the data
  View(head(data_payments))
  
  # Column names
  names(data_payments)
  
  # Data types
  sapply(data_payments, class)
  
  # Some descriptive statistics
  summary(data_payments)
  
  # What's our unit of observation?
  
  # What's the unique Identifier? 
  # Alternative: you can use the function (`eeptools::isid`)
  nrow(data_payments) == uniqueN(data_payments, by = "id_payment")
  
  # Let's check our unit of analysis
  View(head(data_payments))
  
}

{ # firms-level
  
  # Look at the data
  View(head(data_firms))
  
  # Column names
  names(data_firms)
  
  # Data types
  sapply(data_firms, class)
  
  # Some descriptive statistics
  summary(data_firms)
  
  # What's our unit of observation?
  
  # What's the unique Identifier? 
  # Alternative: you can use the function (`eeptools::isid`)
  nrow(data_firms) == uniqueN(data_firms, by = c("id_firm_rut", "cat_year"))
  
  # Let's check our unit of analysis
  View(head(data_firms))
  
}

# 4: DATA HARMONIZATION
#  

# Rename the variables accordingly
data_offer <- setNames(data_offer, c(
  "tender"      = "id_tender",
  "firm_rut"    = "id_firm_rut",
  "buyer"       = "id_buyer",
  "select"      = "ind_offer_select",
  "offer send"  = "dt_offer_send", 
  "value offer" = "amt_offer_value", 
  "offer open"  = "dt_offer_start",
  "offer_close" = "dt_offer_close",
  "dt_signature"= "dt_signature",
  "id_offer"    = "id_offer"
))

# Harmonize the variables 
# In this case, only dates were left out
# 
# We select the columns of interest
cols_to_modify <- grep("^dt_", names(data_offer), value = TRUE)

# We modify the class of each variable in the list
data_offer[, (cols_to_modify) := lapply(.SD, lubridate::ymd), .SDcols = cols_to_modify]

# We test it
sapply(data_offer, class)

{ #  - RUN IT without thinking twice - 
  
  # payment-level data
  cols_to_modify <- grep("^dt_", names(data_payments), value = TRUE)
  data_payments[, (cols_to_modify) := lapply(.SD, lubridate::ymd), .SDcols = cols_to_modify]
  
}

# 5: DATA INCONSISTENCIES AND SAMPLE IMBALANCES ----
#  

# We will need to focus on these variables:
# id_tender
# id_buyer
# id_firm_rut
# amt_offer_value
#

# Summarise the value of amt_offer_value to see if we notice any issues 
summary(data_offer)
summary(data_firms)
summary(data_payments)
summary(data_payments$amt_payment_value)

summary(data_offer$amt_offer_value)

# Do all the values make sense? You can manipulate some values but justify and report your choices!
data_offer[, amt_offer_value := ifelse(amt_offer_value == 0, NA, amt_offer_value)]
summary(data_offer$amt_offer_value)


# Check the value distribution and see if you need to do some more manipulation 
# tip: DescTools::Winsorize(amt_offer_value, probs = c(0.01, 0.99)
install.packages("DescTools")
library(DescTools)
data_offer[, amt_offer_value := Winsorize(amt_offer_value, probs = c(0.01, 0.99), ra.rm=TRUE, type = 7)]




# Create a "dt_year" variable starting from "dt_offer_start" and check if there are issues with that
#  tip: lubridate::year()




# How many levels of analysis do we have?
# How many aggregation steps should you take, then?
# Think ahead what your data strategy will be using
# (Bonus Question) Can you think of some unusual circumstances when it comes to count single firms?





# 6: DATA INTEGRATION ----
#  

# 10 Top Slowest Buyers - Avg Number of Bidders 
# AVERAGE DELAY is equal to the difference between "dt_signature" and "dt_payment"
# tip: lubridate::as.duration(dt_payment - dt_signature)
# diff
# 
# First, we need to aggregate to the tender level the offers




# Then you want to merge the data with the payment dataset




# Let's compute the average delay 




# We collapse data at the tender level first





# Then, we collapse data at the buyer level and extract the first 10






# 
# First, we need to select the first 10 sellers by amount contracted





# Then we want to merge that with the firm data (we only focus on the size in 2018)
# 








