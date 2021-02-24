IPA illustration of Northern Tosk
================

This is the GitHub repository of the project *IPA illustration of
Northern Tosk*.

## Directory structure

-   `docs/`: contains project documentation.
    -   The file `procedure.md` documents data acquisition and
        processing in detail.
-   `code/`: contains code for data (pre-)processing, organised in the
    following sub-directories.
    -   `config/`: configuration script for setting up the EMU-SDMS
        database.
    -   `praat/`: Praat scripts for data-preprocessing.
    -   `r/`: R scripts for data transformation, wrangling, and
        plotting.
-   `data/`: contains different sources of data. This folder is tracked
    with `dvc`.
    -   `metadata/`: metadata files.
    -   `stimuli/`: contains the list of words (`word-list.txt`) and
        randomised versions of this list (`rand-1:6.txt`).
    -   `recordings/`: raw and derived recordings, used for
        forced-alignment and acoustic analysis.
        -   `raw/`: raw (original) `.wav` recordings with accompanying
            `.TextGrids` used for chunking the recordings into separate
            parts.
        -   `derived/`
            -   `align/`: files generated by the forced-alignment
                procedure.
            -   `post-align/`: post-alignment files, imported into the
                EMU database `alb-ipa_emuDB/`. To avoid data
                duplication, this folder is not version-controlled, so
                it doesn’t ship with this repository.
            -   `illustr/`: illustrative recordings of `consonants/`,
                `vowels/`, `intonation/`, and *The North Wind and the
                Sun*.
    -   `alb-ipa_emuDB/`: EMU-SDMS database.
    -   `ultrasound/`: spline data from ultrasound tongue imaging.
    -   `varia/`: a miscellanea folder with files used with different
        services.
-   `img/`: figures generated by `code/prepare_plots.Rmd`.
-   `renv/`: R package library managed by the renv package.

## Data collection and processing

Data collection and processing are documented in `docs/procedure.md`.

## Directory tree

    ## .
    ## ├── code
    ## │   ├── config
    ## │   ├── praat
    ## │   └── r
    ## ├── data
    ## │   ├── alb-ipa_emuDB
    ## │   │   ├── s01_ses
    ## │   │   ├── s02_ses
    ## │   │   ├── s04_ses
    ## │   │   ├── s05_ses
    ## │   │   └── s06_ses
    ## │   ├── dataframes
    ## │   ├── metadata
    ## │   ├── recordings
    ## │   │   ├── derived
    ## │   │   └── raw
    ## │   ├── stimuli
    ## │   ├── ultrasound
    ## │   └── varia
    ## │       ├── qgj-example
    ## │       └── vot-example
    ## ├── docs
    ## ├── img
    ## │   ├── acoustics
    ## │   ├── articulation
    ## │   └── ipa-vchart
    ## └── renv
    ##     └── library
    ##         └── R-4.0
