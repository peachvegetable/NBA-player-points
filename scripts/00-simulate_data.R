#### Preamble ####
# Purpose: Simulates a simple dataset of student scores for planning
# Author: Yihang Cai
# Date: 30 Mar 2024
# Contact: Yihang.cai.nz@gmail.com
# Any other information needed? Some of the codes are adapted from Telling Stories with Data by Rohan Alexander


#### Workspace setup ####
library(dplyr)
library(tibble)
library(testthat)

#### Simulate data ####
set.seed(123)  # For reproducibility

n <- 100  # Number of samples

data <- tibble(
  ID = 1:n,
  Gender = sample(c("Male", "Female"), n, replace = TRUE),
  StudyTime = round(runif(n, 1, 10), 1),  # Study time in hours per week, from 1 to 10
  Extracurricular = sample(c("Yes", "No"), n, replace = TRUE)
)

# Normal distribution - good for continuous data
data$Scores <- round(rnorm(n, mean = 75, sd = 10), 0)
# Ensure scores are within a plausible range, e.g., 0 to 100
data$Scores <- pmax(pmin(data$Scores, 100), 0)

print(head(data))

### Tests ###
# Test Data Types
test_that("Data types are correct", {
  expect_type(data$ID, "integer")
  expect_type(data$Gender, "character")
  expect_type(data$StudyTime, "double")
  expect_type(data$Extracurricular, "character")
  expect_type(data$Scores, "double")
})

# Test Max/Min Values for StudyTime and Scores
test_that("StudyTime and Scores are within expected ranges", {
  expect_true(all(data$StudyTime >= 1 & data$StudyTime <= 24 * 7))
  expect_true(all(data$Scores >= 0 & data$Scores <= 100))
})

# Test Total Number of Observations
test_that("Total number of observations is correct", {
  expect_equal(nrow(data), 100)
})

# Test no NA values
test_that("There are no missing values in key columns", {
  expect_true(all(!is.na(data$Gender)))
  expect_true(all(!is.na(data$StudyTime)))
  expect_true(all(!is.na(data$Extracurricular)))
  expect_true(all(!is.na(data$Scores)))
})

# Ensure Gender and Extracurricular only contain expected categories
test_that("Gender and Extracurricular contain only valid categories", {
  expect_true(all(data$Gender %in% c("Male", "Female")))
  expect_true(all(data$Extracurricular %in% c("Yes", "No")))
})




