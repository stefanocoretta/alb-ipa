# Data changelog

## 2021-02-06

## Added

- Use dvc to track data/.

### Removed

- git lfs has been removed and replaced with dvc.



## 2021-02-05

### Added

- CoG of affricates.

### Removed

- ⚠️ BREAKING CHANGES: `alb-ipa_emuDB` is now part of the `alb-ipa` repo and not a submodule. This means that the bundle assignments won't work anymore.




## 2020-10-19
### Added
- Spline data for vowels.

## 2020-10-01
### Added
- Spline data for laterals.

## 2020-09-15
### Fixed
- Voicing in /bari/ of S02.

## 2020-09-11
### Added
- dft and spectral moments.

## 2020-09-08
### Fixed
- Formants of /u/, /o/, /a/.

## 2020-09-08
### Fixed
- Formants of /u/ in speaker s06.

## 2020-08-03
### Added
- Added `alb-ipa-int` emuBD for the intonation plot.
- Created and annotated `SYL` level in `alb-ipa-int`.

## 2020-04-23
### Added
- Added `RELS` and `VOI` levels.

## 2020-04-15
### Fixed
- MAUS segmentation in s05 was not good and the extracted chunks cut off parts of words. The segmentation was manually fixed and the corrected chunks were reimported into the EMU database (#69e5f39).

## 2020-03-06
### Fixed
- The `data/recordings/derived/align/s01/words.TextGrid` included the old word list (force-alignment in MAUS was done with the wrong `words.txt` file). This TextGrid and the text file have been manually fixed to include the correct list. All other files with the word list for s01 were correct.

### Added
- The TextGrid collection in `data/recordings/derived/post-align/` has been converted to an EMU database (`data/alb-ipa_emuDB`). The `data/alb-ipa_emuDB` is a git submodule.
