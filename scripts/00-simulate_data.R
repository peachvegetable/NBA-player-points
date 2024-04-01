#### Preamble ####
# Purpose: Simulates a simple dataset of basketball player stats for planning
# Author: Yihang Cai
# Date: 30 Mar 2024
# Contact: Yihang.cai.nz@gmail.com
# Any other information needed? Some of the codes are adapted from Telling Stories with Data by Rohan Alexander


#### Workspace setup ####
library(tidyverse)
library(testthat)

#### Simulate data ####
# Create a tibble with simulated data
set.seed(42) # For reproducibility
player_stats <- tibble(
  Player = rep(c("John Doe", "Jane Smith", "Alex Johnson"), each = 3), # Each player has stats for 3 teams
  Team = rep(c("Team A", "Team B", "Team C"), times = 3),
  Games_Played = sample(1:82, 9, replace = TRUE), # Random number of games played
  Points = sample(5:30, 9, replace = TRUE), # Random points scored
  Assists = sample(0:10, 9, replace = TRUE) # Random assists
)

print(player_stats)

### Tests ###
# Test Data Types
test_that("Data types are correct", {
  expect_type(player_stats$Player, "character")
  expect_type(player_stats$Team, "character")
  expect_type(player_stats$Games_Played, "integer")
  expect_type(player_stats$Points, "integer")
  expect_type(player_stats$Assists, "integer")
})

# Test Max/Min Values for Games_Played, Points, and Assists
test_that("Games_Played, Points, and Assists are within expected ranges", {
  expect_true(all(player_stats$Games_Played >= 1 & player_stats$Games_Played <= 100))
  expect_true(all(player_stats$Points >= 0))
  expect_true(all(player_stats$Assists >= 0))
})

# Test Total Number of Observations
test_that("Total number of observations is correct", {
  expect_equal(nrow(player_stats), 9) # We have 9 observations as per our creation
})

# Test no NA values
test_that("There are no missing values in key columns", {
  expect_true(all(!is.na(player_stats$Player)))
  expect_true(all(!is.na(player_stats$Team)))
  expect_true(all(!is.na(player_stats$Games_Played)))
  expect_true(all(!is.na(player_stats$Points)))
  expect_true(all(!is.na(player_stats$Assists)))
})

# Ensure Player and Team contain only expected categories
test_that("Player and Team contain only valid categories", {
  expect_true(all(player_stats$Player %in% c("John Doe", "Jane Smith", "Alex Johnson")))
  expect_true(all(player_stats$Team %in% c("Team A", "Team B", "Team C")))
})




