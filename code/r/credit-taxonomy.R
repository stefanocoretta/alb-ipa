# CRediT taxonomy

library(tidyverse)

credit <- read_csv(here::here("./data/varia/credit-taxonomy.csv")) %>%
  pivot_longer(SC:SN, names_to = "author", values_to = "value") %>%
  mutate(
    author = factor(author, levels = c("SC", "JRC", "EK", "SN")),
    value = ifelse(is.na(value), 0.2, value)
  )

credit %>%
  ggplot(aes(author, Roles)) +
  geom_point(aes(alpha = value)) +
  scale_y_discrete(limits = rev) +
  scale_x_discrete(position = "top") +
  labs(
    x = element_blank(), y = element_blank(),
    caption = "CRediT (Contributor Roles Taxonomy), http://credit.niso.org."
  ) +
  theme_light() +
  theme(legend.position = "none", text = element_text(size = 8))

ggsave(here::here("./img/credit-taxonomy.png"), width = 3, height = 3)
