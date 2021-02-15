library(tidyverse)
library(emuR)
library(data.tree)

db <- load_emuDB("./data/alb-ipa_emuDB/")
db_sql <- db$connection

units_tab <- tbl(db_sql, "items")
labels_tab <- tbl(db_sql, "labels")
links_tab <- tbl(db_sql, "links")

labels <- as_tibble(labels_tab)

links <- links_tab %>%
  select(-label) %>%
  as_tibble() %>%
  arrange(session, bundle, from_id) %>%
  left_join(y = labels %>% rename(from_id = item_id, from_label = label, from_name = name)) %>%
  left_join(y = labels %>% rename(to_id = item_id, to_label = label, to_name = name))
  pivot_wider()

non_final <- links %>%
  select(db_uuid:from_id) %>%
  group_by(db_uuid, session, bundle) %>%
  nest(froms = from_id) %>%
  mutate(from_id = map(from_id, function(.x) unique(.x$from_id)))

nodes <- links %>%
  left_join(y = non_final %>% rename(froms = from_id)) %>%
  mutate(node = ifelse(to_id %in% unlist(froms), FALSE, TRUE))

units_labs <- left_join(units_tab, labels_tab) %>%
  as_tibble() %>%
  arrange(session, bundle, item_id)

timed <- units_labs %>%
  filter(type != "ITEM") %>%
  left_join(y = links %>% rename(item_id = to_id)) %>%
  nest(to_id = item_id:label)

big_db <- units_labs %>%
  filter(type == "ITEM") %>%
  left_join(y = links %>% rename(item_id = from_id))
