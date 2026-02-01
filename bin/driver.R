# Jennifer Selgrath
# Stanford Hopkins Marine Station
# Historical Black Abalone

# goal: driver for black abalone data
# ------------------------------------------------------------------------
library(tidyverse); library(readxl)
library(stringr)
library(lubridate)

# --------------------------------------------------------------------------
# setwd("C:/Users/jselg/Dropbox/0Research/R.projects/blackabalone/")
# setwd("C:/Users/jselg/Dropbox/0Research/R.projects/BlackAbalone_2022/")
setwd("C:/Users/jselg/Dropbox/research_x1/R_projects/mbc/black_abalone")


# --------------------------------------------
# contemporary data from Alison/Fio #####


# --------------------------------------------
# timed  searches #########

# join old file from Alison from different years
source("./bin/time_0_join_oldfiles.R")
# input:      ./data/Old_TimeSearch.csv
#             ./data/OldHopkinsData_TimedSearches.csv
# output:     ./results/old_data_cleaned1.csv

# merge older and newer files from Alison, filter for black abalone
source("./bin/time_1_joiningfiles.R")
# input:      ./data/2017_Transects.xlsx",sheet="Transect totals"
#             ./data/2018_Transects.xlsx",sheet="Transect Totals"
#             ./data/2019_Transects.xlsx",sheet="Transect Totals"
#             ./data/2020_Transects.xlsx",sheet="Transect Totals"
#             ./data/2021_Transects.xlsx",sheet="Transect Totals"
#             ./data/2022_Transects.xlsx",sheet="Transect Totals"
#             ./results/tx_old_data_cleaned2.csv
# output:     ./results/tx_data_2002_2022.csv

# add location13 info to match with kelp paper
source("./bin/time_2_location.R")
# input:      ./results/time_data_2005_2022.csv
# output:     ./results/time_data_2005_2022_location13.csv

# summarize data from Alison by location, year
source("./bin/time_3_summarize.R")
# input:      ./results/time_data_2005_2022_location13.csv
# output:     ./results/time_data_2005_2022_sum_by_search_sz.csv
#             ./results/time_data_2005_2022_sum_by_site.csv
#             ./results/time_data_2005_2022_sum_by_location.csv         #  loc and loc3 are the same here
#             ./results/time_data_2005_2022_sum_by_location3.csv


# --------------------------------------------
# transect data #########
source("./bin/tx_0_join_oldfiles_2.R")
# input:    ./data/Old_Transect_totals.csv
#           ./data/OldHopkinsData_TransectTotals.csv
# output:   ./results/tx_old_data_cleaned2.csv #qas 1

# merge older and newer files from Alison, filter for black abalone
source("./bin/tx_1_joiningfiles.R")
# input:    ./data/2017_Transects.xlsx,sheet=Transect totals (etc)
#           ./results/tx_old_data_cleaned1.csv
# output:   ./results/tx_data_2002_2022.csv

# add location13 info to match with kelp paper
source("./bin/tx_2_location.R")
# input:    ./results/tx_data_2002_2022.csv
# output:   ./results/tx_data_2002_2022_location13.csv

# summarize
source("./bin/tx_3_summarize.R")
# input:    ./results/tx_data_2002_2022_location13.csv
# output:   ./results/tx_data_2002_2022_summarized_site.csv
#           ./results/tx_data_2002_2022_summarized_location.csv
#           ./results/tx_data_2002_2022_summarized_location3.csv  


# --------------------------------------------
# redo historical tx data with habitat info

# creates summary data of habitat qualities where abalone were present
source("./bin/tx_0_join_oldfiles_habtiat.R")
# input:    ./data/Old_Transect.xlsx",sheet="Raw Transect
#           ./data/Old_Transect.xlsx",sheet="TransectTotals   # for zero counts
#           ./data/OldHopkinsData.xlsx",sheet="Raw_Transects
#           ./data/OldHopkinsData.xlsx",sheet="TrasectTotals  # for zero counts
# output:   ./results/tx_old_data_cleaned_habitat.csv


# merge older and newer files from Alison, filter for black abalone
source("./bin/tx_1_joiningfiles_habitat.R")
# input:    ./data/2017_Transects.xlsx,sheet=Transect totals (etc)
#           ./results/tx_old_data_cleaned1.csv
# output:   ./results/tx_data_2002_2022.csv

# add location13 info to match with kelp paper
source("./bin/tx_2_location_habitat.R")
# input:    ./results/tx_data_2002_2022.csv
# output:   ./results/tx_data_2002_2022_location13_habitat.csv

# summarize
source("./bin/tx_3_summarize_habitat.R")
# input:    ./results/tx_data_2002_2022_location13_habitat.csv
# output:   ./results/tx_data_2002_2022_summarized_site_habitat.csv #location etc

source("./bin/graph_density_year_boxplots.R")


# --------------------------------------------
# correlation of density and abundance 
source("./bin/time_tx_1_compare.R")
# input:  ./results/tx_data_2002_2022_location13_habitat.csv
# output: ./results/time_data_2005_2022_by_search_sz.csv    

# correlate time and tx desntities
source("./bin/time_tx_2_correlations.R")
# input:  ./results/tx_data_2002_2022_location13_habitat.csv
#         ./results/time_data_2005_2022_sum_by_search_sz.csv
# output: ./results/time_tx_rawsurveys.csv


# --------------------------------------------
# historical and oral history data #####
# --------------------------------------------
source("./bin/blackab_oh_organize.R")
# input:  ./OralHistories/results/otter_kelp_oh_subset_long.csv
# output: ./results/blackab_oh_raw.csv
#         ./results/blackab_oh_summarized_location.csv
#         ./results/blackab_oh_summarized.csv

# combine oral history data and historical data
source("./bin/blackab_hoh_combine.R")
# input:  ./results/blackab_oh_summarized_location.csv
#         
# output: 

# input:  
# output:     

# input:  
# output:     