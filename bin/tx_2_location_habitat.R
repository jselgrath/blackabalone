# Jennifer Selgrath
# Hopkins Marine Station
# Historical Black Abalone

# goal: setting location variables for contemporary black abalone DENSITY data
# ------------------------------------------------------------------------
library(tidyverse); 

# --------------------------------------------------------------------------
remove(list=ls())
setwd("C:/Users/jselg/Dropbox/research_x1/R_projects/mbc/black_abalone")


d1<-read_csv("./results/tx_data_2002_2022_habitat.csv")%>%
  glimpse()

levels(as.factor(d1$site))

# site ---------------------------------------------------------
levels(as.factor(d1$site))
d1$site[d1$site=="Pt Pinos"]<-"Point Pinos"
d1$site[d1$site=="Pt. Pinos"]<-"Point Pinos"
d1$site[d1$site=="Carmel"]<-"Carmel Bay"   # confirm with alison 
d1$site[d1$site=="Lobos"]<-"Point Lobos"
d1$site[d1$site=="Pescadero"]<-"Pescadero Point"
d1$site[d1$site=="HMS"]<-"Hopkins"

levels(as.factor(d1$site))

d1$location<-d1$site
d1$location3<-"TBD"

# Location 3 ---------------------------------------------------
levels(as.factor(d1$location3))
# Monterey Outer
d1$location3[d1$location=="Point Pinos"]<-"Monterey Outer"
d1$location3[d1$location=="Pt Pinos"]<-"Monterey Outer"
d1$location3[d1$location=="China Rock"]<-"Monterey Outer"
d1$location3[d1$location=="Pescadero Point"]<-"Monterey Outer"

# Monterey Bay
d1$location3[d1$location=="Cannery Row"]<-"Monterey Bay"
d1$location3[d1$location=="Hopkins"]<-"Monterey Bay"
d1$location3[d1$location=="MontereyUnspecified"]<-"Monterey Bay"
d1$location3[d1$location=="Sea Palm"]<-"Monterey Bay" #Sea palm is a one off site we did last summer it's about half way between lovers and pinos will forward you an email with a map point

# Carmel Outer
d1$location3[d1$location=="Carmel Point"]<-"Carmel Outer"
d1$location3[d1$location=="PLER"]<-"Carmel Outer" # point lobos
d1$location3[d1$location=="Point Lobos"]<-"Carmel Outer" # point lobos

# Carmel Bay
d1$location3[d1$location=="Carmel Bay"]<-"Carmel Bay"


# Big Sur
d1$location3[d1$location=="Soberanes"]<-"Big Sur"
d1$location3[d1$location=="Malpaso"]<-"Big Sur"

levels(as.factor(d1$location3))




# Location 1 ---------------------------------------------------
levels(as.factor(d1$location))
# Monterey Outer
d1$location[d1$location=="Point Pinos"]<-"Monterey Peninsula"
d1$location[d1$location=="Pt Pinos"]<-"Monterey Peninsula"
d1$location[d1$location=="China Rock"]<-"Monterey Peninsula"
d1$location[d1$location=="Pescadero Point"]<-"Monterey Peninsula"

# Monterey Bay
d1$location[d1$location=="Cannery Row"]<-"Monterey Peninsula"
d1$location[d1$location=="Hopkins"]<-"Monterey Peninsula"
d1$location[d1$location=="MontereyUnspecified"]<-"Monterey Peninsula"
d1$location[d1$location=="Sea Palm"]<-"Monterey Peninsula" #Sea palm is a one off site we did last summer it's about half way between lovers and pinos will forward you an email with a map point

# Carmel Outer
d1$location[d1$location=="Carmel Point"]<-"Monterey Peninsula"
d1$location[d1$location=="PLER"]<-"Monterey Peninsula" # point lobos
d1$location[d1$location=="Point Lobos"]<-"Monterey Peninsula"

# Carmel Bay
d1$location[d1$location=="Carmel Bay"]<-"Monterey Peninsula"


# Big Sur
d1$location[d1$location=="Soberanes"]<-"Big Sur"
d1$location[d1$location=="Malpaso"]<-"Big Sur"

levels(as.factor(d1$location))

# save
write_csv(d1,"./results/tx_data_2002_2022_location13_habitat.csv")

