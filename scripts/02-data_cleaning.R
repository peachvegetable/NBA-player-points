#### Preamble ####
# Purpose: Cleans the raw data of basketball player stats, and then selecting only the relevant variables in the dataset
# Author: Yihang Cai
# Date: 30 Mar 2024
# Contact: Yihang.cai.nz@gmail.com
# Any other information needed? Some of the codes are adapted from Telling Stories with Data by Rohan Alexander

#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Clean data ####
raw_data <- read_csv("data/raw_data/raw_data.csv")

# Guards (G): "SG", "PG", "SG-PG", "PG-SG"
# Forwards (F): "SF", "PF", "PF-SF", "SF-PF", "SF-SG"
# Centers (C): "C", "PF-C", "C-PF"

cleaned_data <-
  raw_data |>
  janitor::clean_names() |>
  mutate(broad_position = case_when(
    pos %in% c("SG", "PG", "SG-PG", "PG-SG") ~ "G",  # Guard
    pos %in% c("SF", "PF", "PF-SF", "SF-PF", "SF-SG") ~ "F",  # Forward
    pos %in% c("C", "PF-C", "C-PF") ~ "C"
    )
  ) |>
  select(-player, -tm, -pos, -fg, -fga, -x3p, -x3pa, -x2p, -x2pa, -ft, -fta, -trb) |>
  tidyr::drop_na()


#### Save data ####
write_parquet(cleaned_data, "data/analysis_data/analysis_data.parquet")

