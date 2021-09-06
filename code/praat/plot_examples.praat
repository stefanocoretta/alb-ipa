wav_dir$ = "../../data/recordings/derived/examples/s04"
img_dir$ = "../../img/examples"

#####################################################################
# VOT: /pata, kati/

pata = Read from file: "'wav_dir$'/018-pata.wav"
pata_tg = Read from file: "'wav_dir$'/018-pata.TextGrid"
kati = Read from file: "'wav_dir$'/036-kati.wav"
kati_tg = Read from file: "'wav_dir$'/036-kati.TextGrid"

selectObject: pata_tg
pata_start = Get start time of interval: 1, 2
pata_end = Get end time of interval: 1, 2
pata_part_tg = Extract part: pata_start - 0.1, pata_end + 0.05, "no"
Remove tier: 2
Remove tier: 5
Remove tier: 5
Remove tier: 5

selectObject: pata
pata_fin = Get end time
Set part to zero: 0, pata_start, "at nearest zero crossing"
Set part to zero: pata_end, pata_fin, "at nearest zero crossing"
pata_part = Extract part: pata_start - 0.1, pata_end + 0.05, "rectangular", 1, "no"

selectObject: kati_tg
kati_start = Get start time of interval: 1, 2
kati_end = Get end time of interval: 1, 2
kati_part_tg = Extract part: kati_start - 0.05, kati_end + 0.1, "no"
Remove tier: 2
Remove tier: 5
Remove tier: 5
Remove tier: 5

selectObject: kati
kati_fin = Get end time
Set part to zero: 0, kati_start, "at nearest zero crossing"
Set part to zero: kati_end, kati_fin, "at nearest zero crossing"
kati_part = Extract part: kati_start - 0.05, kati_end + 0.1, "rectangular", 1, "no"

selectObject: pata_part
plusObject: kati_part
pata_kati = Concatenate
pata_kati_end = Get end time
pata_kati_sp = To Spectrogram: 0.005, 5000, 0.002, 20, "Gaussian"

selectObject: pata_part_tg
plusObject: kati_part_tg
pata_kati_tg = Concatenate
Replace interval texts: 2, 1, 0, "<p:>", "", "literals"
Remove right boundary: 1, 3
Remove right boundary: 2, 6

Erase all

start = 0
end = pata_kati_end
width = 7

selectObject: pata_kati_tg
tg_tiers = Get number of tiers
tg_extent = 3 + 0.5 * (tg_tiers)

12
Helvetica

Select inner viewport: 1, width, 1.5, 3
selectObject: pata_kati_sp
Paint: start, end, 0, 0, 100, "yes", 45, 6, 0, "no"
Draw inner box

Select inner viewport: 1, width, 1, tg_extent
selectObject: pata_kati_tg
Draw: start, end, "yes", "yes", "no"

Select inner viewport: 1, width, 1, 1.5
selectObject: pata_kati
Draw: start, end, 0, 0, "no", "Curve"

Select inner viewport: 1, width, 1.5, 3
Axes: start, end, 0, 5000
Marks left: 2, "yes", "yes", "no"
Text left: "no", "Freq. (Hz)"

Select inner viewport: 1, width, 1, tg_extent
Draw inner box
Marks bottom every: 1, 0.25, "yes", "yes", "no"
Text bottom: "yes", "Time (s)"

Select outer viewport: 0.5, width + 0.5, 0.75, tg_extent + 0.5
Save as 600-dpi PNG file: "'img_dir$'/p-k.png"

#####################################################################
# Laminal affricates: /qava, gjaku/

qava = Read from file: "'wav_dir$'/038-qava.wav"
qava_tg = Read from file: "'wav_dir$'/038-qava.TextGrid"
gjaku = Read from file: "'wav_dir$'/002-gjaku.wav"
gjaku_tg = Read from file: "'wav_dir$'/002-gjaku.TextGrid"

selectObject: qava_tg
qava_start = Get start time of interval: 1, 2
qava_end = Get end time of interval: 1, 2
qava_part_tg = Extract part: qava_start - 0.1, qava_end + 0.05, "no"
Remove tier: 2
Remove tier: 3
Remove tier: 3
Remove tier: 3
Remove tier: 3
Remove tier: 3

selectObject: qava
qava_fin = Get end time
Set part to zero: 0, qava_start, "at nearest zero crossing"
Set part to zero: qava_end, qava_fin, "at nearest zero crossing"
qava_part = Extract part: qava_start - 0.1, qava_end + 0.05, "rectangular", 1, "no"

selectObject: gjaku_tg
gjaku_start = Get start time of interval: 1, 2
gjaku_end = Get end time of interval: 1, 2
gjaku_part_tg = Extract part: gjaku_start - 0.05, gjaku_end + 0.1, "no"
Remove tier: 2
Remove tier: 3
Remove tier: 3
Remove tier: 3
Remove tier: 3
Remove tier: 3

selectObject: gjaku
gjaku_fin = Get end time
Set part to zero: 0, gjaku_start, "at nearest zero crossing"
Set part to zero: gjaku_end, gjaku_fin, "at nearest zero crossing"
gjaku_part = Extract part: gjaku_start - 0.05, gjaku_end + 0.1, "rectangular", 1, "no"

selectObject: qava_part
plusObject: gjaku_part
qava_gjaku = Concatenate
qava_gjaku_end = Get end time
qava_gjaku_sp = To Spectrogram: 0.005, 5000, 0.002, 20, "Gaussian"

selectObject: qava_part_tg
plusObject: gjaku_part_tg
qava_gjaku_tg = Concatenate
Replace interval texts: 2, 1, 0, "<p:>", "", "literals"
Remove right boundary: 1, 3
Remove right boundary: 2, 6
Set interval text: 2, 2, "t̻ʃ̻"
Set interval text: 2, 7, "d̻ʒ̻"

Erase all

start = 0
end = qava_gjaku_end
width = 7

selectObject: qava_gjaku_tg
tg_tiers = Get number of tiers
tg_extent = 3 + 0.5 * (tg_tiers)

12
Helvetica

Select inner viewport: 1, width, 1.5, 3
selectObject: qava_gjaku_sp
Paint: start, end, 0, 0, 100, "yes", 45, 6, 0, "no"
Draw inner box

Select inner viewport: 1, width, 1, tg_extent
selectObject: qava_gjaku_tg
Draw: start, end, "yes", "yes", "no"

Select inner viewport: 1, width, 1, 1.5
selectObject: qava_gjaku
Draw: start, end, 0, 0, "no", "Curve"

Select inner viewport: 1, width, 1.5, 3
Axes: start, end, 0, 5000
Marks left: 2, "yes", "yes", "no"
Text left: "no", "Freq. (Hz)"

Select inner viewport: 1, width, 1, tg_extent
Draw inner box
Marks bottom every: 1, 0.25, "yes", "yes", "no"
Text bottom: "yes", "Time (s)"

Select outer viewport: 0.5, width + 0.5, 0.75, tg_extent + 0.5
Save as 600-dpi PNG file: "'img_dir$'/q-gj.png"

#####################################################################
# Apical affricates: /caji, xhaja/

caji = Read from file: "'wav_dir$'/063-5aji.wav"
caji_tg = Read from file: "'wav_dir$'/063-5aji.TextGrid"
xhaja = Read from file: "'wav_dir$'/047-xhaja.wav"
xhaja_tg = Read from file: "'wav_dir$'/047-xhaja.TextGrid"

selectObject: caji_tg
caji_start = Get start time of interval: 1, 2
caji_end = Get end time of interval: 1, 2
caji_part_tg = Extract part: caji_start - 0.1, caji_end + 0.05, "no"
Remove tier: 2
Remove tier: 3
Remove tier: 3
Remove tier: 3
Remove tier: 3
Remove tier: 3

selectObject: caji
caji_fin = Get end time
Set part to zero: 0, caji_start, "at nearest zero crossing"
Set part to zero: caji_end, caji_fin, "at nearest zero crossing"
caji_part = Extract part: caji_start - 0.1, caji_end + 0.05, "rectangular", 1, "no"

selectObject: xhaja_tg
xhaja_start = Get start time of interval: 1, 2
xhaja_end = Get end time of interval: 1, 2
xhaja_part_tg = Extract part: xhaja_start - 0.05, xhaja_end + 0.1, "no"
Remove tier: 2
Remove tier: 3
Remove tier: 3
Remove tier: 3
Remove tier: 3
Remove tier: 3

selectObject: xhaja
xhaja_fin = Get end time
Set part to zero: 0, xhaja_start, "at nearest zero crossing"
Set part to zero: xhaja_end, xhaja_fin, "at nearest zero crossing"
xhaja_part = Extract part: xhaja_start - 0.05, xhaja_end + 0.1, "rectangular", 1, "no"

selectObject: caji_part
plusObject: xhaja_part
caji_xhaja = Concatenate
caji_xhaja_end = Get end time
caji_xhaja_sp = To Spectrogram: 0.005, 5000, 0.002, 20, "Gaussian"

selectObject: caji_part_tg
plusObject: xhaja_part_tg
caji_xhaja_tg = Concatenate
Replace interval texts: 2, 1, 0, "<p:>", "", "literals"
Remove right boundary: 1, 3
Remove right boundary: 2, 6
Set interval text: 2, 2, "tʃ"
Set interval text: 2, 7, "dʒ"

Erase all

start = 0
end = caji_xhaja_end
width = 7

selectObject: caji_xhaja_tg
tg_tiers = Get number of tiers
tg_extent = 3 + 0.5 * (tg_tiers)

12
Helvetica

Select inner viewport: 1, width, 1.5, 3
selectObject: caji_xhaja_sp
Paint: start, end, 0, 0, 100, "yes", 45, 6, 0, "no"
Draw inner box

Select inner viewport: 1, width, 1, tg_extent
selectObject: caji_xhaja_tg
Draw: start, end, "yes", "yes", "no"

Select inner viewport: 1, width, 1, 1.5
selectObject: caji_xhaja
Draw: start, end, 0, 0, "no", "Curve"

Select inner viewport: 1, width, 1.5, 3
Axes: start, end, 0, 5000
Marks left: 2, "yes", "yes", "no"
Text left: "no", "Freq. (Hz)"

Select inner viewport: 1, width, 1, tg_extent
Draw inner box
Marks bottom every: 1, 0.25, "yes", "yes", "no"
Text bottom: "yes", "Time (s)"

Select outer viewport: 0.5, width + 0.5, 0.75, tg_extent + 0.5
Save as 600-dpi PNG file: "'img_dir$'/cced-xh.png"

#####################################################################
# Alveolar affricates: /cica, xixa/

cica = Read from file: "'wav_dir$'/057-cica.wav"
cica_tg = Read from file: "'wav_dir$'/057-cica.TextGrid"
xixa = Read from file: "'wav_dir$'/054-xixa.wav"
xixa_tg = Read from file: "'wav_dir$'/054-xixa.TextGrid"

selectObject: cica_tg
cica_start = Get start time of interval: 1, 2
cica_end = Get end time of interval: 1, 2
cica_part_tg = Extract part: cica_start - 0.1, cica_end + 0.05, "no"
Remove tier: 2
Remove tier: 3
Remove tier: 3
Remove tier: 3
Remove tier: 3
Remove tier: 3

selectObject: cica
cica_fin = Get end time
Set part to zero: 0, cica_start, "at nearest zero crossing"
Set part to zero: cica_end, cica_fin, "at nearest zero crossing"
cica_part = Extract part: cica_start - 0.1, cica_end + 0.05, "rectangular", 1, "no"

selectObject: xixa_tg
xixa_start = Get start time of interval: 1, 2
xixa_end = Get end time of interval: 1, 2
xixa_part_tg = Extract part: xixa_start - 0.05, xixa_end + 0.1, "no"
Remove tier: 2
Remove tier: 3
Remove tier: 3
Remove tier: 3
Remove tier: 3
Remove tier: 3

selectObject: xixa
xixa_fin = Get end time
Set part to zero: 0, xixa_start, "at nearest zero crossing"
Set part to zero: xixa_end, xixa_fin, "at nearest zero crossing"
xixa_part = Extract part: xixa_start - 0.05, xixa_end + 0.1, "rectangular", 1, "no"

selectObject: cica_part
plusObject: xixa_part
cica_xixa = Concatenate
cica_xixa_end = Get end time
cica_xixa_sp = To Spectrogram: 0.005, 5000, 0.002, 20, "Gaussian"

selectObject: cica_part_tg
plusObject: xixa_part_tg
cica_xixa_tg = Concatenate
Replace interval texts: 2, 1, 0, "<p:>", "", "literals"
Remove right boundary: 1, 3
Remove right boundary: 2, 6
Set interval text: 2, 2, "ts"
Set interval text: 2, 7, "dz"

Erase all

start = 0
end = cica_xixa_end
width = 7

selectObject: cica_xixa_tg
tg_tiers = Get number of tiers
tg_extent = 3 + 0.5 * (tg_tiers)

12
Helvetica

Select inner viewport: 1, width, 1.5, 3
selectObject: cica_xixa_sp
Paint: start, end, 0, 0, 100, "yes", 45, 6, 0, "no"
Draw inner box

Select inner viewport: 1, width, 1, tg_extent
selectObject: cica_xixa_tg
Draw: start, end, "yes", "yes", "no"

Select inner viewport: 1, width, 1, 1.5
selectObject: cica_xixa
Draw: start, end, 0, 0, "no", "Curve"

Select inner viewport: 1, width, 1.5, 3
Axes: start, end, 0, 5000
Marks left: 2, "yes", "yes", "no"
Text left: "no", "Freq. (Hz)"

Select inner viewport: 1, width, 1, tg_extent
Draw inner box
Marks bottom every: 1, 0.25, "yes", "yes", "no"
Text bottom: "yes", "Time (s)"

Select outer viewport: 0.5, width + 0.5, 0.75, tg_extent + 0.5
Save as 600-dpi PNG file: "'img_dir$'/c-x.png"



#####################################################################
# Rhotics: rrapi, peri, perde

rrapi = Read from file: "'wav_dir$'/027-rrapi.wav"
rrapi_tg = Read from file: "'wav_dir$'/027-rrapi.TextGrid"
peri = Read from file: "'wav_dir$'/035-peri.wav"
peri_tg = Read from file: "'wav_dir$'/035-peri.TextGrid"
perde = Read from file: "'wav_dir$'/008-perde.wav"
perde_tg = Read from file: "'wav_dir$'/008-perde.TextGrid"

selectObject: rrapi_tg
rrapi_start = Get start time of interval: 1, 2
rrapi_end = Get end time of interval: 1, 2
rrapi_part_tg = Extract part: rrapi_start - 0.1, rrapi_end + 0.05, "no"
Remove tier: 2
Remove tier: 3
Remove tier: 3
Remove tier: 3
Remove tier: 3
Remove tier: 3

selectObject: rrapi
rrapi_fin = Get end time
Set part to zero: 0, rrapi_start, "at nearest zero crossing"
Set part to zero: rrapi_end, rrapi_fin, "at nearest zero crossing"
rrapi_part = Extract part: rrapi_start - 0.1, rrapi_end + 0.05, "rectangular", 1, "no"

selectObject: peri_tg
peri_start = Get start time of interval: 1, 2
peri_end = Get end time of interval: 1, 2
peri_part_tg = Extract part: peri_start - 0.05, peri_end + 0.1, "no"
Remove tier: 2
Remove tier: 3
Remove tier: 3
Remove tier: 3
Remove tier: 3
Remove tier: 3

selectObject: peri
peri_fin = Get end time
Set part to zero: 0, peri_start, "at nearest zero crossing"
Set part to zero: peri_end, peri_fin, "at nearest zero crossing"
peri_part = Extract part: peri_start - 0.05, peri_end + 0.1, "rectangular", 1, "no"

selectObject: perde_tg
perde_start = Get start time of interval: 1, 2
perde_end = Get end time of interval: 1, 2
perde_part_tg = Extract part: perde_start - 0.05, perde_end + 0.1, "no"
Remove tier: 2
Remove tier: 3
Remove tier: 3
Remove tier: 3
Remove tier: 3
Remove tier: 3

selectObject: perde
perde_fin = Get end time
Set part to zero: 0, perde_start, "at nearest zero crossing"
Set part to zero: perde_end, perde_fin, "at nearest zero crossing"
perde_part = Extract part: perde_start - 0.05, perde_end + 0.1, "rectangular", 1, "no"

selectObject: rrapi_part
plusObject: peri_part
plusObject: perde_part
rhotics = Concatenate
rhotics_end = Get end time
rhotics_sp = To Spectrogram: 0.005, 5000, 0.002, 20, "Gaussian"

selectObject: rrapi_part_tg
plusObject: peri_part_tg
plusObject: perde_part_tg
rhotics_tg = Concatenate
Replace interval texts: 2, 1, 0, "<p:>", "", "literals"
Remove right boundary: 1, 3
Remove right boundary: 1, 5
Remove right boundary: 2, 6
Remove right boundary: 2, 11
Set interval text: 2, 9, "ɾ"
Set interval text: 2, 14, "ɻ"

Erase all

start = 0
end = rhotics_end
width = 7

selectObject: rhotics_tg
tg_tiers = Get number of tiers
tg_extent = 3 + 0.5 * (tg_tiers)

12
Helvetica

Select inner viewport: 1, width, 1.5, 3
selectObject: rhotics_sp
Paint: start, end, 0, 0, 100, "yes", 50, 6, 0, "no"
Draw inner box

Select inner viewport: 1, width, 1, tg_extent
selectObject: rhotics_tg
Draw: start, end, "yes", "yes", "no"

Select inner viewport: 1, width, 1, 1.5
selectObject: rhotics
Draw: start, end, 0, 0, "no", "Curve"

Select inner viewport: 1, width, 1.5, 3
Axes: start, end, 0, 5000
Marks left: 2, "yes", "yes", "no"
Text left: "no", "Freq. (Hz)"

Select inner viewport: 1, width, 1, tg_extent
Draw inner box
Marks bottom every: 1, 0.25, "yes", "yes", "no"
Text bottom: "yes", "Time (s)"

Select outer viewport: 0.5, width + 0.5, 0.75, tg_extent + 0.5
Save as 600-dpi PNG file: "'img_dir$'/rho.png"
