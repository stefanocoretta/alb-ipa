source("renv/activate.R")

# Set-up a local instance of the EMU-webApp ----
#
# If the directory ~/EWA/ does not exist, it is created and the EMU-webAPP is
# downloaded in it.

# Fixed in emuR 2.3.0
# This is needed because emuR overrides options at loading.
# library(emuR)

# Don't use local emu-WebApp
# ewa_dir <- file.path(Sys.getenv("HOME"), "EWA")
# ewa_git <- file.path(ewa_dir, ".git")
#
# if (!dir.exists(ewa_git)) {
#   cat(crayon::yellow("x Local EMU-webApp not found. Downloading now!\n"))
#   dir.create(ewa_dir, showWarnings = F)
#   git2r::clone(
#     url = "https://github.com/IPS-LMU/EMU-webApp.git",
#     local_path = ewa_dir,
#     branch = "gh-pages"
#   )
# } else {
#   cat(crayon::green("✓ Local EMU-webApp found! Setting as default now!\n"))
# }
#
# Set EMU-webApp directory ----
#
# The following sets the directory from which the EMU-webApp is launched to
# ~/EWA/.
#
# options(emuR.emuWebApp.dir = ewa_dir)




# Load the alb-ipa emuDB ----

alb_ipa <- "./data/alb-ipa_emuDB"

cat(crayon::green("✓ Loading alb-ipa_emuDB...\n"))
alb_ipa_db <- emuR::load_emuDB(alb_ipa)




# Function to serve the alb-ipa emuDB ----

serve_albDB <- function() {
  serve(alb_ipa_db)
}

