install.packages("tidyverse")

library(tidyverse)

a <- 5

b <- c(3, 1, 4, 1, 5, 9)

sum(b)

plot(b)

sqrt(b)

b <- c(3, 1, 4, 1, 5, 9, NA)
sum(b)
sum(b, na.rm = TRUE)

c <- c(-4, -2, -1, 1, 2, 4)
c_absolute <- abs(c)
sum(c_absolute)

sum(abs(c(-4, -2, -1, 1, 2, 4)))

sqrt(sum(new_vector^2))

library(tidyverse)

c(-4, -2, -1, 1, 2, 4) %>%
  abs() %>%
  sum()

dat <- data.frame(Vecka = c(7,7,7,7,7,7,11,11,11,11,11,11),
                  Behandling = c("A","A","A","B","B","B","A","A","A","B","B","B"),
                  Vikt = c(232,161,148,368,218,257,1633,2213,972,2560,2430,855),
                  N = c(2.63,2.90,2.99,3.54,3.30,2.85,1.53,1.90,NA,2.58,NA,NA))
dat

dat <- read_csv("https://raw.githubusercontent.com/adamflr/ST0060-2022/main/Data/Spotify_data.csv")

dat

unique(dat$artist_name)

dat %>%
  filter(artist_name == "Robyn")

dat %>%
  filter(artist_name %in% c("Robyn", "Esperanza Spalding"))

dat %>%
  filter(artist_name %in% c("Robyn", "Esperanza Spalding"),
         key_name == "D#")

dat %>%
  filter(artist_name %in% c("Robyn", "Esperanza Spalding")) %>%
  filter(key_name == "D#")

dat %>%
  filter(artist_name %in% c("Robyn", "Esperanza Spalding")) %>%
  filter(key_name == "D#")  %>%
  print(n = 5)

dat %>%
  select(artist_name, album_name)

dat %>%
  filter(album_release_year == 2015,
         tempo > 180) %>%
  select(artist_name, album_release_year, track_name)

dat <- dat %>%
  mutate(beats_per_second = tempo / 60)

dat %>% select(tempo, beats_per_second)

dat %>%
  mutate(`Val to dan` = valence / danceability) %>%
  select(artist_name, `Val to dan`)

dat %>%
  group_by(album_release_year) %>%
  summarise(Medeltempo = mean(tempo))

dat %>%
  group_by(album_release_year) %>%
  summarise(Medeltempo = mean(tempo),
            Medelvalence = mean(valence),
            antal_spår = n()) %>%
  arrange(-Medelvalence)

dat_small <- dat %>%
  filter(artist_name == "Robyn", album_type == "album")

plot(x = dat_small$tempo, y = dat_small$danceability)

ggplot(dat_small, aes(x = tempo, y = danceability)) +
  geom_point()

ggplot(dat_small, aes(x = tempo, y = danceability, color = mode_name)) +
  geom_point() +
  facet_wrap(~ album_name)

dat_mean_over_time <- dat %>%
  group_by(album_release_year, explicit) %>%
  summarise(Mean_danceability = mean(danceability))

ggplot(dat_mean_over_time, aes(x = album_release_year, y = Mean_danceability, color = explicit)) +

  geom_line() +
  geom_point()

dat %>%
  group_by(artist_name) %>%
  summarise(Mean_valence = mean(valence)) %>%
  arrange(-Mean_valence) %>%
  slice(1:20) %>%
  ggplot(aes(x = Mean_valence, y = artist_name, fill = Mean_valence)) +
  geom_col(color = "black")

dat_small <- dat %>%
  filter(artist_name == "Beach House", album_type == "album")

ggplot(dat_small, aes(x = danceability, y = album_name)) +
  geom_boxplot()


ggplot(dat_small, aes(danceability, album_name)) +
  geom_boxplot(fill = "lightblue") +
  theme(panel.background = element_rect(fill = "red3"),
        text = element_text(size = 15, color = "white", family = "serif"),
        axis.text = element_text(color = "white"),
        plot.background = element_rect(fill = "grey30", color = "black"),
        panel.grid.major.y = element_blank())

# install.packages("plotly")
library(plotly)

dat_small <- dat %>%
  filter(artist_name == "David Bowie", album_type == "album") %>%
  mutate(Decade = floor(album_release_year / 10) * 10)

g <- ggplot(dat_small, aes(danceability, valence, color = album_name, text = track_name)) +
  geom_point() +
  facet_wrap(~ Decade) +
  theme(legend.position = "none")
g

ggplotly(g)


dat_temp <- read_csv("https://raw.githubusercontent.com/adamflr/ST0060-2022/main/Data/Temperatur%2C%20Stockholm.csv")

ggplot(dat_temp, aes(x = Year, y = 1, fill = Value)) +
  geom_col()

