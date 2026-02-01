# Jennifer Selgrath
# Hopkins Marine Station
# July 12, 2022

# goal: using info from old time search.csv for oldHopkinsData file (they each have some info, but not all for the same surveys in 2005)
# ------------------------------------------------------------------------
library(tidyverse); library(readxl); library (lubridate)
# --------------------------------------------------------------------------
remove(list=ls())
setwd("C:/Users/jselg/Dropbox/research_x1/R_projects/mbc/black_abalone")

# Old_TimeSearch.csv
# This data is from 2005
# note HMS 2005 is in both datasets. Dealt with below...
d1<-read_csv("./data/Old_TimeSearch.csv")%>%
  select(Site:Checked)%>%
  mutate(date2=Date)%>%
  separate(date2,c("year","month","day"),sep=c(4,6))%>%
  mutate(
    year=as.numeric(year),
    month=as.numeric(month),
    day=as.numeric(day),
    length_search_min=80)%>%
  select(site=Site, exp_protected=`Exp/Protected`, date=Date,size_cm=`Size (cm)`,investigators=Investigators,year,length_search_min)%>%
  arrange(date,site,investigators,size_cm)%>%
  glimpse()

# summarizing for checking 
# dates surveyed in a year to determine what to do next. Only one date per year.
d1%>%
  group_by(site,date,investigators)%>%
  summarize(n=n())




# OldHopkinsData_TimedSearches --------------------------------------------------------
# data is only from Hopkins - years: 2005,2014,2015,2016,2017
d2<-read_csv("./data/OldHopkinsData_TimedSearches.csv")%>%
  select(Site:`Exposed/Protected`)%>%
  glimpse()

# cleaning names etc
d2a<-d2%>%
  select(site=Site, year=Date, size_cm=`Size (cm)`,investigators=Investigators,length_search_min=`Length of Search (min)`)%>%
    arrange(year,site,investigators,size_cm)%>%
  glimpse()
  
# data is only from Hopkins - years: 2005,2014,2015,2016,2017
d2a%>%
  group_by(site,year,investigators)%>%
  summarize(n=n())





# checking out # of people, number of datapoints (same in both files) ----------------------------------------------
d1%>%
  group_by(site,date,investigators)%>%
  summarize(n=n())

d1%>%
  group_by(site,date)%>%
  summarize(n=n())

d2a%>%
  group_by(site,year,investigators,length_search_min)%>%
  summarize(n=n())

d2a%>%
  group_by(site,year)%>%
  summarize(n=n())



# take apart datasets so can put back together -------------------------------------------------------------


# set protected variable for HMS
d2a$exp_protected<-"Protected"
d2a$date="999999"

# just Hopkins subset
# pull this out because duplicated - DO NOT USE
d1_h<-d1%>%
  filter(site=="Hopkins")%>%
  glimpse()

# other sites
d1_o<-d1%>%
  filter(site!="Hopkins")%>%
  glimpse()

# just 2005 data
d2_h_05<-d2a%>%
  filter(year==2005)%>%
  glimpse()

d2_h_05$date<-20050413

# other years
d2_h_o<-d2a%>%
  filter(year!=2005)%>%
  glimpse()
d2_h_o$date<-NA


# rejoin other years at HMS to 2005 with 2005 dates
d4<-rbind(d2_h_05,d2_h_o)%>%
  select(site, exp_protected, date,size_cm,investigators,length_search_min,year)%>%
  glimpse()

# add other 2005 sites
d1_o1<-d1_o%>%
  mutate(length_search_min=80)%>% #based on talking to Fio - see Micheli et al 2008 Con Bio for methods 
  select(site, exp_protected, date,size_cm,investigators,length_search_min,year)%>%
  glimpse()

# combine both datasets
d5<-rbind(d1_o1,d4)%>%
  mutate(species="H_cracherodii")%>%
  glimpse()

# make all times 80 min - confirmed that regardless of the number of people, 

# save
write_csv(d5,"./results/old_data_cleaned1.csv")

