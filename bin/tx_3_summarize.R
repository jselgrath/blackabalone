# Jennifer Selgrath
# Hopkins Marine Station

# goal: merging contemporary black abalone data (and checking out the data)
# ------------------------------------------------------------------------
library(tidyverse); 

# --------------------------------------------------------------------------
remove(list=ls())
setwd("C:/Users/jselg/Dropbox/research_x1/R_projects/mbc/black_abalone")

d1<-read_csv("./results/tx_data_2002_2022_location13.csv")%>%
  glimpse()

unique(d1$species)

d1%>%filter(site=="Malpaso") # site only surveyed one time. 

# by site
d2<-d1%>%
  group_by(year,site,location, location3,species)%>%
  summarize(
    tx_n=n(), # total number of transects
    tx_density_u= round(mean(tx_density_m2, na.rm=T),4), # density - mean
    tx_density_sd= round(sd(tx_density_m2, na.rm=T),4),  # density - standard deviation
    tx_density_sem= round(tx_density_sd/sqrt(tx_n),4))%>% # density - std error of the mean
  mutate(source="Contemporary Data")%>%
  unique()%>%
  glimpse()

# by location
d3<-d1%>%
  group_by(year,location,location3,species)%>%
  summarize(
    tx_n=n(), # total number of transects
    tx_density_u= round( mean(tx_density_m2, na.rm=T),4), # density - mean
    tx_density_sd= round(sd(tx_density_m2, na.rm=T),4),  # density - standard deviation
    tx_density_sem= round(tx_density_sd/sqrt(tx_n),4))%>% # density - std error of the mean
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
    tx_density_sem= round(tx_density_sd/sqrt(tx_n),4))%>% # density - std error of the mean
  mutate(source="Contemporary Data")%>%
  unique()%>%
  glimpse()


# check
source("./bin/deets.R")

ggplot(d2,aes(year,tx_density_u,color=site))+geom_point(shape = 19, size = 4, alpha = 0.7)+
  geom_segment(aes(y = 0.2, yend = 0.2, x = -Inf, xend = Inf),linetype = "longdash", lineend = "butt",linejoin="mitre" ,alpha=.8,color="black") +
  xlab("Year")+
  ylab("Density\n(no/m2)")+
  geom_point(shape = 19, size = 4, alpha = 0.7)+
  deets4 #deets3 deets4
ggsave("./doc/density_yr_scatter_site_nl.jpg",width=6, height=3)

ggplot(d2,aes(year,tx_density_u,color=site))+geom_point(shape = 19, size = 4, alpha = 0.7)+
  geom_segment(aes(y = 0.2, yend = 0.2, x = -Inf, xend = Inf),linetype = "longdash", lineend = "butt",linejoin="mitre" ,alpha=.8,color="black") +
  xlab("Year")+
  ylab("Density\n(no/m2)")+
  deets3+ #deets3 deets4
  geom_point(shape = 19, size = 4, alpha = 0.7)
ggsave("./doc/density_yr_scatter_site_l.jpg",width=6, height=3)

ggplot(d3,aes(year,tx_density_u,color=location))+geom_point()

ggplot(d4,aes(year,tx_density_u,color=location3))+
  geom_segment(aes(y = 0.2, yend = 0.2, x = -Inf, xend = Inf),linetype = "longdash", lineend = "butt",linejoin="mitre", alpha=.8,color="black") +
  geom_point()+
  xlab("Year")+
  ylab("Density\n(no/m2)")+deets4+
  geom_point(shape = 19, size = 4, alpha = 0.7)
  
ggsave("./doc/density_yr_scatter_loc3.jpg",width=6,height=3)

#save
write_csv(d2,"./results/tx_data_2002_2022_summarized_site.csv")
write_csv(d3,"./results/tx_data_2002_2022_summarized_location.csv")
write_csv(d4,"./results/tx_data_2002_2022_summarized_location3.csv")

