library(tidyverse)
source("https://bioconductor.org/biocLite.R")
biocLite("phyloseq")
load("phyloseq_object.RData")

#Figure 1: plotting NH4_uM against depth
ggplot(metadata, aes(x=NH4_uM, y=Depth_m)) +
  geom_point(shape=17, color="purple")

#Figure 2: 
metadata %>% 
  mutate(Temperature_F = (Temperature_C*9/5)+ 32) %>%
  ggplot() + geom_point(aes(x=Temperature_F, y=Depth_m))

#Figure 3:
physeq_percent = transform_sample_counts(physeq, function(x) 100 * x/sum(x))
plot_bar(physeq_percent, fill="Genus") + 
  geom_bar(aes(fill=Genus), stat="identity") +
  labs(x= "Sample Depth") +
  labs(y= "Percent relative abundace") + 
  labs(title = "Phyla from 10 to 200m in Saanich Inlet")

#Figure 4:
metadata %>%
  select(Depth_m,O2_uM, PO4_uM, SiO2_uM, NO3_uM, NH4_uM, NO2_uM) %>%
  gather("Nutrients", "nutrient_concentration", O2_uM:NO2_uM)%>%
  ggplot() + geom_point(aes(x=Depth_m, y=nutrient_concentration)) + 
  facet_wrap(~Nutrients)

  

 




