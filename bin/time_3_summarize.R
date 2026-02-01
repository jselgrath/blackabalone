# Jennifer Selgrath
# Hopkins Marine Station
# July 24, 2022

# goal: merging contemporary black abalone data (and checking out the data)
# ------------------------------------------------------------------------
library(tidyverse); 

# --------------------------------------------------------------------------
remove(list=ls())
setwd("C:/Users/jselg/Dropbox/research_x1/R_projects/mbc/black_abalone")


d1<-read_csv("./results/time_data_2005_2022_location13.csv")%>%
  # mutate(size_cm=as.numeric(size_cm))%>%
  glimpse()

unique(d1$species)

levels(as.factor(d1$size_cm))
levels(as.factor(d1$length_search_min))

# number per year
d99<-d1%>%
  group_by(year,site,investigators)%>%
  summarize(
    time_count_n=n())%>%
  glimpse()
    
    
#by site group by search, estimate mean size per search (etc)
d2<-d1%>%
  group_by(year,site,location,location3,investigators,species,exp_protected)%>%
  summarize(
    time_count_n=n(),
    time_search_min=max(length_search_min),
    time_density=time_count_n/time_search_min,  # already checked these are the same for all pairs
    ab_size_u= round(mean(size_cm, na.rm=T),4), # size - mean
    ab_size_sd=round(sd(size_cm, na.rm=T),4),  # size - standard deviation
    ab_size_sem=round(ab_size_sd/sqrt(time_count_n),4))%>% # size - std error of the mean 
  glimpse()


# by site
d3<-d2%>%
  group_by(year,site,location,location3, species,exp_protected)%>%
  summarize(
    time_n=n(),
    time_density_u=round(mean(time_density),4), # mean number 
    time_density_sd=round(sd(time_density),4), 
    time_density_sem=round(time_density_sd/sqrt(time_n),4))%>% # size - std error of the mean
  mutate(source="Contemporary Data")%>%
  unique()%>%
  glimpse()

# by location
d4<-d2%>%
  group_by(year,location,exp_protected)%>%
  summarize(
    time_n=n(),
    time_density_u=round(mean(time_density),4), # mean number 
    time_density_sd=round(sd(time_density),4), 
    time_density_sem=round(time_density_sd/sqrt(time_n),4))%>% # size - std error of the mean
  mutate(source="Contemporary Data")%>%
  unique()%>%
  glimpse()

# by location3
d5<-d2%>%
  group_by(year,location,location3,exp_protected)%>%
  summarize(
    time_n=n(),
    time_density_u=round(mean(time_density),4), # mean number 
    time_density_sd=round(sd(time_density),4), 
    time_density_sem=round(time_density_sd/sqrt(time_n),4))%>% # size - std error of the mean
  mutate(source="Contemporary Data")%>%
  unique()%>%
  glimpse()


# check
ggplot(d3,aes(year,time_density_u))+geom_point()
ggplot(d4,aes(year,time_density_u))+geom_point()
ggplot(d5,aes(year,time_density_u))+geom_point()

write_csv(d2,"./results/time_data_2005_2022_sum_by_search_sz.csv")
write_csv(d3,"./results/time_data_2005_2022_sum_by_site.csv")
write_csv(d4,"./results/time_data_2005_2022_sum_by_location.csv")
write_csv(d5,"./results/time_data_2005_2022_sum_by_location3.csv")
