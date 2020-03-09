# Data processing procedure

## Recording

Speakers were recorded in the Phonetics Laboratory at the IPS.

The raw (original) recordings are saved in `data/recordings/raw/` with the name template `Subject_0_GENDER.wav`, where `0` is the speaker's ID number and `GENDER` is either `Female` or `Male`.
The raw recordings are stereo audio files. These have been converted to mono (same file name plus `_mono` suffix). The TextGrids in data/recordings/raw/` were manually created to specify intervals in the audio containing the word list, the sentences, the story, and intervals the audio within which is to be silenced.

## Force-alignment

The Praat script `code/get_prealign_chunks.praat` was run to extract the audio chunks (`words.wav`, `sentences.wav`, `story.wav`) used with webMAUS (force-alignment). The alignment `.txt` files (`words.txt`, `sentence.txt`, `story.txt`, used with webMAUS) were manually created to reflect the actual order of the stimuli in the recordings.
The alignment files of each speaker is saved in `data/recordings/derived/align/s00/`, where `00` is the speaker's ID number.

webMAUS general was used with the language independent setting and a custom grapheme to phoneme (G2P) mapping file (`data/varia/sqi-AL_map.txt`) to force-align the audio files.
The output TextGrids with the force-aligned annotation are saved in each speaker's folder in`data/recordings/derived/align/`.

The Praat script `code/get_postalign_chunks.praat` is run to extract individual audio and TextGrid chunks which were converted into the EMU database.
The output of the script is saved in `data/recordings/derived/post-aling/`.
This folder is ignored by git.

## EMU database creation

The post-alignment chunks in `data/recordings/derived/post-aling/` were then converted into the EMU database `data/alb-ipa_emuDB/`:

```r
library(emuR)
convert_TextGridCollection(
  "./data/recordings/derived/post-align/",
  "alb-ipa",
  "./data/alb-ipa_emuDB/"
)
```

The contents of the created `data/recordings/alb-ipa_emuDB/alb-ipa_emuDB/` were moved to `data/recordings/alb-ipa_emuDB/` (as of emuR 2.0.4 there is no straightforward way to create a DB in an already existing folder; rather, a new folder is created).
The EMU databse is a git submodule.
