# libraries ----
library(emuR)
library(wrassp)
library(tidyr)
library(dplyr)
library(data.table)

# load database & stuff ----
path = "./data/alb-ipa_emuDB"
path2 = "./data/dataframes"
db_handle = load_emuDB(path, verbose = TRUE)



# 1. FORMANTS ----

# 1.1 query database ----
vow = query(db_handle, "[MAU == p -> #MAU == e| i | y | u | @ | o | a]", bundlePattern="[0-9]*-(peri|por|puro|pyk3|pik3|p3r|para)")
word = requery_hier(db_handle, vow, "ORT-MAU")
vow$word = word$labels

# 1.2 get formant values at midpoint ----
formants = get_trackdata(db_handle, seglist = vow, cut=0.5, npoints=1, ssffTrackName = "FORMANTS", resultType = "tibble")
formants = formants[ , -which(names(formants) %in% c("T4", "T5"))]
formants <- formants[ which(formants$session != "s03"), ]

# 1.3 clean, arrange & save dataframe ----
formants$gender <- recode(formants$session, "s01" = "F", "s02"="M", "s04"="F", "s05"="M", "s06"="M")
setnames(formants, old = c("T1", "T2", "T3", "labels", "session"), new = c("F1", "F2", "F3", "vowel", "speaker"))
formants = formants[ , -which(names(formants) %in% c("sl_rowIdx", "db_uuid","session", "level", "attribute", "start_item_id", "end_item_id", "start_item_seq_idx", "end_item_seq_idx", "type", "sample_rate", "times_rel", "times_norm"))]
columns <- c("speaker", "gender", "vowel", "word", "bundle", "F1", "F2", "F3", "start", "end", "sample_start", "sample_end", "times_orig")
formants <- formants[, columns]
save(list=ls(), file = file.path(path2, "alb-ipa_dataframe_formants"))



# 2. VOT ----

# 2.1 query database ----
rels = query(db_handle, "RELS =~ .*", calcTimes = T)
word2 = requery_hier(db_handle, rels, "ORT-MAU")
rels$word = word2$labels
voi = query(db_handle, "VOI =~ .*", calcTimes = T)

# 2.2 calculate VOT ----
rels$tomatch = paste(rels$session, rels$bundle)
voi$tomatch = paste(voi$session, voi$bundle)
m = match(as.character(rels$tomatch), as.character(voi$tomatch))
vot = data.frame(rels, voicing = voi$start[m])
vot$VOT = (vot$voicing - as.numeric(vot$start))
vot$consonant = as.character(substr(vot$word, 1, 1))

# 2.3 clean, arrange & save dataframe ----
vot$gender <- recode(vot$session, "s01" = "F", "s02"="M", "s04"="F", "s05"="M", "s06"="M")
setnames(vot, old = c("start", "session"), new = c("release", "speaker"))
vot = vot[ , -which(names(vot) %in% c("labels", "end", "db_uuid","session", "level", "attribute", "start_item_id", "end_item_id", "start_item_seq_idx", "end_item_seq_idx", "type", "sample_rate", "tomatch", "sample_start", "sample_end"))]
columns2 <- c("speaker", "gender", "consonant", "word", "bundle", "VOT", "release", "voicing")
vot <- vot[, columns2]
save(list=ls(), file = file.path(path2, "alb-ipa_dataframe_vot"))
