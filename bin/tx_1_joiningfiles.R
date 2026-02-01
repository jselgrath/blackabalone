# Jennifer Selgrath
# Hopkins Marine Station

# goal: merging contemporary black abalone TRANSECT data (and checking out the data)
# ------------------------------------------------------------------------
library(tidyverse); library(readxl); library (lubridate)

# --------------------------------------------------------------------------
remove(list=ls())
setwd("C:/Users/jselg/Dropbox/research_x1/R_projects/mbc/black_abalone")


# 2017
d1<-read_excel("./data/2017_Transects.xlsx",sheet="Transect totals")%>%
  filter(Site!="Site", Species=="H. cracherodii")%>%
  mutate(year="2017",tx_area=2*`Transect length (m)`,Date=ymd(Date),species="H_cracherodii")%>%
  select(site=Site,year,date=Date,species,transect=Transect,tx_length_m=`Transect length (m)`, tx_area,investigators=Investigator,no_indv=`Number of Individuals`)%>%
  mutate(tx_density_m2=round(no_indv/tx_area,4))%>%
  arrange(year,site,transect)%>%
  glimpse()

#2018
d2<-read_excel("./data/2018_Transects.xlsx",sheet="Transect Totals")%>%
  filter(Site!="Site", Species=="H. cracherodii")%>%
  mutate(year="2018",tx_area=2*`Transect Length`,Date=ymd(Date),species="H_cracherodii")%>%
  select(site=Site,year,date=Date,species,transect=`Transect No`,tx_length_m=`Transect Length`, tx_area,investigators=Investigators,no_indv=`Number`)%>%
  mutate(tx_density_m2=round(no_indv/tx_area,4))%>%
  arrange(year,site,transect)%>%
  glimpse()

#2019 ----------------------------------
d3<-read_excel("./data/2019_Transects.xlsx",sheet="Transect Totals")%>%
  filter(Site!="Site", Species=="H. cracherodii")%>%
  mutate(year="2019",tx_area=2*`Transect Length`,Date=ymd(Date),species="H_cracherodii")%>%
  select(site=Site,year,date=Date,species,transect=`Transect No`,tx_length_m=`Transect Length`, tx_area,investigators=Investigators,no_indv=`Number`)%>%
  mutate(tx_density_m2=round(no_indv/tx_area,4))%>%
  arrange(year,site,transect)%>%
  glimpse()

#2020 ----------------------------------
# note I fixed orig data because a few lines with too many numbers in date (202020210)
d4<-read_excel("./data/2020_Transects.xlsx",sheet="Transect Totals")

d4$Date[d4$Date==20209219]<-20200219 #error in date

d4a<-d4%>%
  filter(Site!="Site", Species=="H. cracherodii")%>%
  mutate(year="2020",tx_area=2*`Transect Length`,Date=ymd(Date),species="H_cracherodii")%>%
  select(site=Site,year,date=Date,species,transect=`Transect No`,tx_length_m=`Transect Length`, tx_area,investigators=Investigators,no_indv=`Number`)%>%
  mutate(tx_density_m2=round(no_indv/tx_area,4))%>%
  arrange(year,site,transect)%>%
  glimpse()

d4a$date #all before SIP 

#2021 ----------------------------------
d5<-read_excel("./data/2021_Transects.xlsx",sheet="Transect Totals")%>%
  mutate(species="H. cracherodii",year=2021,date=ymd(Date),tx_area=2*`Transect Length`)%>%
  select(site=Site,year,date,species,transect=`Transect No`,tx_length_m=`Transect Length`,tx_area,investigators=Investigators,no_indv=H_cracherodii)%>%
  mutate(tx_density_m2=round(no_indv/tx_area,4))%>%
  arrange(year,site,transect)%>%
  glimpse()

levels(as.factor(d5$site))
levels(as.factor(d5$investigators))




#2022 ----------------------------------
d6<-read_excel("./data/2022_Transects.xlsx",sheet="Transect Totals")%>%
  mutate(species="H. cracherodii",year=2022,date=ymd(Date),tx_area=2*`Transect Length`)%>%
  select(site=Site,year,date,species,transect=`Transect No`,tx_length_m=`Transect Length`,tx_area,investigators=Investigators,no_indv=H_cracherodii)%>%
  mutate(tx_density_m2=round(no_indv/tx_area,4))%>%
  arrange(year,site,transect)%>%
  glimpse()



# check & merge
names(d1)
names(d2)
names(d3)
names(d4a)
names(d5)
names(d6)

d7<-rbind(d1,d2,d3,d4a,d5,d6)%>%
  select(site, year,species,transect,tx_area, tx_count=no_indv,tx_density_m2)%>%
  glimpse()

# older data
# setwd("C:/Users/Jennifer.Selgrath/Documents/research/R_projects/BlackAbalone_2022/")

#2002,2010,2011-2016, mostly HMS (except 2002)
d8<-read_csv("./results/tx_old_data_cleaned2.csv")%>%
  # mutate(tx_density_m2=density_m2)%>%
  select(-tx_size_cm_u,-tx_size_sd,-tx_size_sem)%>%
  glimpse()

d8%>%
  filter(is.na(species))

# check if overlapping years(none)  
d7%>%
  group_by(year,site)%>%
  summarize(n=n())

d8%>%
  group_by(year,site)%>%
  summarize(n=n())



# merge
names(d7)
names(d8)

# combine
d10<-rbind(d7,d8)%>%
  glimpse()

range(d10$year)
levels(as.factor(d10$year))
levels(as.factor(d10$species))

# standardize species names
d10$species[d10$species=="H. cracherodii"]<-"H_cracherodii"
d10$species[d10$species=="H.cracherodii"]<-"H_cracherodii"
levels(as.factor(d10$species))

unique(d10$species)

# save
# setwd("C:/Users/Jennifer.Selgrath/Documents/research/R_projects/BlackAbalone_2022/")

write_csv(d10,"./results/tx_data_2002_2022.csv") # use this output

