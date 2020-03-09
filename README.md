# Albanian IPA illustration

This is the research compendium of the project *Albanian IPA illustration*.

## Directory structure

- `data/`: contains different sources of data.
  - `recordings/`: raw and derived recordings, used for force-alignment and acoustic analysis.
    - `raw/`: raw (original) recordings and preparation TextGrids.
    - `derived/`
      - `align/`: force-alignment files.
      - `post-align/`: (*gitignored*) post-alignment files, imported as EMU database in `alb-ipa_emuDB/`.
  - `stimuli/`: text files with the word list and the randomised word lists.
  - `varia/`: a miscellania folder with files used with different services (for now, it only has the G2P mapping file used with MAUS).
  - `metadata/`: metadata folder.
  - `alb-ipa_emuDB/`: (*git submodule*) contains the emuDB.
- `code/`: contains code for data (pre-)processing.

## To do

- [ ] License file.
- [ ] `analysis/` for R analysis scripts.
