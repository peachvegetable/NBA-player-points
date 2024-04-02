#### Preamble ####
# Purpose: Models generated for predicting students' performances based on aspects like extracurricular_activities, weekly_self_study_hours, etc
# Author: Yihang Cai
# Date: 30 Mar 2024
# Contact: Yihang.cai.nz@gmail.com
# Any other information needed? Some of the codes are adpated from Telling Stories with Data by Rohan Alexander


#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(tidymodels)
library(arrow)

#### Read data ####
analysis_data <- read_parquet("data/analysis_data/analysis_data_1.parquet")

### Model data ####

set.seed(321) # For reproducibility
data_split <- initial_split(analysis_data, prop = 0.8)
train_data <- training(data_split)
test_data <- testing(data_split)

# preprocesssing with recipe
data_recipe <- recipe(pts ~ ., data = train_data) |>
  step_rm(player) |>
  step_normalize(all_numeric_predictors()) |>
  step_dummy(broad_position)

lasso_spec <- linear_reg(penalty = tune(), mixture = 1) |>
  set_engine("glmnet")

# create the workflow
lasso_workflow <- workflow() |>
  add_recipe(data_recipe) |>
  add_model(lasso_spec)

# tune the model for the best lambda
set.seed(123)
# cross-validation setup
cv_folds <- vfold_cv(train_data, v = 5)

lasso_results <- tune_grid(
  lasso_workflow,
  resamples = cv_folds,
  grid = 50
)

best_result <- lasso_results |>
  collect_metrics() |>
  filter(.metric == "rmse") |>
  arrange(mean) |>
  slice(1) |>
  select(penalty)

final_lasso_workflow <- finalize_workflow(
  lasso_workflow,
  best_result
)

# fit the model
first_lasso_model <- fit(final_lasso_workflow, data = train_data)

predictions <- predict(first_lasso_model, test_data)
results <- bind_cols(test_data, predictions)
# Calculate RMSE
rmse_results <- rmse(results, truth = pts, estimate = .pred)
rsq_results <- rsq(results, truth = pts, estimate = .pred)







analysis_data_1 <- read_parquet("data/analysis_data/analysis_data_1.parquet")
analysis_data_1$age_squared = analysis_data_1$age^2
analysis_data_1$pts_per_min = analysis_data_1$pts / analysis_data_1$mp
analysis_data_1$ast_per_min = analysis_data_1$ast / analysis_data_1$mp

### Model data ####

set.seed(123) # For reproducibility
data_split <- initial_split(analysis_data_1, prop = 0.8)
train_data <- training(data_split)
test_data <- testing(data_split)

# preprocesssing with recipe
data_recipe <- recipe(pts ~ ., data = train_data) |>
  step_rm(player) |>
  step_normalize(all_numeric_predictors()) |>
  step_dummy(broad_position)

lasso_spec <- linear_reg(penalty = tune(), mixture = 1) |>
  set_engine("glmnet")

# create the workflow
lasso_workflow <- workflow() |>
  add_recipe(data_recipe) |>
  add_model(lasso_spec)

# tune the model for the best lambda
set.seed(123)
# cross-validation setup
cv_folds <- vfold_cv(train_data, v = 5)

lasso_results <- tune_grid(
  lasso_workflow,
  resamples = cv_folds,
  grid = 50
)

best_result <- lasso_results |>
  collect_metrics() |>
  filter(.metric == "rmse") |>
  arrange(mean) |>
  slice(1) |>
  select(penalty)

final_lasso_workflow <- finalize_workflow(
  lasso_workflow,
  best_result
)

# fit the model
second_lasso_model <- fit(final_lasso_workflow, data = train_data)

predictions <- predict(second_lasso_model, test_data)
results <- bind_cols(test_data, predictions)
# Calculate RMSE
rmse_results_2 <- rmse(results, truth = pts, estimate = .pred)
rsq_results_2 <- rsq(results, truth = pts, estimate = .pred)


#### Save model ####
saveRDS(
  first_lasso_model,
  file = "models/first_lasso_model.rds"
)


