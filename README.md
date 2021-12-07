IPA illustration of Northern Tosk Albanian
================

![](https://img.shields.io/badge/version-v2.0.9000-green.svg)
![](https://img.shields.io/badge/version-2021--12--07-blue.svg)
[![](https://img.shields.io/badge/doi-10.17605/OSF.IO/VRY3H-yellow.svg)](https://doi.org/10.17605/OSF.IO/VRY3H)

This is the GitHub repository of the project *IPA illustration of
Northern Tosk Albanian*. See the full **research compendium** at
<https://osf.io/vry3h/>.

## License

Data is released under CC-BY 4.0 International, code is released under
MIT License. See `LICENSE` file.

## Directory structure

-   `docs/`: contains project documentation.
    -   The file `procedure.md` documents data acquisition and
        processing in detail.
-   `code/`: contains code for data (pre-)processing, organised in the
    following sub-directories.
    -   `config/`: configuration script for setting up the EMU-SDMS
        database and the OFS repository.
    -   `praat/`: Praat scripts for data-preprocessing.
    -   `r/`: R scripts for data transformation, wrangling, and
        plotting.
-   `img/`: figures generated by `code/prepare_plots.Rmd`.
-   `renv/`: R package library managed by the renv R package.

## Data

The data of this project is version-controlled with
[dvc](https://dvc.org). A separate `dvc` repository—which is independent
from this `git` repository—holds the data, and the `data.dvc` file,
which is instead versioned by `git`, enables data transfer to and from
the `dvc` repository. Due to server limitations at the hosting
institution, we cannot grant access to the `dvc` repository, and we
instead make the data available as a `.zip` archive on the Open Science
Framework (<https://osf.io/u43sg/>).

The archive contains the directories of this GitHub repository and the
`data` directory with the project data. The `data` directory contains
the following sub-directories:

-   `metadata/`: metadata files.
-   `stimuli/`: contains the list of words (`word-list.txt`) and
    randomised versions of this list (`rand-1:6.txt`).
-   `recordings/`: raw and derived recordings, used for forced-alignment
    and acoustic analysis.
    -   `raw/`: raw (original) `.wav` recordings with accompanying
        `.TextGrids` used for chunking the recordings into separate
        parts.
    -   `derived/`
        -   `align/`: files generated by the forced-alignment procedure.
        -   `post-align/`: post-alignment files, imported into the EMU
            database `alb-ipa_emuDB/`. To avoid data duplication, this
            folder is not version-controlled, so it doesn’t ship with
            this repository.
        -   `illustr/`: illustrative recordings of `consonants/`,
            `vowels/`, `intonation/`, and *The North Wind and the Sun*.
        -   `examples/`: recordings for the figures with annotated
            waveform and spectrogram exemplifying VOT and frication.
-   `alb-ipa_emuDB/`: EMU-SDMS database.
-   `ultrasound/`: tongue contour spline data from ultrasound tongue
    imaging (UTI data on the OSF).
-   `varia/`: a miscellanea folder with files used with different
    services.

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
    ## │   ├── examples
    ## │   └── ipa-vchart
    ## └── renv
    ##     ├── library
    ##     │   └── R-4.1
    ##     └── staging
