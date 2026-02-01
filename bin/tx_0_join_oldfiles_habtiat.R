# Jennifer Selgrath
# Hopkins Marine Station
# Historical Black Abalone

# goal: SUMMARIZE DATA WITH HABTIAT VARIABLES

# ------------------------------------------------------------------------
library(tidyverse); library(readxl); library (lubridate)
# --------------------------------------------------------------------------
remove(list=ls())
setwd("C:/Users/jselg/Dropbox/research_x1/R_projects/mbc/black_abalone")


# Old_TimeSearch.csv
# This data is from 2002. Hopkins 2002 appears in both datasets
d1<-read_excel("./data/Old_Transect.xlsx",sheet="Raw Transect")%>%
  filter(Species=="HC")%>%  #HCS = shell
  filter(Site!="Hopkins")%>%
  glimpse()

d1$`Size (cm)`<-as.numeric(d1$`Size (cm)`)

# cleaning variable names etc
d1a<-d1%>%
  mutate(tx_length=30, tx_area=60,species="H_cracherodii")%>%
  mutate(
    year=year(Date))%>%
  select(site=Site, year,species,status=Status,transect=Transect,tx_length,tx_area,
         habitat=Habitat,c_depth_cm=`Crack Depth (cm)`, c_width_cm=`Crack Width (cm)`, 
         position_m= `Position (m)`, ab_size_cm= `Size (cm)` )%>% #
  mutate(tx_area=tx_length*2,
         crev_area_cm2=c_depth_cm*c_width_cm)%>%
  arrange(year,site)%>%
  glimpse()

unique(d1a$habitat)


# summarize
d1b<-d1a%>%
  group_by(site,year,species,transect,tx_area)%>%
  reframe(
    tx_count=n(),
    tx_density_m2=round(tx_count/tx_area,4),
    tx_size_cm_u=mean(ab_size_cm,na.rm=T),
    tx_size_sd=sd(ab_size_cm,na.rm=T),
    tx_size_sem=tx_size_sd/sqrt(tx_count),
    habitat_all=paste(unique(habitat), collapse=","),
    tx_crev_depth_cm_u=mean(c_depth_cm,na.rm=T),
    tx_crev_width_cm_u=mean(c_width_cm,na.rm=T),
    tx_crev_area_cm2_u=mean(crev_area_cm2,na.rm=T)
  )%>%
  unique()%>%
  arrange(site,year,transect)%>%
  glimpse()
names(d1b)


# grab tx with zeros --------------------
d1c<-read_excel("./data/Old_Transect.xlsx",sheet="TransectTotals")%>%
  # glimpse()
  select(Site:Investigator)%>% # ditch extra columns
  filter(`Number of Individuals`==0,Species=="H. cracherodii")%>%
  mutate(species="H_cracherodii", tx_length=`Transect length (m)`,tx_area=`Transect length (m)`*2,year=year(Date))%>%
  select(site=Site, year, species,transect=Transect,tx_area,tx_count=`Number of Individuals`)%>%
  arrange(year,site,transect)%>%
  mutate(tx_density_m2=round((tx_count/tx_area),4),
         # add empty columns to match above. Does data exist for these transects?
         tx_size_cm_u=NA,
         tx_size_sd=NA,
         tx_size_sem=NA,
         habitat_all=NA,
         tx_crev_depth_cm_u=NA,
         tx_crev_width_cm_u=NA,
         tx_crev_area_cm2_u=NA)%>%
  glimpse()

names(d1b)
names(d1c)

glimpse(d1b)
glimpse(d1c)

d1d<-rbind(d1b,d1c)%>%
  arrange(site,year,transect)%>%
  glimpse()
d1d





# OldHopkinsData_Transects --------------------------------------------------------
# data is only from Hopkins - years: 2002 2010 2011 2012 2013 2014 2015 2016
d2<-read_excel("./data/OldHopkinsData.xlsx",sheet="Raw_Transects")%>%
  filter(Year!=2016 | Transect!=1)%>% #remove NA from transect with no Abalone
  glimpse()

d2$`Crack Depth (cm)`<-as.numeric(d2$`Crack Depth (cm)`)
d2$`Crack Width (cm)`<-as.numeric(d2$`Crack Width (cm)`)
d2$`Position (m)`<-as.numeric(d2$`Position (m)`)
d2$`Size (cm)`<-as.numeric(d2$`Size (cm)`)

glimpse(d2)
unique(d2$Species)
d2%>%filter(is.na(Species))
d2%>%arrange(Species)%>%tail()



# cleaning variable names etc
d2a<-d2%>%
  select(site=Site, year=Year, species=Species,
         habitat=Habitat,c_depth_cm=`Crack Depth (cm)`, c_width_cm=`Crack Width (cm)`, position_m= `Position (m)`, ab_size_cm= `Size (cm)` ,
         transect=Transect,tx_length=`Transect Length`,investigators=Investigator)%>%#no_indv=`Number of Individuals`
  mutate(tx_area=tx_length*2,
         crev_area_cm2=c_depth_cm*c_width_cm)%>%
  arrange(year,site)%>%
  # mutate(density_m2=round((no_indv/tx_area),4))%>%
  glimpse()

#summarize by search - missing zeros
d2b<-d2a%>%
  group_by(site,year,species,transect,tx_area)%>%
  reframe(
    tx_count=n(),
    tx_density_m2=tx_count/tx_area,
    tx_size_cm_u=mean(ab_size_cm,na.rm=T),
    tx_size_sd=sd(ab_size_cm,na.rm=T),
    tx_size_sem=tx_size_sd/sqrt(tx_count),
    habitat_all=paste(unique(habitat), collapse=","),
    tx_crev_depth_cm_u=mean(c_depth_cm,na.rm=T),
    tx_crev_width_cm_u=mean(c_width_cm,na.rm=T),
    tx_crev_area_cm2_u=mean(crev_area_cm2,na.rm=T)
  )%>%
  unique()%>%
  mutate(species="H_cracherodii")%>%
  arrange(site,year,transect)%>%
  glimpse()

# grab tx with zeros
d2c<-read_excel("./data/OldHopkinsData.xlsx",sheet="TrasectTotals")%>%
  select(Site:Investigator)%>% # ditch extra columns
  drop_na(Date)%>% # ditch blank rows at end
  mutate(species="H_cracherodii")%>%
  select(site=Site, year=Date, species,transect=Transect,tx_area="Transect area (sq meter)",tx_count=`Number of Individuals`)%>%
  arrange(year,site,transect)%>%
  mutate(tx_density_m2=round((tx_count/tx_area),4),
         # add empty columns to match above. Does data exist for these transects?
         tx_size_cm_u=NA,
         tx_size_sd=NA,
         tx_size_sem=NA,
         habitat_all=NA,
         tx_crev_depth_cm_u=NA,
         tx_crev_width_cm_u=NA,
         tx_crev_area_cm2_u=NA)%>%
  filter(tx_count==0)%>% #&year!=2002
  glimpse()

names(d2b)
names(d2c)

d2d<-rbind(d2b,d2c)%>%
  glimpse()


d3<-rbind(d1d,d2d)%>%
  arrange(site,year,transect)%>%
  glimpse()
d3

unique(d3$species)
d3$species<-"H_cracherodii"

# save
write_csv(d3,"./results/tx_old_data_cleaned_habitat.csv")

