#### Preamble ####
# Purpose: Downloads and saves the data from basketball reference
# Author: Yihang Cai
# Date: 30 Mar 2024
# Contact: Yihang.cai.nz@gmail.com
# Any other information needed? Some of the codes are adapted from Telling Stories with Data by Rohan Alexander

#### Workspace setup ####
library(tidyverse)
library(arrow)

# raw data is downloaded directed from basketball reference on this website: https://www.basketball-reference.com/leagues/NBA_2024_totals.html
raw_data <- read_csv("data/raw_data/raw_data.csv")

# convert the dataset to UTF-8
raw_data <- raw_data |>
  mutate(across(where(is.character), ~iconv(., from = "Windows-1252", to = "UTF-8")))


write_parquet(raw_data, "data/raw_data/raw_data.parquet")

         
