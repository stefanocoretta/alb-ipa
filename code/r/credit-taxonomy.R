# CRediT taxonomy

library(tidyverse)

credit <- read_csv(here::here("./data/varia/credit-taxonomy.csv")) %>%
  pivot_longer(SC:SN, names_to = "author", values_to = "value") %>%
  mutate(
    author = factor(author, levels = c("SC", "JRC", "EK", "SN")),
    value = ifelse(is.na(value), 0.2, value)
  )

credit_plot <- credit %>%
  ggplot(aes(author, Roles)) +
  geom_point(aes(alpha = value)) +
  scale_y_discrete(limits = rev) +
  scale_x_discrete(position = "top") +
  theme_light() +
  theme(legend.position = "none")

ggsave(here::here("./img/credit-taxonomy.png"), credit_plot, width = 5, height = 5)
