align_dir$ = "../../data/recordings/derived/align"

sesh = Create Strings as folder list: "sesh", align_dir$
sesh_no = Get number of strings

out_file$ = "../../data/metadata/alignment.csv"
header$ = "speaker,bundle,label,start_time,bundle_start"
writeFileLine: out_file$, header$

for i from 1 to sesh_no
  selectObject: "Strings sesh"
  sesh$ = Get string: i

  tg = Read from file: "'align_dir$'/'sesh$'/words.TextGrid"
  phon_no = Get number of intervals: 3

  for ph from 1 to phon_no
    ph_lab$ = Get label of interval: 3, ph

    if ph_lab$ != "<p:>"
      ph_start = Get start time of interval: 3, ph

      bundle = Get interval at time: 1, ph_start
      bundle$ = Get label of interval: 1, bundle
      bundle_start = Get start time of interval: 1, bundle

      line$ = "'sesh$','bundle$','ph_lab$','ph_start','bundle_start'"
      appendFileLine: out_file$, line$
    endif
  endfor

endfor

