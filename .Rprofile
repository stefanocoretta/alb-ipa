source("renv/activate.R")

library(emuR)




# Set-up a local instance of the EMU-webApp ----
#
# If the directory ~/EWA/ does not exist, it is created and the EMU-webAPP is
# downloaded in it.

ewa_dir <- "~/EWA"

if (!dir.exists(ewa_dir)) {
  cat(crayon::orange("x Local EMU-webApp not found. Downloading now!"))
  dir.create(ewa_dir)
  git2r::clone("https://github.com/IPS-LMU/EMU-webApp.git", ewa_dir, "gh-pages")
} else {
  cat(crayon::green("✓ Local EMU-webApp found! Setting as default now!\n"))
}




# Set EMU-webApp directory ----
#
# The following sets the directory from which the EMU-webApp is launched to
# ~/EWA/.

options(emuR.emuWebApp.dir = ewa_dir)




# Load the alb-ipa emuDB ----

alb_ipa <- "./data/alb-ipa_emuDB/"

cat(crayon::green("✓ Loading emuDB...\n"))
albDB <- load_emuDB(alb_ipa)




# emuDB configuration utilities ----
#
# The following functions can be used to manage the emuDB configuration with the
# more human-readable yaml format. Alternatively, emuR functions can be used to
# programmatically set configuration options.

write_config_yml <- function() {
  config <- jsonlite::fromJSON(paste0(alb_ipa, "alb-ipa_DBconfig.json"))
  yaml::write_yaml(
    config,
    paste0(alb_ipa, "alb-ipa_DBconfig.yml")
  )
  cat(crayon::green("✓ Wrote emuDB config.yml!\n"))
}

write_config_json <- function() {
  config <- yaml::read_yaml(paste0(alb_ipa, "alb-ipa_DBconfig.yml"))
  jsonlite::write_json(config, paste0(alb_ipa, "alb-ipa_DBconfig.json"))
  cat(crayon::green("✓ Wrote emuDB config.json!\n"))
}




# Function to serve the alb-ipa emuDB ----

serve_albDB <- function() {
  serve(albDB)
}
