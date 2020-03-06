######################################
# This is a script from the project 'An IPA illustration of Albanian'.
#
# The script creates post-alignment chunks (.wav files) to be used in EMU. The
# chunks are saved in data/recordings/derived/post-align/<ID>/ where <ID> is the
# speaker ID in the form of "s01".
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

align_dir$ = "../data/recordings/derived/align"
postalign_dir$ = "../data/recordings/derived/post-align"
Create Strings as directory list: "dir_list", "'align_dir$'/*"
speakers = Get number of strings

for speaker from 1 to speakers
  selectObject: "Strings dir_list"
  speaker$ = Get string: speaker

  # Words
  Read from file: "'align_dir$'/'speaker$'/words.wav"
  words = selected("Sound")
  Read from file: "'align_dir$'/'speaker$'/words.TextGrid"
  tg = selected("TextGrid")
  # Tier 1 in tg has spelling
  words_int = Get number of intervals: 1
  word_idx = 1

  for word from 1 to words_int
    selectObject: tg
    word$ = Get label of interval: 1, word

    if word$ <> ""
      w_start = Get start time of interval: 1, word
      w_end = Get end time of interval: 1, word

      # We need to beginning of interval `word-1` and the end of interval
      # `word+1` to extract a little extra of the sound around the word, since
      # the alingment is not correct.
      prev_start = Get start time of interval: 1, word - 1
      fol_end = Get end time of interval: 1, word + 1
      prev_half_dur = (w_start - prev_start) / 2
      fol_half_dur = (fol_end - w_end) / 2

      prev_half = prev_start + prev_half_dur
      fol_half = w_end + fol_half_dur

      selectObject: words
      words_part = Extract part: prev_half, fol_half, "rectangular", 1, "no"
      createDirectory: "'postalign_dir$'/'speaker$'/"
      @zeroFill: word_idx, 3
      word_safe$ = replace$(word$, "ë", "3", 0)
      word_safe$ = replace$(word_safe$, "ç", "5", 0)
      Save as WAV file: "'postalign_dir$'/'speaker$'/'zeroFill.return$'-'word_safe$'.wav"

      selectObject: tg
      tg_part = Extract part: prev_half, fol_half, "no"
      Save as text file: "'postalign_dir$'/'speaker$'/'zeroFill.return$'-'word_safe$'.TextGrid"

      removeObject: words_part, tg_part

      word_idx += 1
    endif

  endfor

  # Sentences
  Read from file: "'align_dir$'/'speaker$'/sentences.wav"
  sentences = selected("Sound")
  Read from file: "'align_dir$'/'speaker$'/sentences.TextGrid"
  tg = selected("TextGrid")
  # Tier 1 in tg has spelling
  sent_int = Get number of intervals: 1

  for sent from 1 to sent_int
    selectObject: tg
    sent$ = Get label of interval: 1, sent

    if sent$ <> ""
      s_start = Get start time of interval: 1, sent
      s_end = Get end time of interval: 1, sent

      selectObject: sentences
      sent_part = Extract part: s_start, s_end, "rectangular", 1, "no"
      createDirectory: "'postalign_dir$'/'speaker$'/"
      @zeroFill: word_idx, 3
      Save as WAV file: "'postalign_dir$'/'speaker$'/'zeroFill.return$'-'sent$'.wav"

      selectObject: tg
      tg_part = Extract part: s_start, s_start, "no"
      Save as text file: "'postalign_dir$'/'speaker$'/'zeroFill.return$'-'sent$'.TextGrid"

      removeObject: sent_part, tg_part

      word_idx += 1
    endif

  endfor

  # Story
  @zeroFill: word_idx, 3
  Read from file: "'align_dir$'/'speaker$'/sentences.wav"
  Save as WAV file: "'postalign_dir$'/'speaker$'/'zeroFill.return$'-story.wav"
  Read from file: "'align_dir$'/'speaker$'/sentences.TextGrid"
  Save as text file: "'postalign_dir$'/'speaker$'/'zeroFill.return$'-story.TextGrid"

endfor

# Procedure for zero padding, from http://praatscriptingtutorial.com/procedures
procedure zeroFill: .num, .numZeros

	.highestVal = 10 ^ .numZeros

	.num$ = string$: .num
	.numLen = length: .num$

	.numToAdd = .numZeros - .numLen

	.zeroPrefix$ = ""
	if .numToAdd > 0
		for .i from 1 to .numToAdd
			.zeroPrefix$ = .zeroPrefix$ + "0"
		endfor
	endif

	.return$ = .zeroPrefix$ + .num$

endproc
