library(dplyr)
library(purrr)
library(RPostgres)
library(plyr)

creds <- list(db_uid=getOption("db_uid"), db_pw=getOption("db_pw"))

con <- dbConnect(drv=RPostgres::Postgres(),
                 host="localhost",
                 db="test1",
                 user=creds[[1]],
                 password=creds[[2]],
                 bigint="numeric")


get_all <- function(...){
    tbls <- dbListTables(...)
   
    o <- lapply(seq_along(tbls), function(x) dbReadTable(con, tbls[x]))
     names(o) <- tbls
     o
}

get_all(con)
