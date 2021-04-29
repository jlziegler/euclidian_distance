

# setup
library(tidyverse)

# load formants
# DORIE
formants_dorie <- read.table("formants_dorie.txt")
# NEMO
formants_nemo <- read.table("formants_nemo.txt", header = T)

# Hz to Bark
library(emuR)
# DORIE
formants_dorie$F1_mean.Bark <- 

# calculate mean and sd of F1, F2 and F3


# Euclidian Distance