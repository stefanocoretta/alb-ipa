library(emuR)

db <- load_emuDB("./data/alb-ipa_emuDB/")

all <- list_bundles(db)

s01 <- list_bundles(db, "s01")
s02 <- list_bundles(db, "s02")
s04 <- list_bundles(db, "s04")
s05 <- list_bundles(db, "s05")
s06 <- list_bundles(db, "s06")

write_bundleList(db, "josie", all)
write_bundleList(db, "stephen", all)
write_bundleList(db, "lejda", all)
write_bundleList(db, "stefano", all)
