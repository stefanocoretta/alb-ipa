library(emuR)
library(wrassp)
library(PraatR)

path = "./data/alb-ipa_emuDB"

db_handle = load_emuDB(path, verbose = FALSE)
# serve(db_handle)


#Build hierarchical structure
autobuild_linkFromTimes(db_handle, superlevelName = "ORT-MAU", sublevelName = "KAN-MAU", convertSuperlevel = TRUE, newLinkDefType = "ONE_TO_MANY")
autobuild_linkFromTimes(db_handle, superlevelName = "KAN-MAU", sublevelName = "MAU", convertSuperlevel = TRUE, newLinkDefType = "ONE_TO_MANY")


#Add formant tracks

wav_paths = list.files(path, pattern = ".*wav$", recursive = T, full.names = T)

k = 1
for(fp in wav_paths){
  print(k)
  ado = PraatToFormants2AsspDataObj(fp, arguments = list(0.0, 4.5, 5000, 0.025, 50))
  newPath = paste0(file_path_sans_ext(fp), '.praatFms')
  print(paste0(fp, ' -> ', newPath))
  k = k + 1
  write.AsspDataObj(ado, file = newPath)
}


add_ssffTrackDefinition(db,
                        name = "praatFms",
                        columnName = "fm",
                        fileExtension = "praatFms")

#Add f0 track

add_ssffTrackDefinition(db,
                        name = "F0",
                        onTheFlyFunctionName = "ksvF0",
                        verbose = FALSE)
