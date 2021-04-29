

# setup
library(tidyverse)

# load formants
# DORIE
formants_dorie <- read.table("formants_dorie.txt")
colnames(formants_dorie) <- as.matrix(formants_dorie[1,])
formants_dorie <- formants_dorie[-1,]
# NEMO
formants_nemo <- read.table("formants_nemo.txt")
colnames(formants_nemo) <- as.matrix(formants_nemo[1,])
formants_nemo <- formants_nemo[-1,]

# Hz to Bark
library(emuR)
# DORIE
formants_dorie$F1_mean.Hz. <- 

# calculate mean and sd of F1, F2 and F3


# Euclidian Distance