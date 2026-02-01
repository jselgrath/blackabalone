# Jennifer Selgrath
# Hopkins Marine Station
# Historical Black Abalone

# goal: merging contemporary black abalone data (and checking out the data)
# DATA FROM THE TWO SHEETS DO NOT MATCH. ASK ALISON IF THEY SHOULD! (for 2020)

# Check here to make sure investigators are entered in a standard way for each survey date/site combo
# ------------------------------------------------------------------------
library(tidyverse); library(readxl); library (lubridate)

# --------------------------------------------------------------------------
remove(list=ls())
setwd("C:/Users/jselg/Dropbox/research_x1/R_projects/mbc/black_abalone")

# l1<-list.files(pattern=c('Time','all'))
# l1



# 2017
d1<-read_excel("./data/2017_TimeSearch.xlsx",sheet="Sheet1")%>%
  mutate(notes="NA",year="2017",species="H_cracherodii")%>% # note I updated column names manually for this, but not other files
  select(site=site,exp_protected,species,size_cm,investigators,length_search_min,notes,year)%>%   
  glimpse()
glimpse(d1)

unique(d1$species)

levels(as.factor(d1$length_search_min)) #67 and 80min
levels(as.factor(d1$size_cm))
# 

# check with Alison - can't check here because I entered sp manually
# d1%>%
#   filter(species!="H. rufescens"| species!="H_rufescens")%>%
#   group_by(site,year,investigators)%>%
#   summarize(
#     time=max(length_search_min,na.rm=T),
#     count_ab=n())%>%
#   arrange(site,investigators)


#2018
d2<-read_excel("./data/2018_TimeSearch.xlsx")%>%
  select(site=Location,exp_protected=`Exp/Protected`,species=Species,size_cm=`Size (cm)`  ,investigators=Investigators,length_search_min= `Length of Search (min)`,notes=Notes)%>% 
  mutate(year="2018")%>% 
  filter(species!="H. rufescens")%>%
  glimpse()

d2$investigators[d2$investigators=="EH, AR"]<-"AR, EH"
d2$investigators[d2$investigators=="AR & EH"]<-"AR, EH"

levels(as.factor(d2$length_search_min)) #lots
levels(as.factor(d2$size_cm))

# checking missing - size list and counts don't match in exce, but maybe they should not?
levels(as.factor(d2$species))

d2%>%
  # filter(site=="Carmel Point")%>%
  # filter(site=="Cannery Row")%>%
  # filter(site=="Hopkins")%>%
  filter(site=="Pt Pinos")%>%
  group_by(site,year,investigators)%>%
  summarize(
    time=max(length_search_min,na.rm=T),
    count_ab=n())%>%
  arrange(site,investigators)



  
#2019
d3<-read_excel("./data/2019_TimeSearch.xlsx")%>%
  select(site=Location,exp_protected=`Exp/Protected`,species=Species,size_cm=`Size (cm)`  ,investigators=Investigators,length_search_min= `Length of Search (min)`,notes=Notes)%>% 
  mutate(year="2019")%>% 
  glimpse()

unique(d3$species)
levels(as.factor(d3$length_search_min)) #lots
levels(as.factor(d3$size_cm))
levels(as.factor(d3$species))

d3%>%
  filter(species!="H. rufescens"| species!="H_rufescens")%>%
  # filter(site=="Carmel Bay")%>%
  # filter(site=="Cannery Row")%>%
  # filter(site=="Hopkins")%>%
  filter(site=="Point Pinos")%>%
  group_by(site,year,investigators)%>%
  summarize(
    time=max(length_search_min,na.rm=T),
    count_ab=n())%>%
  arrange(site,investigators)



d3%>%
  filter(species!="H. rufescens"| species!="H_rufescens")%>%
  group_by(site)%>%
  summarize(
    count_ab=n())%>%
  arrange(site)


# setwd("C:/Users/Jennifer.Selgrath/Documents/research/R_projects/BlackAbalone_2022/")


#2020
d4<-read_excel("data/2020_TimeSearch.xlsx")%>%
  select(site=Location,exp_protected=`Exp/Protected`,species=Species,size_cm=`Size (cm)`  ,investigators=Investigators,length_search_min= `Length of Search (min)`,notes=Notes)%>% 
  mutate(year="2020")%>% 
  filter(species!="H. rufescens")%>%
  glimpse()

unique(d4$species)

d4$length_search_min[d4$length_search_min=="40. minutes"]<-"40"
d4$length_search_min<-as.numeric(as.character(d4$length_search_min))
d4$length_search_min  

# d4$date #all before SIP 


# checking missing - just realized that size list and counts don't match in exce, but maybe they should not?
d4%>%
  filter(species!="H. rufescens"| species!="H_rufescens")%>%
  group_by(site,year,investigators)%>%
  summarize(
    time=max(length_search_min,na.rm=T),
    count_ab=n())%>%
  arrange(site,investigators)

levels(as.factor(d4$length_search_min)) #lots
levels(as.factor(d4$size_cm))

# change character data to integer

# CARMEL BAY: I DON"T KNOW WHICH TRANSECT TO ASSIGN x TO
# Based on sums in spreadsheet I think its from Jasmine and Katrina's survey (count = 41, but count in xlsx = 56 which is about the number missing)
# CONFIRM THIS!!!
d4$investigators[d4$investigators=="x"]<-"Jasmine and Katrina"
                              
d4a<-d4%>%
  filter(length_search_min>0)  

#2021 ----------------------------------
d5<-read_csv("./data/2021_TimeSearch.csv")%>%
  mutate(exp_protected="TBD",year="2021")%>% 
  select(site=Location,exp_protected,species=Species,size_cm=Size_cm, investigators=Investigators,length_search_min= `Length of Search (min)`,notes=Notes,year)%>% 
  filter(length_search_min>0)%>%
  filter(species!="H_rufescens")%>%
  glimpse()

unique(d5$species)

levels(as.factor(d5$length_search_min)) #lots
levels(as.factor(d5$species))
levels(as.factor(d5$size_cm))

d5$size_cm[d5$size_cm=="NM"]<-"NA"
d5$size_cm<-is.numeric(d5$size_cm)

d5%>%
  filter(species!="H. rufescens"| species!="H_rufescens")%>%
  # filter(site=="Sea Palm")%>%
  filter(site=="Pescadero Point")%>%
  # filter(site=="China Rock")%>%
  # filter(site=="Cannery Row")%>%
  # filter(site=="Hopkins")%>%
  # filter(site=="Point Pinos")%>%
  group_by(site,year,investigators)%>%
  summarize(
    time=max(length_search_min,na.rm=T),
    count_ab=n())%>%
  arrange(site,investigators)




#2022
d6<-read_csv("./data/2022_TimeSearch.csv")%>%
  select(site=Location,exp_protected=`Exp/Protected`,species=Species,size_cm=`Size (cm)`,investigators=Investigators,length_search_min= `Length of Search (min)`,notes=Notes)%>% 
  mutate(year="2022")%>% 
  filter(species!="H. rufescens")%>%
  glimpse()

unique(d6$species)

levels(as.factor(d6$length_search_min)) #lots
levels(as.factor(d6$species))
levels(as.factor(d6$site))
levels(as.factor(d6$investigators))
levels(as.factor(d6$size_cm))

d6$investigators[d6$investigators=="Jenny Mijangos, Alex Macias,Guadalupe Rios"]<-"Jenny Mijangos, Alex Macias, Guadalupe Rios"

d6%>%
  filter(species!="H. rufescens"| species!="H_rufescens")%>%
  filter(site=="Carmel Point")%>%
  # filter(site=="Cannery Row")%>%
  # filter(site=="Hopkins")%>%
  # filter(site=="Pt Pinos")%>%
  group_by(site,year,investigators)%>%
  summarize(
    time=max(length_search_min,na.rm=T),
    count_ab=n())%>%
  arrange(site,investigators)

# merge --------------------------- 
names(d1)
names(d2)
names(d3)
names(d4a)
names(d5)
names(d6)

d7<-rbind(d1,d2,d3,d4a,d5,d6)%>%
  glimpse()

levels(as.factor(d7$year))
levels(as.factor(d7$length_search_min))

unique(d7$species)


# OLDER DATA --------------------------------------------------


#2005,2014,2015,2016,2017, mostly HMS (except 2005)
d8<-read_csv("./results/old_data_cleaned1.csv")%>%
  mutate(notes="NA",species="TBD")%>%
  select(site, exp_protected,species,size_cm,investigators, length_search_min,notes,year)%>%
  glimpse()

levels(as.factor(d8$length_search_min)) #40 and 80min
d8$length_search_min[1000:1175]

# check if overlap in 2017
# d7 has hopkins data, but not other data. 
# d1 has hms, pt pinos and carmel bay
d1%>%
  filter(year==2017)%>%
  group_by(site)%>%
  summarize(n=n())

d8%>%
  filter(year==2017)%>%
  group_by(site)%>%
  summarize(n=n())

# look at data
d1%>%
  filter(year==2017,site=="Hopkins")%>% # has all data except species and notes
  arrange(investigators,size_cm)

d8%>%
  filter(year==2017)%>%
  arrange(investigators,size_cm) # has all data except species, notes, and date

# These are the same datasets in 2017


#remove d8 2017 data so not duplicated. d7 in 2017 is only hopkins data
d8b<-d8%>%
  filter(year!=2017)


# merge
names(d7)
names(d8b)

# combine
d10<-rbind(d7,d8b)%>%
  glimpse()

range(d10$year)
levels(as.factor(d10$year))
unique(d10$species)

d10%>%filter(species=="TBD")
# standardize species names
unique(d10$species)
d10$species[d10$species=="H. cracherodii"]<-"H_cracherodii"
d10$species[d10$species=="H.cracherodii"]<-"H_cracherodii"
d10$species[d10$species=="TBD"]<-"H_cracherodii"

d10a<-d10%>%
  filter(species!="H. rufescens"& species!="H_rufescens")


d10a

levels(as.factor(d10a$exp_protected))
d10a$exp_protected[d10a$exp_protected=="proctected"]<-"Protected"
d10a$exp_protected[d10a$exp_protected=="protected"]<-"Protected"

d10a$exp_protected[d10a$site=="Cannery Row"]<-"Protected"
d10a$exp_protected[d10a$site=="Hopkins"]<-"Protected"
d10a$exp_protected[d10a$site=="Pescadero Point"]<-"Exposed"

d10a$exp_protected[d10a$site=="Point Pinos"]<-"Protected"
d10a$exp_protected[d10a$site=="Sea Palm"]<-"Protected"
d10a$exp_protected[d10a$site=="China Rock"]<-"Exposed"


d10a%>%#filter(exp_protected=="TBD")%>%
  filter(site=="China Rock")%>%
  select(site,exp_protected,year)%>%
  unique()

unique(d10a$species)
# save

write_csv(d10a,"./results/time_data_2005_2022.csv") # use this output

