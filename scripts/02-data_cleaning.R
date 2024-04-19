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
  drop_na() |>
  mutate(broad_position = case_when(
    pos %in% c("SG", "PG", "SG-PG", "PG-SG") ~ "G",  # Guard
    pos %in% c("SF", "PF", "PF-SF", "SF-PF", "SF-SG") ~ "F",  # Forward
    pos %in% c("C", "PF-C", "C-PF") ~ "C"
    ),
    fg_percent = fg_percent * 100,
    x3p_percent = x3p_percent * 100,
    x2p_percent = x2p_percent * 100,
    e_fg_percent = e_fg_percent * 100,
    ft_percent = ft_percent * 100
  ) |>
  select(-player, -rk, -tm, -pos, -fg, -fga, -x3p, -x3pa, -x2p, -x2pa, -ft, -fta, -trb) |>
  mutate(id = row_number()) |> # assigning identifier for each player (treating the same player in a different team a different player)
  relocate(id, .before = 1) # making the id variable the first column in the dataset

#### Save data ####
write_parquet(cleaned_data, "data/analysis_data/analysis_data.parquet")

