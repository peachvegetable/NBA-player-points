#### Preamble ####
# Purpose: Cleans the raw data of student scores, merge the two files and then selecting only the relevant variables in the dataset
# Author: Yihang Cai
# Date: 30 Mar 2024
# Contact: Yihang.cai.nz@gmail.com
# Any other information needed? Some of the codes are adapted from Telling Stories with Data by Rohan Alexander

#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Clean data ####
mat_data <- read_csv("data/raw_data/student_mat.csv")
por_data <- read_csv("data/raw_data/student_por.csv")

# merge the data, code is adapted from the instruction of data.world
d1=read.table("student-mat.csv",sep=";",header=TRUE)
d2=read.table("student-por.csv",sep=";",header=TRUE)

d3=merge(mat_data,d2,by=c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet"))
print(nrow(d3)) # 382 students


cleaned_data <-
  raw_data |>
  janitor::clean_names() |>
  select(id, gender, part_time_job, absence_days, extracurricular_activities, weekly_self_study_hours, career_aspiration, math_score, history_score, physics_score, chemistry_score, biology_score, english_score, geography_score) |>
  tidyr::drop_na()

#### Save data ####
write_csv(cleaned_data, "data/analysis_data/analysis_data.csv")
write_parquet(cleaned_data, "data/analysis_data/analysis_data.parquet")
