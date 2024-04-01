#### Preamble ####
# Purpose: Models generated for predicting students' performances based on aspects like extracurricular_activities, weekly_self_study_hours, etc
# Author: Yihang Cai
# Date: 30 Mar 2024
# Contact: Yihang.cai.nz@gmail.com
# Any other information needed? Some of the codes are adpated from Telling Stories with Data by Rohan Alexander


#### Workspace setup ####
library(tidyverse)
library(arrow)
library(rstanarm)
library(rsample)

#### Read data ####
analysis_data <- read_parquet("data/analysis_data/analysis_data.parquet")

### Model data ####
first_model <-
  stan_glm(
    formula = flying_time ~ length + width,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )


#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)


