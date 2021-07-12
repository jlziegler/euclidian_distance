### CALCULATE EUCLIDIAN DISTANCE OF WORD STIMULI VOWELS (BARK)
### Joshua Ziegler, 12.07.2021

# setup
library(tidyverse)
library(emuR)

# load formant tables
formants_word <- read_csv2("formants_word.csv")

# remove F0
formants_word <- formants_word %>% select(!c(`mean F0 per token`, `SD f0 per token (Dauer)`))

# Hz to Bark
# MEAN
formants_word$F1_mean_Bark <- bark(formants_word$`F1 (mean)`)
formants_word$F2_mean_Bark <- bark(formants_word$`F2 (mean)`)
formants_word$F3_mean_Bark <- bark(formants_word$`F3 (mean)`)
# SD
formants_word$F1_sd_Bark <- bark(formants_word$`F1 SD (per token)`)
formants_word$F2_sd_Bark <- bark(formants_word$`F2 SD (per token)`)
formants_word$F3_sd_Bark <- bark(formants_word$`F3 SD (per token)`)

# calculate mean and sd of F1, F2 and F3 Bark
meansd_word <- formants_word %>%
  select_at(vars("word", "F1_mean_Bark", "F2_mean_Bark", "F3_mean_Bark")) %>%
  gather(key = 'formant', value = "value", -word) %>%
  group_by(word, formant) %>%
  summarise(mean = mean(value), sd = sd(value))

# Euclidian Distance
# define function
euclid <- function(a, b)
{
  # Function to calculate Euclidean distance between a and b; 
  # a and b are vectors of the same length
  sqrt(sum((a - b)^2))
}

# vector by vowel
word_Mahl <- meansd_word %>%
  filter(word == "Mahl",
         !grepl("^F3", formant)) %>%  # assures that only F1 and F2 are pulled
  pull(mean)
word_Mehl <- meansd_word %>%
  filter(word == "Mehl",
         !grepl("^F3", formant)) %>%
  pull(mean)
word_Stieg <- meansd_word %>%
  filter(word == "Stieg",
         !grepl("^F3", formant)) %>%
  pull(mean)
word_Steg <- meansd_word %>%
  filter(word == "Steg",
         !grepl("^F3", formant)) %>%
  pull(mean)
word_Stiel <- meansd_word %>%
  filter(word == "Stiel",
         !grepl("^F3", formant)) %>%
  pull(mean)
word_Stuhl <- meansd_word %>%
  filter(word == "Stuhl",
         !grepl("^F3", formant)) %>%
  pull(mean)
word_Sud <- meansd_word %>%
  filter(word == "Sud",
         !grepl("^F3", formant)) %>%
  pull(mean)
word_Süd <- meansd_word %>%
  filter(word == "Süd",
         !grepl("^F3", formant)) %>%
  pull(mean)
word_Zahl <- meansd_word %>%
  filter(word == "Zahl",
         !grepl("^F3", formant)) %>%
  pull(mean)
word_Ziel <- meansd_word %>%
  filter(word == "Ziel",
         !grepl("^F3", formant)) %>%
  pull(mean)

# calculate euclidian distance (F1, F2)
dist_Mehl_Mahl <- euclid(word_Mahl, word_Mehl)
dist_Stieg_Steg <- euclid(word_Stieg, word_Steg)
dist_Stiel_Stuhl <- euclid(word_Stiel, word_Stuhl)
dist_Sud_Süd <- euclid(word_Sud, word_Süd)
dist_Ziel_Zahl <- euclid(word_Ziel, word_Zahl)
# combine
dist_word <- c(dist_Mehl_Mahl, dist_Stieg_Steg, dist_Stiel_Stuhl, dist_Sud_Süd, dist_Ziel_Zahl)
# rownames
contrast_word <- c("Mehl_Mahl", "Stieg_Steg", "Stiel_Stuhl", "Sud_Süd", "Ziel_Zahl")

# table
word_euclid <- data.frame(contrast_word, dist_word)

# write.csv
dir.create("word")
write_csv2(meansd_word, "word/word_mean_sd_Bark.csv")
write_csv2(word_euclid, "word/word_euclid_Bark.csv")

#test