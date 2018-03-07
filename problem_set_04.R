#To make tables
library(kableExtra)
library(knitr)
#To manipulate and plot data
library(tidyverse)

seawater_data = read.csv("candy-data.csv",
                           header = TRUE)
seawater_data_small = read.csv("candy-data_small.csv",
                               header = TRUE)
seawater_data %>% 
  kable("html") %>%
  kable_styling(bootstrap_options = "striped", font_size = 10, full_width = F)

collection_curve = read.csv("collection_curve.csv", 
                            header = FALSE)

ggplot(collection_curve, aes(x=V1, y=V2)) +
  geom_point() +
  geom_smooth() +
  labs(x="Cumulative number of individuals classified", y="Cumulative number of species observed")

library(vegan)
data_diversity = 
  seawater_data %>% 
  select(name, occurances) %>% 
  spread(name, occurances)

small_data_diversity = 
  seawater_data_small %>% 
  select(name, occurances) %>% 
  spread(name, occurances)

data_diversity

# Calcualte Simpson Reciprocal Index 
diversity(data_diversity, index="invsimpson")
diversity(small_data_diversity, index = "invsimpson")

#Calculate Chaol richness estimator
specpool(data_diversity)
specpool(small_data_diversity)

