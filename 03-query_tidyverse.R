library(tidyverse)
library(RSQLite)

con <- DBI::dbConnect(RSQLite::SQLite(), "data/synthea.sqlite")

patients <- tbl(con, "patients")

patients |>
  count(STATE)

patients |>
  count(CITY)

patients |>
  count(RACE, ETHNICITY)
