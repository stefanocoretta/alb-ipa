library(emuR)
library(wrassp)
library(PraatR) # devtools::install_github("usagi5886/PraatR")
library(tools)

path = "./data/alb-ipa_emuDB"

db_handle = load_emuDB(path, verbose = TRUE)
# serve(db_handle)


# Build hierarchical structure ----
autobuild_linkFromTimes(db_handle, superlevelName = "ORT-MAU", sublevelName = "KAN-MAU", convertSuperlevel = TRUE, newLinkDefType = "ONE_TO_MANY")
autobuild_linkFromTimes(db_handle, superlevelName = "KAN-MAU", sublevelName = "MAU", convertSuperlevel = TRUE, newLinkDefType = "ONE_TO_MANY")

# Function ----

##' Call Praat's To Formant (burg)... function and
##' convert the output to an AsspDataObj object
##' @param path path to wav file
##' @param command Praat command to use
##' @param arguments arguments passed to \code{PraatR::praat()} arguments argument
##' @param columnNames specify column names of AsspDataObj
praatToFormants2AsspDataObj <- function(path,
                                        command = "To Formant (burg)...",
                                        arguments = list(0.0,
                                                         5,
                                                         5500,
                                                         0.025,
                                                         50),
                                        columnNames = c("fm", "bw")){

  tmp1FileName = "tmp.ooTextFile"
  tmp2FileName = "tmp.table"

  tmp1FilePath = file.path(tempdir(), tmp1FileName)
  tmp2FilePath = file.path(tempdir(), tmp2FileName)

  # remove tmp files if they already exist
  unlink(file.path(tempdir(), tmp1FileName))
  unlink(file.path(tempdir(), tmp2FileName))

  # generate ooTextFile
  PraatR::praat(command = command,
                input = path,
                arguments = arguments,
                output = tmp1FilePath)

  # convert to Table
  PraatR::praat("Down to Table...",
                input = tmp1FilePath,
                arguments = list(F, T, 6, F, 3, T, 3, T),
                output = tmp2FilePath,
                filetype = "comma-separated")

  # get vals
  df = read.csv(tmp2FilePath, stringsAsFactors = FALSE)
  df[df == '--undefined--'] = 0

  fmVals = df[,c(3, 5, 7, 9, 11)]
  fmVals = sapply(colnames(fmVals), function(x){
    as.integer(fmVals[,x])
  })
  colnames(fmVals) = NULL
  bwVals = data.matrix(df[,c(4, 6, 8, 10, 12)])
  bwVals = sapply(colnames(bwVals), function(x){
    as.integer(bwVals[,x])
  })
  colnames(bwVals) = NULL

  # get start time
  startTime = df[1,1]

  # create AsspDataObj
  ado = list()

  attr(ado, "trackFormats") = c("INT16", "INT16")

  if (arguments[[1]] == 0) {
    sR = 1 / (0.25 * arguments[[4]])
  } else {
    sR = 1 / arguments[[1]]
  }

  attr(ado, "sampleRate") = sR

  tmpObj = wrassp::read.AsspDataObj(path)
  attr(ado, "origFreq") = attr(tmpObj, "sampleRate")

  attr(ado, "startTime") = startTime

  # attr(ado, "startRecord") = as.integer(1)

  attr(ado, "endRecord") = as.integer(nrow(fmVals))

  class(ado) = "AsspDataObj"

  wrassp::AsspFileFormat(ado) <- "SSFF"
  wrassp::AsspDataFormat(ado) <- as.integer(2) # == binary

  ado = wrassp::addTrack(ado, columnNames[1], fmVals, "INT16")

  ado = wrassp::addTrack(ado, columnNames[2], bwVals, "INT16")

  # add missing values at the start as Praat sometimes
  # has very late start values which causes issues
  # in the SSFF file format as this sets the startRecord
  # depending on the start time of the first sample
  if (startTime > 1/sR) {
    nr_of_missing_samples = floor(startTime / (1/sR))

    missing_fm_vals = matrix(0,
                             nrow = nr_of_missing_samples,
                             ncol = ncol(ado$fm))

    missing_bw_vals = matrix(0,
                             nrow = nr_of_missing_samples,
                             ncol = ncol(ado$bw))

    # prepend values
    ado$fm = rbind(missing_fm_vals, ado$fm)
    ado$bw = rbind(missing_fm_vals, ado$bw)

    # fix start time
    attr(ado, "startTime") = startTime - nr_of_missing_samples * (1/sR)
  }


  return(ado)
}

# Add formant tracks ----

wav_paths = list.files(path, pattern = ".*wav$", recursive = T, full.names = T)

k = 1
for (fp in wav_paths) {
  print(k)
  ado = praatToFormants2AsspDataObj(normalizePath(fp), arguments = list(0.0, 5, 5500, 0.025, 50))
  newPath = paste0(file_path_sans_ext(normalizePath(fp)), '.praatFms')
  print(paste0(fp, ' -> ', newPath))
  k = k + 1
  write.AsspDataObj(ado, file = newPath)
}


add_ssffTrackDefinition(db_handle,
                        name = "FORMANTS",
                        columnName = "fm",
                        fileExtension = "praatFms",
                        verbose = TRUE)

# Add f0 track ----

add_ssffTrackDefinition(db_handle,
                        name = "F0",
                        onTheFlyFunctionName = "ksvF0",
                        verbose = TRUE)

# Add release and voice onset level defitions ----

add_levelDefinition(db, "RELS", "EVENT")
add_levelDefinition(db, "VOI", "EVENT")
add_levelDefinition(db_handle, "SYL", "ITEM")
