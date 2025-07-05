library(tidyverse)
library(janitor)
library(forcats)

# Read and clean the data
ai_raw <- read_csv("data/Survey_AI.csv")

# Preview the data
#glimpse(ai_raw)

# Step 2: Clean data
ai_clean <- ai_raw %>%
  clean_names() %>%
  select(
    id,
    ai_knowledge         = q1_ai_knowledge,
    ai_sources           = q2_ai_sources,
    internet             = q2_number_1_internet,
    books_papers         = q2_number_2_books_papers,
    social_media         = q2_number_3_social_media,
    discussions          = q2_number_4_discussions,
    not_informed         = q2_number_5_not_informed,
    job_replacement      = q3_number_2_job_replacement,
    problem_solving      = q3_number_3_problem_solving,
    ai_costly            = q4_number_1_ai_costly,
    economic_growth      = q4_number_3_economic_growth,
    utility_grade        = q7_utility_grade,
    gender               = q12_gender,
    year_of_study        = q13_year_of_study,
    major                = q14_major,
    gpa                  = q16_gpa
  ) %>%
  mutate(
  ai_sources      = as.character(ai_sources),
  ai_knowledge    = as.numeric(ai_knowledge),
  major           = fct_lump_min(as.character(major), 5),
  job_replacement = factor(job_replacement, levels = c(0,1), labels = c("Disagree", "Agree")),
  utility_grade   = factor(utility_grade, levels = 1:5,
                           labels = c("Very Low", "Low", "Medium", "High", "Very High"))
)
write_rds(ai_clean, "data/ai_clean.rds")
