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

data.road <- data.road %>% separate(rd.nm, c("rd.primary", "rd.secondary"), ";")

data.road$rd.secondary[is.na(data.road$rd.secondary)] <- "general"

glimpse(data.road)

data.road <- data.road %>% select(-(rd.rp.rpImg), -(rd.rp.img))

data.road <- data.road %>% select(-(rd.img))

glimpse(data.road)

#data.raw678 <- data.road[data.road$rd.ri==678,]
#data.raw6788 <- subset(data.road, rd.ri == 678)

data.road.status <- data.road %>% select(crawl_date, rd.ri, rd.stid) %>% unique()

glimpse(data.road.status)
