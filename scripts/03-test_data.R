#### Preamble ####
# Purpose: Tests the processed dataset analysis_data
# Author: Yihang Cai
# Date: 30 Mar 2024
# Contact: Yihang.cai.nz@gmail.com
# Any other information needed? Some of the codes are adapted from Telling Stories with Data by Rohan Alexander

#### Workspace setup ####
library(tidyverse)
library(testthat)
library(arrow)

#### Test data ####
analysis_data <- read_parquet("data/analysis_data/analysis_data.parquet")

# Test Data Types
test_that("Data types are correct", {
  expect_type(analysis_data$id, "integer")
  expect_type(analysis_data$age, "double")
  expect_type(analysis_data$g, "double")
  expect_type(analysis_data$gs, "double")
  expect_type(analysis_data$mp, "double")
  expect_type(analysis_data$fg_percent, "double")
  expect_type(analysis_data$x3p_percent, "double")
  expect_type(analysis_data$x2p_percent, "double")
  expect_type(analysis_data$e_fg_percent, "double")
  expect_type(analysis_data$ft_percent, "double")
  expect_type(analysis_data$orb, "double")
  expect_type(analysis_data$drb, "double")
  expect_type(analysis_data$ast, "double")
  expect_type(analysis_data$stl, "double")
  expect_type(analysis_data$blk, "double")
  expect_type(analysis_data$tov, "double")
  expect_type(analysis_data$pf, "double")
  expect_type(analysis_data$pts, "double")
  expect_type(analysis_data$broad_position, "character")
})

# Test Max/Min Values for each variable
test_that("Games_Played, Points, and Assists are within expected ranges", {
  expect_true(all(analysis_data$g >= 1 & analysis_data$gs >= 0))
  expect_true(all(analysis_data$pts >= 0))
  expect_true(all(analysis_data$ast >= 0))
})

# Test Total Number of Observations
test_that("Total number of observations is correct", {
  expect_equal(nrow(analysis_data), 616)
})

# Test Total Number of variables
test_that("Total number of variables is correct", {
  expect_equal(ncol(analysis_data), 19)
})

# Test no NA values
test_that("There are no missing values in key columns", {
  expect_true(all(!is.na(analysis_data$id)))
  expect_true(all(!is.na(analysis_data$age)))
  expect_true(all(!is.na(analysis_data$g)))
  expect_true(all(!is.na(analysis_data$gs)))
  expect_true(all(!is.na(analysis_data$mp)))
  expect_true(all(!is.na(analysis_data$fg_percent)))
  expect_true(all(!is.na(analysis_data$x3p_percent)))
  expect_true(all(!is.na(analysis_data$x2p_percent)))
  expect_true(all(!is.na(analysis_data$e_fg_percent)))
  expect_true(all(!is.na(analysis_data$ft_percent)))
  expect_true(all(!is.na(analysis_data$orb)))
  expect_true(all(!is.na(analysis_data$drb)))
  expect_true(all(!is.na(analysis_data$ast)))
  expect_true(all(!is.na(analysis_data$stl)))
  expect_true(all(!is.na(analysis_data$blk)))
  expect_true(all(!is.na(analysis_data$tov)))
  expect_true(all(!is.na(analysis_data$pf)))
  expect_true(all(!is.na(analysis_data$pts)))
  expect_true(all(!is.na(analysis_data$broad_position)))
})

# Ensure broad_position contains only expected categories
test_that("Player and Team contain only valid categories", {
  expect_true(all(analysis_data$broad_position %in% c("C", "F", "G")))
})

