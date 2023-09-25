# main_script.R

# Step 1. Install necessary packages
install.packages("pacman")
packages <- c("tidyr","dplyr","labelled","stringi","hmisc","stringr")
pacman::p_load(packages, character.only = TRUE, install = TRUE)
# Change to TRUE to install packages

# install.packages("dplyr")
# install.packages("here")

# Here
here('data','state_database.csv')

# Read the data
path <- here('state_database.csv')
path <- here('data','state_database.csv')
df <- read.csv(path)

# Step 2. Source mock-up scripts
source(here('scripts',"01_tidying_script.R"))
source(here('scripts',"02_transforming.R"))
source(here('scripts',"03_visualization.R"))
source(here('scripts',"04_model.R"))

# Step 3. print completion message
print("data analysis complete")

