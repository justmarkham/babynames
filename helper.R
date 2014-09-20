library(babynames)
library(dplyr)
library(reshape2)

# convert the babynames data into a local data frame
bn <- tbl_df(babynames)

# change sex from F/M to Female/Male
bn$sex <- ifelse(bn$sex=="F", "Female", "Male")

# add the lowercase name as a new variable "lname"
bn <- bn %>% mutate(lname = tolower(name))

# create a vector of all unique names
bn.unique <- unique(bn$lname)

# create a data frame of lname, most popular year for that name,
# and count for that year
bn.topyear <- bn %>% group_by(lname, year) %>% summarise(count=sum(n)) %>%
    filter(row_number(desc(count))==1)

# create a data frame of lname, all-time count of Female and Male,
#and all-time total
bn.alltime <- bn %>% group_by(lname, sex) %>% summarise(count=sum(n)) %>%
    dcast(lname ~ sex, value.var="count") %>% tbl_df()
bn.alltime[is.na(bn.alltime)] <- 0
bn.alltime <- bn.alltime %>% mutate(total=Female+Male)

# remove unnecessary columns from bn
bn$name <- NULL
bn$prop <- NULL

# save data objects for use by server.R
saveRDS(bn, "bn.rds")
saveRDS(bn.unique, "bn.unique.rds")
saveRDS(bn.topyear, "bn.topyear.rds")
saveRDS(bn.alltime, "bn.alltime.rds")
