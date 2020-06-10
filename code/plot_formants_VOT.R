# libraries ----
library(tidyr)
library(ggplot2)
library(plyr)


# attach databases ----
path = "./data/dataframes"
attach(file.path(path, "alb-ipa_dataframe_vot"))
vot = vot
attach(file.path(path, "alb-ipa_dataframe_formants"))
formants = formants


# formant plots ----
formants$vowel <- factor(formants$vowel, levels = c("i", "y", "u", "e", "@", "o", "a"))

# all speakers together
ggplot(formants, aes(x=F2, y=F1, col=vowel)) +
  scale_x_reverse(name="F2 (Hz)") + 
  scale_y_reverse(name="F1 (Hz)") +
  geom_text(aes(label=vowel), show.legend=FALSE) +
  stat_ellipse(type="t", size=1) +
  theme_bw()

# male speakers only
ggplot(subset(formants, gender="M"), aes(x=F2, y=F1, col=vowel)) +
  scale_x_reverse(name="F2 (Hz)") + 
  scale_y_reverse(name="F1 (Hz)") +
  geom_text(aes(label=vowel), show.legend=FALSE) +
  stat_ellipse(type="t", size=1) +
  theme_bw()

# female speakers only
ggplot(subset(formants, gender="F"), aes(x=F2, y=F1, col=vowel)) +
  scale_x_reverse(name="F2 (Hz)") + 
  scale_y_reverse(name="F1 (Hz)") +
  geom_text(aes(label=vowel), show.legend=FALSE) +
  stat_ellipse(type="t", size=1) +
  theme_bw()

# male-female side by side
ggplot(formants, aes(x=F2, y=F1, col=vowel)) +
  facet_wrap(~gender) +
  scale_x_reverse(name="F2 (Hz)") + 
  scale_y_reverse(name="F1 (Hz)") +
  geom_text(aes(label=vowel), show.legend=FALSE) +
  stat_ellipse(type="t", size=1) +
  theme_bw()

# individual speakers side by side
ggplot(formants, aes(x=F2, y=F1, col=vowel)) +
  facet_wrap(~speaker) +
  scale_x_reverse(name="F2 (Hz)") + 
  scale_y_reverse(name="F1 (Hz)") +
  geom_text(aes(label=vowel), show.legend=FALSE) +
  theme_bw()



# VOT plot ----
vot$consonant <- factor(vot$consonant, levels = c("g", "d", "b", "k", "t", "p"))

ggplot(vot, aes(x=VOT, y=consonant)) +
  stat_summary(fun = mean, geom = "bar") +
  stat_summary(fun.data = mean_se, geom = "errorbar", color="red")
