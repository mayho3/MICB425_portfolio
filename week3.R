#Comments
install.packages("tidyverse")
library(tidyverse)
#Load data
read.table(file="Saanich.metadata.txt")
read.table(file="Saanich.metadata.txt", header=TRUE, row.names=1, sep="\t", na.strings="NAN")

OTU<- read.table(file="Saanich.metadata.txt", header=TRUE, 
                 row.names=1, sep="\t", na.strings=c("NAN", "NA", "."))
metadata <- read.table(file="Saanich.metadata.txt", header=TRUE, row.names=1, sep="\t")

#Day 2
library(tidyverse)

metadata %>% 
  select(O2_uM)
#select data with 02 or oxygen   
metadata %>% 
  select(matches("02|oxygen"))

metadata %>% 
  filter(O2_uM == 0)

metadata %>% 
  filter(O2_uM == 0) %>% 
  select(Depth_m)

metadata %>%
  select(matches("CH4|methane"), matches("temp"))


#Variables are CH4_nM and Temperature_C

#Using dplyr, find at what depth(s) methane (CH4) is above 100 nM while temperature is below 10 °C. Print out a table showing only the depth, methane, and temperature data.
metadata %>%
  filter(CH4_nM > 100) %>%
  filter(Temperature_C < 10) %>%
  select(Depth_m, CH4_nM, Temperature_C)

metadata %>% 
  mutate(N2O_uM = N2O_nM/1000)

#Convert all vairables that in in nM to uM. 
# Putput a table showing only the original nM and converted uM variables 


