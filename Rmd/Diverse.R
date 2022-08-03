a <- read_lines("Rmd/Datorövning-4.Rmd")
sum(grepl("exercise", a))

library(tidyverse)
dat <- read_csv("https://raw.githubusercontent.com/adamflr/ST0060-2022/main/Data/Allsvenskan%2C%20herrar%2C%201924-2020.csv")

dat %>% 
  filter(as.numeric(Säsong) > 1990) %>% 
  count(Hemmamål) %>% 
  mutate(p = n / sum(n),
         pois = dpois(Hemmamål, lambda = sum(p * Hemmamål))) %>% 
  ggplot(aes(Hemmamål, p)) +
  geom_point() +
  geom_line(aes(y = pois))

dat %>% 
  filter(as.numeric(Säsong) > 1990) %>% 
  count(Bortamål) %>% 
  mutate(p = n / sum(n),
         pois = dpois(Bortamål, lambda = sum(p * Bortamål))) %>% 
  ggplot(aes(Bortamål, p)) +
  geom_point() +
  geom_line(aes(y = pois))

dat2 <- dat %>% filter(as.numeric(Säsong) >= 1990)
write_csv(dat2, "Data/Allsvenskan, herrar, 1990-2020.csv")
