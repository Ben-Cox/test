library(dplyr)
library(RPostgres)

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

tbls <- get_all(con)

lapply(tbls,colnames)

tbls$pets %>% left_join(tbls$owners, by=c("owner_id"="id")) %>% select(-contains("id"))