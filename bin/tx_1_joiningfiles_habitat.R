# Jennifer Selgrath
# Hopkins Marine Station
# Historical Black Abalone

# goal: merging contemporary black abalone TRANSECT data summarizing habitat data (and checking out the data)
# ------------------------------------------------------------------------
library(tidyverse); library(readxl); library (lubridate)

# --------------------------------------------------------------------------
remove(list=ls())
setwd("C:/Users/jselg/Dropbox/research_x1/R_projects/mbc/black_abalone")

# l1<-list.files(pattern='Transects')
# l1

# setwd("C:/Users/Jennifer.Selgrath/Documents/research/R_projects/BlackAbalone_2022")

# 2017
# cleaning variable names etc
d1<-read_excel("./data/2017_Transects.xlsx",sheet="Raw size data")%>%
  filter(Site!="Site", Species=="H. cracherodii")%>%
  mutate(year=2017,Date=ymd(Date),species="H_cracherodii",tx_length_m=30,tx_area=60,exp_protected=`Exp/Protected`,
         c_depth_cm=as.numeric(`Crack Depth (cm)`), 
         c_width_cm=as.numeric(`Crack Width (cm)`), 
         position_m=as.numeric(`Position (m)`), 
         ab_size_cm=as.numeric(`Size (cm)`))%>%
  select(site=Site, year,date=Date,species,status=Status,transect=Transect,tx_length_m,tx_area,
         habitat=Habitat,
         c_depth_cm,   c_width_cm,     position_m,      ab_size_cm,
         investigators=Investigator,exp_protected)%>% #
  mutate(crev_area_cm2=c_depth_cm*c_width_cm)%>%
  arrange(year,site,transect)%>%
  glimpse()

# summarize
d1b<-d1%>%
  group_by(site,year,species,transect,tx_area,exp_protected)%>%
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

# pull out expected protection info if need it later (inhibits rbind below)
d1p<-d1b%>%
  select(site,year,transect,exp_protected)

# get tx with 0 observations
d1c<-read_excel("./data/2017_Transects.xlsx",sheet="Transect totals")%>%
  # glimpse()
  select(Site:Investigator)%>% # ditch extra columns
  filter(`Number of Individuals`==0,Species=="H. cracherodii")%>%
  mutate(species="H_cracherodii", tx_length=`Transect length (m)`,tx_area=`Transect length (m)`*2,date=ymd(Date),year=year(date))%>%
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

# join tx with and without abalone, after removing expected protection vaiable
d1d<-d1b%>%
  select(-exp_protected)%>%
  rbind(d1c)%>%
  arrange(site,year,transect)%>%
  glimpse()
d1d




#2018 --------------------------------------------------------------------------------
d2<-read_excel("./data/2018_Transects.xlsx",sheet="Transect Sizes")%>%
  select(Site:Investigator)%>%              
  filter(Site!="Site", Species=="H. cracherodii")%>%
  glimpse()

# cleaning variable names etc
d2a<-d2%>%
  mutate(year=year(Date),date=ymd(Date),species="H_cracherodii",tx_length_m=30,tx_area=60,exp_protected=`Exp/Protected`,
         c_depth_cm=as.numeric(`Crack Depth (cm)`), 
         c_width_cm=as.numeric(`Crack Width (cm)`), 
         position_m=as.numeric(`Position (m)`), 
         ab_size_cm=as.numeric(`Size (cm)`))%>%
  select(site=Site, year,date=Date,species,status=Status,transect=Transect,tx_length_m,tx_area,
         habitat=Habitat,
         c_depth_cm,   c_width_cm,     position_m,      ab_size_cm,
         investigators=Investigator,exp_protected)%>% #
  mutate(crev_area_cm2=(c_depth_cm*c_width_cm))%>%
  arrange(year,site,transect)%>%
  glimpse()

# summarize
d2b<-d2a%>%
  group_by(site,year,species,transect,tx_area)%>%
  reframe(
    tx_count=n(),
    tx_density_m2=round(tx_count/tx_area,4),
    habitat_all=paste(unique(habitat), collapse=","),
    tx_size_cm_u=mean(ab_size_cm,na.rm=T),
    tx_size_sd=sd(ab_size_cm,na.rm=T),
    tx_size_sem=tx_size_sd/sqrt(tx_count),
    tx_crev_depth_cm_u=mean(c_depth_cm,na.rm=T),
    tx_crev_width_cm_u=mean(c_width_cm,na.rm=T),
    tx_crev_area_cm2_u=mean(crev_area_cm2,na.rm=T)
  )%>%
  unique()%>%
  arrange(site,year,transect)%>%
  glimpse()




# grab tx with zeros
d2c<-read_excel("./data/2018_Transects.xlsx",sheet="Transect Totals")%>%
  select(Site:Investigators)%>% # ditch extra columns
  filter(Number==0,Species=="H. cracherodii")%>%
  mutate(species=Species, tx_length=`Transect Length`,tx_area=tx_length*2,year=year(Date))%>%
  select(site=Site, year, species,transect=`Transect No`,tx_area,tx_count=Number)%>%
  arrange(year,site,transect)%>%
  mutate(tx_density_m2=round((tx_count/tx_area),4),habitat_all=NA,
         # add empty columns to match above. Does data exist for these transects?
         tx_size_cm_u=NA,
         tx_size_sd=NA,
         tx_size_sem=NA,
         tx_crev_depth_cm_u=NA,
         tx_crev_width_cm_u=NA,
         tx_crev_area_cm2_u=NA)%>%
  glimpse()

names(d2b)
names(d2c)

glimpse(d1b)
glimpse(d1c)

d2d<-rbind(d2b,d2c)%>%
  arrange(site,year,transect)%>%
  glimpse()
d2d



#2019 ----------------------------------
d3<-read_excel("./data/2019_Transects.xlsx",sheet="Transect Sizes")%>%
  select(Site:Investigator)%>%              
  filter(Species=="H. cracherodii")%>%
  glimpse()

# cleaning variable names etc
d3a<-d3%>%
  mutate(year=2019,date=ymd(Date),species="H_cracherodii",tx_length_m=30,tx_area=60,
         c_depth_cm=as.numeric(`Crevice Depth (cm)`), 
         c_width_cm=as.numeric(`Crevice Width (cm)`), 
         position_m=as.numeric(`Position (m)`), 
         ab_size_cm=as.numeric(`Size (cm)`),
         exp_protected="TBD")%>%
  select(site=Site, year,date=Date,species,status=Status,transect=Transect,tx_length_m,tx_area,
         habitat=Habitat,
         c_depth_cm,   c_width_cm,     position_m,      ab_size_cm,
         investigators=Investigator,exp_protected)%>% #
  mutate(crev_area_cm2=(c_depth_cm*c_width_cm))%>%
  arrange(year,site,transect)%>%
  glimpse()

# summarize
d3b<-d3a%>%
  group_by(site,year,species,transect,tx_area)%>%
  reframe(
    tx_count=n(),
    tx_density_m2=round(tx_count/tx_area,4),
    habitat_all=paste(unique(habitat), collapse=","),
    tx_size_cm_u=mean(ab_size_cm,na.rm=T),
    tx_size_sd=sd(ab_size_cm,na.rm=T),
    tx_size_sem=tx_size_sd/sqrt(tx_count),
    tx_crev_depth_cm_u=mean(c_depth_cm,na.rm=T),
    tx_crev_width_cm_u=mean(c_width_cm,na.rm=T),
    tx_crev_area_cm2_u=mean(crev_area_cm2,na.rm=T)
  )%>%
  unique()%>%
  arrange(site,year,transect)%>%
  glimpse()


# grab tx with zeros
d3c<-read_excel("./data/2019_Transects.xlsx",sheet="Transect Totals")%>%
  select(Site:Investigators)%>% # ditch extra columns
  filter(Number==0,Species=="H. cracherodii")%>%
  mutate(species=Species, tx_length=`Transect Length`,tx_area=tx_length*2,year=2019)%>%
  select(site=Site, year, species,transect=`Transect No`,tx_area,tx_count=Number)%>%
  arrange(year,site,transect)%>%
  mutate(tx_density_m2=round((tx_count/tx_area),4),habitat_all=NA,
         # add empty columns to match above. Does data exist for these transects?
         tx_size_cm_u=NA,
         tx_size_sd=NA,
         tx_size_sem=NA,
         tx_crev_depth_cm_u=NA,
         tx_crev_width_cm_u=NA,
         tx_crev_area_cm2_u=NA)%>%
  glimpse()

names(d3b)
names(d3c)


d3d<-rbind(d3b,d3c)%>%
  arrange(site,year,transect)%>%
  glimpse()


#2020 ----------------------------------
# note I fixed orig data because a few lines with too many numbers in date (202020210)

d4<-read_excel("./data/2020_Transects.xlsx",sheet="Transect Sizes")%>%
  select(Site:Investigator)%>%              
  filter(Species=="H. cracherodii")%>%
  glimpse()

d4$Date[d4$Date==20209219]<-20200219 #error in date

# cleaning variable names etc
d4a<-d4%>%
  mutate(year=2020,date=ymd(Date),species="H_cracherodii",tx_length_m=30,tx_area=60,
         c_depth_cm=as.numeric(`Crevice Depth (cm)`), 
         c_width_cm=as.numeric(`Crevice Width (cm)`), 
         position_m=as.numeric(`Position (m)`), 
         ab_size_cm=as.numeric(`Size (cm)`),
         exp_protected="TBD")%>%
  select(site=Site, year,date=Date,species,status=Status,transect=Transect,tx_length_m,tx_area,
         habitat=Habitat,
         c_depth_cm,   c_width_cm,     position_m,      ab_size_cm,
         investigators=Investigator,exp_protected)%>% #
  mutate(crev_area_cm2=(c_depth_cm*c_width_cm))%>%
  arrange(year,site,transect)%>%
  glimpse()

# summarize
d4b<-d4a%>%
  group_by(site,year,species,transect,tx_area)%>%
  reframe(
    tx_count=n(),
    tx_density_m2=round(tx_count/tx_area,4),
    habitat_all=paste(unique(habitat), collapse=","),
    tx_size_cm_u=mean(ab_size_cm,na.rm=T),
    tx_size_sd=sd(ab_size_cm,na.rm=T),
    tx_size_sem=tx_size_sd/sqrt(tx_count),
    tx_crev_depth_cm_u=mean(c_depth_cm,na.rm=T),
    tx_crev_width_cm_u=mean(c_width_cm,na.rm=T),
    tx_crev_area_cm2_u=mean(crev_area_cm2,na.rm=T)
  )%>%
  unique()%>%
  arrange(site,year,transect)%>%
  glimpse()


# grab tx with zeros
d4c<-read_excel("./data/2020_Transects.xlsx",sheet="Transect Totals")%>%
  select(Site:Investigators)%>% # ditch extra columns
  filter(Number==0,Species=="H. cracherodii")%>%
  mutate(species=Species, tx_length=`Transect Length`,tx_area=tx_length*2,year=2020)%>%
  select(site=Site, year, species,transect=`Transect No`,tx_area,tx_count=Number)%>%
  arrange(year,site,transect)%>%
  mutate(tx_density_m2=round((tx_count/tx_area),4),habitat_all=NA,
         # add empty columns to match above. Does data exist for these transects?
         tx_size_cm_u=NA,
         tx_size_sd=NA,
         tx_size_sem=NA,
         tx_crev_depth_cm_u=NA,
         tx_crev_width_cm_u=NA,
         tx_crev_area_cm2_u=NA)%>%
  glimpse()

names(d4b)
names(d4c)


d4d<-rbind(d4b,d4c)%>%
  arrange(site,year,transect)%>%
  glimpse()



# d4a$date #all before SIP 




#2021 ---------------------------------------------------
d5<-read_excel("./data/2021_Transects.xlsx",sheet="Transect Abalone Sizes")%>%
  select(Site:Investigator)%>%              
  filter(Species=="H. cracherodii"|Species=="H_cracherodii")%>%
  glimpse()

# cleaning variable names etc
d5a<-d5%>%
  mutate(year=2021,species="H_cracherodii",tx_length_m=20,tx_area=40,
         c_depth_cm=as.numeric(`Crevice Depth_cm`), 
         c_width_cm=as.numeric(`Crevice Width_cm`), 
         position_m=as.numeric(Position_m), 
         ab_size_cm=as.numeric(Size_cm),
         exp_protected="TBD")%>%
  select(site=Site, year,date=Date,species,status=Status,transect=Transect,tx_length_m,tx_area,
         habitat=Habitat,
         c_depth_cm,   c_width_cm,     position_m,      ab_size_cm,
         investigators=Investigator,exp_protected)%>% #
  mutate(crev_area_cm2=(c_depth_cm*c_width_cm))%>%
  arrange(year,site,transect)%>%
  glimpse()

# summarize
d5b<-d5a%>%
  group_by(site,year,species,transect,tx_area)%>%
  reframe(
    tx_count=n(),
    tx_density_m2=round(tx_count/tx_area,4),
    habitat_all=paste(unique(habitat), collapse=","),
    tx_size_cm_u=mean(ab_size_cm,na.rm=T),
    tx_size_sd=sd(ab_size_cm,na.rm=T),
    tx_size_sem=tx_size_sd/sqrt(tx_count),
    tx_crev_depth_cm_u=mean(c_depth_cm,na.rm=T),
    tx_crev_width_cm_u=mean(c_width_cm,na.rm=T),
    tx_crev_area_cm2_u=mean(crev_area_cm2,na.rm=T)
  )%>%
  unique()%>%
  arrange(site,year,transect)%>%
  glimpse()


# grab tx with zeros
d5c<-read_excel("./data/2021_Transects.xlsx",sheet="Transect Totals")%>%
  select(Site:Investigators)%>% # ditch extra columns
  filter(H_cracherodii==0)%>%
  mutate(species="H_cracherodii", tx_length=`Transect Length`,tx_area=tx_length*2,year=2021)%>%
  select(site=Site, year, species,transect=`Transect No`,tx_area,tx_count=H_cracherodii)%>%
  arrange(year,site,transect)%>%
  mutate(tx_density_m2=round((tx_count/tx_area),4),habitat_all=NA,
         # add empty columns to match above. Does data exist for these transects?
         tx_size_cm_u=NA,
         tx_size_sd=NA,
         tx_size_sem=NA,
         tx_crev_depth_cm_u=NA,
         tx_crev_width_cm_u=NA,
         tx_crev_area_cm2_u=NA)%>%
  glimpse()

names(d5b)
names(d5c)


d5d<-rbind(d5b,d5c)%>%
  arrange(site,year,transect)%>%
  glimpse()





#2022 ----------------------------------
d6<-read_excel("./data/2022_Transects.xlsx",sheet="Transect Abalone Sizes")%>%
  select(Site:Investigator)%>%              
  filter(Species=="H_cracherodii")%>%
  glimpse()

# cleaning variable names etc
d6a<-d6%>%
  mutate(year=2022,date=ymd(Date),species="H_cracherodii",tx_length_m=20,tx_area=40,
         c_depth_cm=as.numeric(`Crevice Depth_cm`), 
         c_width_cm=as.numeric(`Crevice Width_cm`), 
         position_m=as.numeric(Position_m), 
         ab_size_cm=as.numeric(Size_cm),
         exp_protected="TBD")%>%
  select(site=Site, year,date=Date,species,status=Status,transect=Transect,tx_length_m,tx_area,
         habitat=Habitat,
         c_depth_cm,   c_width_cm,     position_m,      ab_size_cm,
         investigators=Investigator,exp_protected)%>% #
  mutate(crev_area_cm2=(c_depth_cm*c_width_cm))%>%
  arrange(year,site,transect)%>%
  glimpse()

# summarize
d6b<-d6a%>%
  group_by(site,year,species,transect,tx_area)%>%
  reframe(
    tx_count=n(),
    tx_density_m2=round(tx_count/tx_area,4),
    habitat_all=paste(unique(habitat), collapse=","),
    tx_size_cm_u=mean(ab_size_cm,na.rm=T),
    tx_size_sd=sd(ab_size_cm,na.rm=T),
    tx_size_sem=tx_size_sd/sqrt(tx_count),
    tx_crev_depth_cm_u=mean(c_depth_cm,na.rm=T),
    tx_crev_width_cm_u=mean(c_width_cm,na.rm=T),
    tx_crev_area_cm2_u=mean(crev_area_cm2,na.rm=T)
  )%>%
  unique()%>%
  arrange(site,year,transect)%>%
  glimpse()


# grab tx with zeros
d6c<-read_excel("./data/2022_Transects.xlsx",sheet="Transect Totals")%>%
  select(Site:Investigators)%>% # ditch extra columns
  filter(H_cracherodii==0)%>%
  mutate(species="H_cracherodii", tx_length=`Transect Length`,tx_area=tx_length*2,year=2022)%>%
  select(site=Site, year, species,transect=`Transect No`,tx_area,tx_count=H_cracherodii)%>%
  arrange(year,site,transect)%>%
  mutate(tx_density_m2=round((tx_count/tx_area),4),habitat_all=NA,
         # add empty columns to match above. Does data exist for these transects?
         tx_size_cm_u=NA,
         tx_size_sd=NA,
         tx_size_sem=NA,
         tx_crev_depth_cm_u=NA,
         tx_crev_width_cm_u=NA,
         tx_crev_area_cm2_u=NA)%>%
  glimpse()

names(d6b)
names(d6c)


d6d<-rbind(d6b,d6c)%>%
  arrange(site,year,transect)%>%
  glimpse()

# check & merge
names(d1d)
names(d2d)
names(d3d)
names(d4d)
names(d5d)
names(d6d)

d7<-rbind(d1d,d2d,d3d,d4d,d5d,d6d)%>%
  ungroup()%>%
  select(site,year,species,transect,tx_area,tx_count,tx_density_m2,tx_size_cm_u,tx_size_sd,tx_size_sem,habitat_all,tx_crev_depth_cm_u,tx_crev_width_cm_u,tx_crev_area_cm2_u)%>% # reorder to match old data
  glimpse()

# older data
# setwd("C:/Users/Jennifer.Selgrath/Documents/research/R_projects/BlackAbalone_2022/")

#2002,2010,2011-2016, mostly HMS (except 2002)
d8<-read_csv("./results/tx_old_data_cleaned_habitat.csv")%>%
  glimpse()

d8%>%
  filter(is.na(species))

# check if overlapping years(none)  
d7%>%
  group_by(year,site)%>%
  reframe(n=n())

d8%>%
  group_by(year,site)%>%
  reframe(n=n())



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

unique(as.factor(d10$species))


d10%>%
filter(is.na(species))

# save
write_csv(d10,"./results/tx_data_2002_2022_habitat.csv") # use this output

