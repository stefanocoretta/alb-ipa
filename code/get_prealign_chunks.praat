######################################
# This is a script from the project 'An IPA illustration of Albanian'.
#
# The script creates pre-alignment chunks (.wav files) to be used for
# force-alignment in webMAUS. The chunks are saved in
# data/recordings/derived/align/<ID>/ where <ID> is the speaker ID in the form
# of "s01".
######################################
# MIT License
#
# Copyright (c) 2020 Stefano Coretta
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
######################################

raw_dir$ = "../data/recordings/raw"
align_dir$ = "../data/recordings/derived/align"
Create Strings as file list: "file_list", "'raw_dir$'/*_mono.TextGrid"
files = Get number of strings

for file from 1 to files
  selectObject: "Strings file_list"
  file$ = Get string: file
  Read from file: "'raw_dir$'/'file$'"
  tg = selected("TextGrid")
  base_name$ = file$ - ".TextGrid"
  subj_id$ = mid$(base_name$, 9, 1)

  dir_exists = fileReadable("'align_dir$'/s0'subj_id$'")

  if dir_exists == 0
    subj_dir$ = "'align_dir$'/s0'subj_id$'"
    createDirectory(subj_dir$)
    Read from file: "'raw_dir$'/'base_name$'.wav"
    wav = selected("Sound")

    selectObject: tg
    # Tier 2 contains the intervals to be silenced
    silence_intervals = Get number of intervals: 2
    for interval from 1 to silence_intervals
      selectObject: tg
      label$ = Get label of interval: 2, interval
      if label$ == "silence"
        start = Get start time of interval: 2, interval
        end = Get end time of interval: 2, interval
        selectObject: wav
        Set part to zero: start, end, "at nearest zero crossing"
      endif
    endfor

    selectObject: tg, wav
    # Tier 1 contains the intervals with the types (words, sentences, story)
    Extract intervals where: 1, "no", "is equal to", "words"
    words = Concatenate
    Save as WAV file: "'subj_dir$'/words.wav"

    selectObject: tg, wav
    Extract intervals where: 1, "no", "is equal to", "sentences"
    sentences = Concatenate
    Save as WAV file: "'subj_dir$'/sentences.wav"

    selectObject: tg, wav
    Extract intervals where: 1, "no", "is equal to", "story"
    story = Concatenate
    Save as WAV file: "'subj_dir$'/story.wav"
  endif

endfor
