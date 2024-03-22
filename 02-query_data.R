library(DBI)
library(RSQLite)

mydb <- dbConnect(RSQLite::SQLite(), "data/synthea.sqlite")

dbGetQuery(mydb, 'SELECT * FROM patients LIMIT 5')

dbDisconnect(mydb)
