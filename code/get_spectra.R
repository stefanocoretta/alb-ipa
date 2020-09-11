library(emuR)
library(wrassp)
library(tidyverse)

path <- "./data/alb-ipa_emuDB"

db <- load_emuDB(path, verbose = TRUE)

add_ssffTrackDefinition(
  db,
  name = "dft",
  onTheFlyFunctionName = "dftSpectrum",
  verbose = TRUE
)

# Get query list
fric_segs <- query(
  db,
  "[MAU == f|v|T|D|s|z|S|Z]",
  bundlePattern = "[0-9]*-(fati|vata|that3|dhat3|salla|zalli|shava|zhaba)"
)

# Get dft in wide format
fric_dft <- get_trackdata(
  db,
  seglist = fric_segs,
  ssffTrackName = "dft",
  resultType = "tibble",
  cut = 0.5
)

fric_dft_l <- convert_wideToLong(fric_dft, calcFreqs = T)

# Get spectral moments
fric_moments <- fric_dft_l %>%
  filter(freq < 10000) %>%
  group_by(labels, sl_rowIdx) %>%
  do(data_frame(moments = moments(.$track_value,.$freq, minval = TRUE))) %>%
  mutate(moment_num = paste0("moment_", 1:(table(sl_rowIdx)))) %>%
  pivot_wider(names_from = "moment_num", values_from = "moments")

fric_moments %>%
  group_by(labels) %>%
  summarise(mean = mean(moment_1), sd = sd(moment_1))

saveRDS(fric_dft_l, file = "./data/dataframes/fric_dtf_l.rds")
saveRDS(fric_moments, file = "./data/dataframes/fric_moments.rds")
