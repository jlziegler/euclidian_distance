

# setup
library(tidyverse)

# load formant tables
# DORIE
formants_dorie <- read.table("formants_dorie.txt", header = T)
# NEMO
formants_nemo <- read.table("formants_nemo.txt", header = T)

# create vowel column
formants_dorie$vowel <- gsub("[0-9]", "", formants_dorie$Label)
formants_nemo$vowel <- gsub("[0-9]", "", formants_nemo$Label)

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

# calculate mean and sd of F1, F2 and F3 Bark
# mean & sd DORIE
meansd_dorie <- formants_dorie %>%
  select_at(vars("vowel", "F1_mean.Bark", "F2_mean.Bark", "F3_mean.Bark")) %>%
  gather(key = 'formant', value = "value", -vowel) %>%
    group_by(vowel, formant) %>%
    summarise(mean = mean(value), sd = sd(value))

# mean & sd NEMO
meansd_nemo <- formants_nemo %>%
  select_at(vars("vowel", "F1_mean.Bark", "F2_mean.Bark", "F3_mean.Bark")) %>%
  gather(key = 'formant', value = "value", -vowel) %>%
  group_by(vowel, formant) %>%
  summarise(mean = mean(value), sd = sd(value))

# Euclidian Distance




