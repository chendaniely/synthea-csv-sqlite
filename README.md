# Synthea CSV data to SQLite

Code to download the Synthea (Synthetic Patient Generation) into a SQLite file

## Setup and Download Data

If you have R installed, you will need the following packages to get the data
and create the `sqlite` file

```r
install.packages(c("DBI", "RSQLite"))
```

From there, you can run all the code in the `01-create_sqlite.R` file to download
the data and create the `synthea.sqlite` file.
It will be saved into the `data/` directory.

```
Rscript 01-create_sqlite.R
```

## Example queries

The `02-query_data.R` file provides code on how you can connect to the `sqlite` database,
and write SQL to query the database.

```r
library(DBI)
library(RSQLite)

mydb <- dbConnect(RSQLite::SQLite(), "data/synthea.sqlite")

dbGetQuery(mydb, 'SELECT * FROM patients LIMIT 5')

dbDisconnect(mydb)
```

You can also opt to use the `tidyverse` packages to query the data.
Make sure you have `tidyverse` installed.

```r
install.packages('tidyverse')
```

Then you can use the following code in the `03-querty_tidyverse.R` file to
query the data.

```r
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
```
