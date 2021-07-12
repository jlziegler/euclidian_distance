### CALCULATE EUCLIDIAN DISTANCE OF ISOLATED VOWELS (BARK)
### Joshua Ziegler, 29.04.2021

# setup
library(tidyverse)
library(emuR)

# load formant tables
# DORIE
formants_dorie <- read.table("formants_dorie.txt", header = T)
# NEMO
formants_nemo <- read.table("formants_nemo.txt", header = T)

# create vowel column
formants_dorie$vowel <- gsub("[0-9]", "", formants_dorie$Label)
formants_nemo$vowel <- gsub("[0-9]", "", formants_nemo$Label)

# Hz to Bark
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
# define function
euclid <- function(a, b)
{
  # Function to calculate Euclidean distance between a and b; 
  # a and b are vectors of the same length
  sqrt(sum((a - b)^2))
}

# DORIE
# vector by vowel
dor_e <- meansd_dorie %>%
      filter(vowel == "e") %>%
      pull(mean)
dor_o <- meansd_dorie %>%
  filter(vowel == "o") %>%
  pull(mean)
dor_u <- meansd_dorie %>%
  filter(vowel == "u") %>%
  pull(mean)

# calculate euclidian distance (F1, F2, F3)
dist_e_o <- euclid(dor_e, dor_o)
dist_e_u <- euclid(dor_e, dor_u)
dist_u_o <- euclid(dor_u, dor_o)
# combine
dist_dor <- c(dist_e_o, dist_e_u, dist_u_o)
# rownames
contr_dor <- c("e_o", "e_u", "u_o")

# table
dor_euclid <- data.frame(contr_dor, dist_dor)

# NEMO
# vector by vowel
nemo_ae <- meansd_nemo %>%
  filter(vowel == "ae") %>%
  pull(mean)
nemo_oe <- meansd_nemo %>%
  filter(vowel == "oe") %>%
  pull(mean)
nemo_ue <- meansd_nemo %>%
  filter(vowel == "ue") %>%
  pull(mean)

# calculate euclidian distance
dist_ae_oe <- euclid(nemo_ae, nemo_oe)
dist_ae_ue <- euclid(nemo_ae, nemo_ue)
dist_ue_oe <- euclid(nemo_ue, nemo_oe)

# combine
dist_nemo <- c(dist_ae_oe, dist_ae_ue, dist_ue_oe)
# rownames
contr_nemo <- c("ae_oe", "ae_ue", "ue_oe")

# table
nemo_euclid <- data.frame(contr_nemo, dist_nemo)

# export as csv
write.csv(formants_dorie, "formants_dorie.csv")
write.csv(formants_nemo, "formants_nemo.csv")
write.csv(meansd_dorie, "mean_sd_dorie.csv")
write.csv(meansd_nemo, "mean_sd_nemo.csv")
write.csv(dor_euclid, "euclid_dorie.csv")
write.csv(nemo_euclid, "euclid_nemo.csv")

######