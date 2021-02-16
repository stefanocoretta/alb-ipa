source("renv/activate.R")

library(emuR)




# Set-up a local instance of the EMU-webApp ----
#
# If the directory ~/EWA/ does not exist, it is created and the EMU-webAPP is
# downloaded in it.

ewa_dir <- file.path(Sys.getenv("HOME"), "EWA")
ewa_git <- file.path(ewa_dir, ".git")

if (!dir.exists(ewa_git)) {
  cat(crayon::yellow("x Local EMU-webApp not found. Downloading now!\n"))
  dir.create(ewa_dir, showWarnings = F)
  git2r::clone(
    url = "https://github.com/IPS-LMU/EMU-webApp.git",
    local_path = ewa_dir,
    branch = "gh-pages"
  )
} else {
  cat(crayon::green("✓ Local EMU-webApp found! Setting as default now!\n"))
}




# Set EMU-webApp directory ----
#
# The following sets the directory from which the EMU-webApp is launched to
# ~/EWA/.

options(emuR.emuWebApp.dir = ewa_dir)




# Load the alb-ipa emuDB ----

alb_ipa <- "./data/alb-ipa_emuDB"

cat(crayon::green("✓ Loading alb-ipa_emuDB...\n"))
alb_ipa_db <- load_emuDB(alb_ipa)




# Load the alb-ipa-int emuDB ----

alb_int <- "./data/alb-ipa-int_emuDB"

cat(crayon::green("✓ Loading alb-ipa-int_emuDB...\n"))
alb_int_db <- load_emuDB(alb_int)




# emuDB configuration utilities ----
#
# The following functions can be used to manage the emuDB configuration with the
# more human-readable yaml format. Alternatively, emuR functions can be used to
# programmatically set configuration options.

write_config_yml <- function() {
  config <- jsonlite::read_json(file.path(alb_ipa, "alb-ipa_DBconfig.json"))
  yaml::write_yaml(
    config,
    file.path(alb_ipa, "alb-ipa_DBconfig.yml")
  )
  cat(crayon::green("✓ Wrote emuDB config.yml!\n"))
}

write_config_json <- function() {
  config <- yaml::read_yaml(file.path(alb_ipa, "alb-ipa_DBconfig.yml"))
  config_json <- jsonlite::toJSON(config, auto_unbox = T, pretty = T)
  readr::write_file(config_json, file.path(alb_ipa, "alb-ipa_DBconfig.json"))
  cat(crayon::green("✓ Wrote emuDB config.json!\n"))
}




# Function to serve the alb-ipa emuDB ----

serve_albDB <- function() {
  serve(alb_ipa_db)
}
