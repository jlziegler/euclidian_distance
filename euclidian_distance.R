

# setup
library(tidyverse)

# load formants
# DORIE
formants_dorie <- read.table("formants_dorie.txt", header = T)
# NEMO
formants_nemo <- read.table("formants_nemo.txt", header = T)

# Hz to Bark
library(emuR)
# DORIE
formants_dorie$F1_mean.Bark <- bark(formants_dorie$F1_mean.Hz.)
formants_dorie$F2_mean.Bark <- bark(formants_dorie$F2_mean.Hz.)
formants_dorie$F3_mean.Bark <- bark(formants_dorie$F3_mean.Hz.)

# NEMO
formants_nemo$F1_mean.Bark <- bark(formants_nemo$F1_mean.Hz.)
formants_nemo$F2_mean.Bark <- bark(formants_nemo$F2_mean.Hz.)
formants_nemo$F3_mean.Bark <- bark(formants_nemo$F3_mean.Hz.)

# calculate mean and sd of F1, F2 and F3


# Euclidian Distance