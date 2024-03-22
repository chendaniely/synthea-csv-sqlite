library(DBI)
library(RSQLite)

# download and extract the zip data -----

download.file(
  "https://synthetichealth.github.io/synthea-sample-data/downloads/synthea_sample_data_csv_apr2020.zip",
  destfile = "data/synthea_sample_data_csv_apr2020.zip"
)

unzip("data/synthea_sample_data_csv_apr2020.zip", exdir = "data")

# read the csvs

table_csv_names <- list.files("data/csv", pattern = "*.csv", full.names = TRUE)

# extract the file name without the extension
table_names <- sub("\\.csv$", "", basename(table_csv_names))

# read the data

dfs <- mapply(read.csv, table_csv_names, SIMPLIFY = FALSE)
names(dfs) <- table_names

# create the SQLite database -----

mydb <- dbConnect(RSQLite::SQLite(), "data/synthea.sqlite")


# create the tables -----

mapply(dbWriteTable, names(dfs), dfs, MoreArgs = list(conn = mydb))

# disconnect from the database -----

dbDisconnect(mydb)
