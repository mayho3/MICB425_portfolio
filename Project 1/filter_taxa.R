
# Set-up
library(tidyverse)
source("https://bioconductor.org/biocLite.R")  
biocLite("phyloseq")  
library(phyloseq)
library(data.table)

# Load phyloseq dataa
load("mothur_phyloseq.RData")
load("qiime2_phyloseq.RData")

# Retrieve tables
Tax_MTable = mothur@tax_table

OTU_MTable = mothur@otu_table

Sam_MData = mothur@sam_data

Tax_QM2Table = qiime2@tax_table

OTU_QM2Table = qiime2@otu_table

Sam_QM2Data = qiime2@sam_data

# Transforming Mothur into data frames
OTU_MDF <- data.frame(OTU_MTable)

Tax_MDF <- data.frame(Tax_MTable)
setDT(Tax_MDF, keep.rownames=TRUE)
colnames(Tax_MDF)[1] <- "OTU"

# Fitering Mothur
Genus_MTax <- Tax_MDF %>% select(OTU, Genus) %>% filter(!str_detect(Genus, 'uncultured'), !str_detect(Genus, 'unclassified'))

Genus_MTax_Filtered <- Tax_MDF %>% select(Genus) %>% filter(!str_detect(Genus, 'uncultured'), !str_detect(Genus, 'unclassified'))

Genus_MTax_Count <- data.frame(table(Genus_MTax_Filtered))

# Filtered Results (Less filtered --> More filtered down the list)
Genus_MCount_Filtered <- Genus_MTax_Count %>% filter(Freq >= 5, Freq < 50)

# Genus Names of Filtered
Genus_MCount_Filtered$Genus_MTax_Filtered

GM_Grp_Filtered <- Genus_MCount_Filtered %>% filter(!str_detect(Genus_MTax_Filtered, 'group'), !str_detect(Genus_MTax_Filtered, '_ge'), !str_detect(Genus_MTax_Filtered, 'clade'))

# Transforming Qiime2 into data frames
OTU_QM2DF <- data.frame(OTU_QM2Table)

Tax_QM2DF <- data.frame(Tax_QM2Table)
setDT(Tax_QM2DF, keep.rownames=TRUE)
colnames(Tax_QM2DF)[1] <- "OTU"

# Filtering Qiime2
Genus_QM2Tax <- Tax_QM2DF %>% select(OTU, Genus) %>% filter(!str_detect(Genus, 'uncultured'), !str_detect(Genus, 'unclassified'))

Genus_QM2Tax_Filtered <- Tax_QM2DF %>% select(Genus) %>% filter(!str_detect(Genus, 'uncultured'), !str_detect(Genus, 'unclassified'))

Genus_QM2Tax_Count <- data.frame(table(Genus_QM2Tax_Filtered))

# Filtered Results (Less filtered --> More filtered down the list)
Genus_QM2Count_Filtered <- Genus_QM2Tax_Count %>% filter(Freq >= 5, Freq < 50)

# Genus Names of Filtered
Genus_QM2Count_Filtered$Genus_QM2Tax_Filtered

GQM2_Grp_Filtered <- Genus_QM2Count_Filtered %>% filter(!str_detect(Genus_QM2Tax_Filtered, 'group'), !str_detect(Genus_QM2Tax_Filtered, '_ge'), !str_detect(Genus_QM2Tax_Filtered, 'clade'))



