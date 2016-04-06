
library(ggplot2)
library(dplyr)
library(knitr)
library(tidyr)

# Data Processing
data.raw <- read.csv("C:/Users/USER/Desktop/csen1061-project1-traffic-data-analysis/all-semi-unique.csv")

glimpse(data.raw)


data.road <- data.raw %>% select(-(starts_with("ad.")))

data.road %>%sapply(unique) %>%sapply(length)

data.road <- data.road %>% select(-(rd.cl), -(rd.rp.type))

head(data.road$crawl_date)

data.road$crawl_date <- strptime(data.road$crawl_date, format = "%a %b %e %X UTC %Y", tz = "UTC") %>% as.POSIXct()

head(data.road$crawl_date)

data.road <- data.road %>% mutate(report_time = as.POSIXct(round(crawl_date - (rd.rp.hr*60*60 + rd.rp.mn*60), "mins"))) %>% select(-c(rd.rp.mn, rd.rp.hr))

glimpse(data.road)

data.road <- data.road %>% separate(rd.nm, c("rd.majornm", "rd.minornm"), ";")

data.road$rd.minornm[is.na(data.road$rd.minornm)] <- "general"

glimpse(data.road)

