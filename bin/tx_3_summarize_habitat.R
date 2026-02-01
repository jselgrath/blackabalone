# Jennifer Selgrath
# Hopkins Marine Station
# Historical Black Abalone

# goal: merging contemporary black abalone data (and checking out the data)
# ------------------------------------------------------------------------
library(tidyverse); 

# --------------------------------------------------------------------------
remove(list=ls())
setwd("C:/Users/jselg/Dropbox/research_x1/R_projects/mbc/black_abalone")

d1<-read_csv("./results/tx_data_2002_2022_location13_habitat.csv")%>%
  glimpse()

unique(d1$species)
# d1%>%filter(site=="Malpaso") # site only surveyed one time. 

# by site
d2<-d1%>%
  group_by(year,site,location, location3,species)%>%
  summarize(
    tx_n=n(), # total number of transects
    tx_density_u= round(mean(tx_density_m2, na.rm=T),4), # density - mean
    tx_density_sd= round(sd(tx_density_m2, na.rm=T),4),  # density - standard deviation
    tx_density_sem= round(tx_density_sd/sqrt(tx_n),4),
    tx_crev_depth_cm_u=round(mean(tx_crev_depth_cm_u, na.rm=T),4),
    tx_crev_width_cm_u=round(mean(tx_crev_width_cm_u, na.rm=T),4),
    tx_crev_area_cm_u=round(mean(tx_crev_area_cm2_u, na.rm=T),4),
    habitat_all2=paste(unique(habitat_all), collapse=",") # this variable is a mess - to fix later!
    )%>% # density - std error of the mean
  mutate(source="Contemporary Data")%>%
  unique()%>%
  arrange(site,year)%>%
  glimpse()

d2

# by location
d3<-d1%>%
  group_by(year,location,location3,species)%>%
  summarize(
    tx_n=n(), # total number of transects
    tx_density_u= round( mean(tx_density_m2, na.rm=T),4), # density - mean
    tx_density_sd= round(sd(tx_density_m2, na.rm=T),4),  # density - standard deviation
    tx_density_sem= round(tx_density_sd/sqrt(tx_n),4), # density - std error of the mean
  tx_crev_depth_cm_u=round(mean(tx_crev_depth_cm_u, na.rm=T),4),
tx_crev_width_cm_u=round(mean(tx_crev_width_cm_u, na.rm=T),4),
tx_crev_area_cm_u=round(mean(tx_crev_area_cm2_u, na.rm=T),4),
habitat_all2=paste(unique(habitat_all), collapse=","))%>% # this variable is a mess - to fix later!
  mutate(source="Contemporary Data")%>%
  unique()%>%
  glimpse()

# by location3
d4<-d1%>%
  group_by(year,location3,species)%>%
  summarize(
    tx_n=n(), # total number of transects
    tx_density_u= round( mean(tx_density_m2, na.rm=T),4), # density - mean
    tx_density_sd= round(sd(tx_density_m2, na.rm=T),4),  # density - standard deviation
    tx_density_sem= round(tx_density_sd/sqrt(tx_n),4), # density - std error of the mean
  tx_crev_depth_cm_u=round(mean(tx_crev_depth_cm_u, na.rm=T),4),
tx_crev_width_cm_u=round(mean(tx_crev_width_cm_u, na.rm=T),4),
tx_crev_area_cm_u=round(mean(tx_crev_area_cm2_u, na.rm=T),4),
habitat_all2=paste(unique(habitat_all), collapse=","))%>% # this variable is a mess - to fix later!
  mutate(source="Contemporary Data")%>%
  unique()%>%
  glimpse()


# check
ggplot(d2,aes(year,tx_density_u,color=site))+geom_point()
ggplot(d3,aes(year,tx_density_u,color=location))+geom_point()
ggplot(d4,aes(year,tx_density_u,color=location3))+geom_point()

#save
write_csv(d2,"./results/tx_data_2002_2022_summarized_site_habitat.csv")
write_csv(d3,"./results/tx_data_2002_2022_summarized_location_habitat.csv")
write_csv(d4,"./results/tx_data_2002_2022_summarized_location3_habitat.csv")
