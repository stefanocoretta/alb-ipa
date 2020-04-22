# Data processing procedure

## Recording

Speakers were recorded in the Phonetics Laboratory at the IPS.

The raw (original) recordings are saved in `data/recordings/raw/` with the name template `Subject_0_GENDER.wav`, where `0` is the speaker's ID number and `GENDER` is either `Female` or `Male`.
The raw recordings are stereo audio files.
These have been converted to mono (same file name plus `_mono` suffix).
The TextGrids in `data/recordings/raw/` were manually created to specify intervals in the audio containing the word list, the sentences, the story (tier 1 `type`, possible labels `words`, `sentences`,  `story`), and intervals the audio within which is to be silenced (tier 2 `silenced`, label `silence`).

## Force-alignment

The Praat script `code/get_prealign_chunks.praat` was run to extract the audio chunks (`words.wav`, `sentences.wav`, `story.wav`) used with webMAUS (force-alignment).
The alignment `.txt` files (`words.txt`, `sentence.txt`, `story.txt`, used with webMAUS) were manually created to reflect the actual order of the stimuli in the recordings.
The alignment files of each speaker are saved in `data/recordings/derived/align/s00/`, where `00` is the speaker's ID number.

Force-alignment was achieved with the BAS web service `Pipeline without ASR` with the following settings:

- Pipeline name: G2P->MAUS
- Language: Language independent
- Output format: Praat
- Keep everything: false
- Expert options > Imap mapping file (G2P): browse to the custom grapheme to phoneme (G2P) mapping file (`data/varia/sqi-AL_map.txt`)

The output TextGrids with the force-aligned annotation are saved in each speaker's folder in`data/recordings/derived/align/`.

The `sentence.TextGrid` files needed to be manually changed by adding an extra tier which includes a sentence-level segmentation (MAUS output currently does not include a sentence-level segmentation tier).
The extra tier, called `sent`, was added as tier 1.
The intervals in `sent` contain the following labels according to the type of the sentence: `broad-focus`, `polar-q`, `narrow-focus-q`, `narrow-focus`.

The Praat script `code/get_postalign_chunks.praat` was then run to extract individual audio and TextGrid chunks which were later converted into the EMU database (see below).
The output of this script gets saved in `data/recordings/derived/post-align/`.
This folder is ignored by git.

## EMU database creation

The post-alignment chunks in `data/recordings/derived/post-align/` were then converted into the EMU database `data/alb-ipa_emuDB/`:

```r
library(emuR)
convert_TextGridCollection(
  "./data/recordings/derived/post-align/",
  "alb-ipa",
  "./data/alb-ipa_emuDB/"
)
```

The contents of the created `data/recordings/alb-ipa_emuDB/alb-ipa_emuDB/` were moved to `data/recordings/alb-ipa_emuDB/` (as of emuR 2.0.4 there is no straightforward way to create a DB in an already existing folder; rather, a new folder is created).
The EMU database is a git submodule.

## Build hierarchy, get formants/f0 tracks

The script `code/add_hier_formants_f0.R` was run to build the annotation hierarchy, get formants and f0 tracks.

The hierarchy:

- `ORT-MAU`: spelling.
- `KANN-MAU`: MAUS word transcription.
- `MAU`: MAUS segment transcription.

Formant tracks were obtained with the `praatFms` function from wrassp.
This function uses Praat's algorithm.
The following settings were used:

- Number of formants: 5.
- Maximum frequency: 5500.
- Window length: 0.025.
- Pre-emphasis from: 50.

F0 tracks were obtained with the `ksvF0` function from wrassp.

## Annotation correction

The automatic segmentation by BAS was manually corrected by the researchers, as follows:

- Words: all segments were corrected.
- Sentences: only word boundaries were corrected.
- Story: nothing was corrected.

The formant tracks were corrected in the words.
