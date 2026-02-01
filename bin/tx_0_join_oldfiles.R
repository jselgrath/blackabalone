# Jennifer Selgrath
# Hopkins Marine Station
# Historical Black Abalone

# goal: using info from old TRANSECT.csv for oldHopkinsData file (they each have some info, but not all for the same surveys in 2005)
# ------------------------------------------------------------------------
library(tidyverse); library(readxl); library (lubridate)
# --------------------------------------------------------------------------
remove(list=ls())
setwd("C:/Users/jselg/Dropbox/research_x1/R_projects/mbc/black_abalone")

# Old_TimeSearch.csv
# This data is from 2002. Hopkins 2002 appears in both datasets
d1<-read_csv("./data/Old_Transect_totals.csv")%>%
  filter(Species=="H. cracherodii")%>%
  mutate(date2=mdy(Date))%>%
  mutate(
    year=year(date2),
    month=month(date2),
    day=day(date2),
    tx_area=2*`Transect length (m)`,
    density_m2=9999)%>%
  select(site=Site, year,species=Species,transect=Transect,tx_length=`Transect length (m)`,tx_area,no_indv=`Number of Individuals`, investigators=Investigator, density_m2, date=date2)%>%
  mutate(density_m2=round((no_indv/tx_area),4))%>%
  arrange(year,site)%>%
  mutate(species="H_cracherodii")%>%
  glimpse()

# summarizing for checking 
# dates surveyed in a year to determine what to do next. Only one date per year.
d1%>%
  group_by(site,year)%>%
  summarize(n=n())


# OldHopkinsData_TimedSearches --------------------------------------------------------
# data is only from Hopkins - years: 2005,2014,2015,2016,2017
d2<-read_csv("./data/OldHopkinsData_TransectTotals.csv")%>%
  select(Site:Investigator)%>% # ditch extra columns
  drop_na(Date)%>% # ditch blank rows at end
  mutate(species="H_cracherodii")%>%
  glimpse()

# cleaning names etc
d2a<-d2%>%
  select(site=Site, year=Date, species,transect=Transect,tx_length=`Transect length`,no_indv=`Number of Individuals`,tx_area="Transect area (sq meter)",investigators=Investigator)%>%
  arrange(year,site,transect)%>%
  mutate(density_m2=round((no_indv/tx_area),4))%>%
  glimpse()

levels(as.factor(d2a$tx_area))
  
# data is only from Hopkins - years: 2002,2010,2011-2016
d2a%>%
  group_by(site,year)%>%
  summarize(n=n())


# checking out # of people, number of datapoints (same in both files) ----------------------------------------------
d1%>%
  group_by(site,date,investigators)%>%
  summarize(n=n())

d1%>%
  group_by(site,date)%>%
  summarize(n=n())

d2a%>%
  group_by(site,year,investigators)%>%
  summarize(n=n())

d2a%>%
  group_by(site,year)%>%
  summarize(n=n())



# take apart data sets so can put back together -------------------------------------------------------------
glimpse(d1)
glimpse(d2a)

# set protected variable for HMS
# d2a$exp_protected<-"Protected"
d2a$date="999999"

# just Hopkins subset
# REMOVE THIS BECAUSE A DUPLICATE
d1_h<-d1%>%
  filter(site=="Hopkins")%>%
  glimpse()

# other sites
d1_o<-d1%>%
  filter(site!="Hopkins")%>%
  glimpse()

# just 2002 data
d2_h_02<-d2a%>%
  filter(year==2002)%>%
  glimpse()

d2_h_02$date<-20020908

# other years
d2_h_o<-d2a%>%
  filter(year!=2002)%>%
  glimpse()
d2_h_o$date<-NA


# rejoin other years at HMS to 2005 with 2005 dates
d4<-rbind(d2_h_02,d2_h_o)%>%
  select(site, year,date,species,investigators,transect,tx_length_m=tx_length,tx_area,no_indv,density_m2)%>%
  mutate(date=ymd(date))%>%
  glimpse()

# add other 2002 sites
d1_o1<-d1_o%>%
  select(site, year,date,species,investigators,transect,tx_length_m=tx_length,tx_area,no_indv,density_m2)%>%
  glimpse()

# combine both datasets
d5<-rbind(d1_o1,d4)%>%
  glimpse()

unique(d5$species)
levels(as.factor(d5$species))

# save
write_csv(d5,"./results/tx_old_data_cleaned1.csv")
