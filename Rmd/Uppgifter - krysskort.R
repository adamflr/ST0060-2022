library(tidyverse)
tab <- expand_grid(Question = 1:30 + rep(1:6, each = 5),
                   Exercise = seq(1, 4, length.out = 8)) %>% 
  group_by(Exercise) %>% 
  mutate(Rank = rank(Question),
         Type = ifelse(Rank %in% 1:20, "Sal", 
                       ifelse(Rank %in% 21:25, "Bonus", "Hemuppgift")))

ggplot(tab, aes(Question, Exercise, color = Type)) +
  geom_point(shape = 21, size = 10) +
  # geom_vline(xintercept = seq(5.5, 30.5, 5)) +
  annotate("text", x = 0, y = rev(unique(tab$Exercise)), label = paste("Datorövning", 1:length(unique(tab$Exercise))), hjust = 1, family = "serif") +
  annotate("text", x = c(25.5, 31.5), y = max(tab$Exercise) + 0.5, label = c("Bonus", "Hem"), family = "serif", hjust = 0) +
  cowplot::theme_nothing() +
  xlim(-4,43)
