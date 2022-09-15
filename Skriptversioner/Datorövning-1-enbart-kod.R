install.packages("tidyverse")

library(tidyverse)

a <- 5

b <- c(3, 1, 4, 1, 5, 9)

sum(b)

plot(b)

sqrt(b)

b <- c(3, 1, 4, 1, 5, 9, NA)           # Lägger till ett saknat värde
sum(b)                                 # na.rm = FALSE är grundinställning
sum(b, na.rm = TRUE)                   # na.rm sätts till TRUE

c <- c(-4, -2, -1, 1, 2, 4)            # Skapa en vektor av värden
c_absolute <- abs(c)                   # Ta absolutvärden. Spara som c_absolut
sum(c_absolute)                        # Summera värden i c_absolut

sum(abs(c(-4, -2, -1, 1, 2, 4)))       # Ta summan av absolutvärden av vektorn

sqrt(sum(new_vector^2))                # Ta roten ur summan av vektorn i kvadrat

library(tidyverse)                     # Ladda tidyverse, ej nödvändigt om redan gjort

c(-4, -2, -1, 1, 2, 4) %>%             # Skapa en datamängd och sen
  abs() %>%                            # ta absolutvärden, och sen
  sum()                                # beräkna summan.

dat <- data.frame(Vecka = c(7,7,7,7,7,7,11,11,11,11,11,11),
                  Behandling = c("A","A","A","B","B","B","A","A","A","B","B","B"),
                  Vikt = c(232,161,148,368,218,257,1633,2213,972,2560,2430,855),
                  N = c(2.63,2.90,2.99,3.54,3.30,2.85,1.53,1.90,NA,2.58,NA,NA))
dat

dat <- read_csv("https://raw.githubusercontent.com/adamflr/ST0060-2022/main/Data/Spotify_data.csv") 
                                       # Läs in en csv-fil från Github
dat                                    # Skriv ut objektet dat

unique(dat$artist_name)                # Skriv ut unika värden i kolumnen artist_name i dat

dat %>%                                # Ta spotify-datan och sen
  filter(artist_name == "Robyn")       # filtrera för en specifik artist

dat %>%                                                              # Ta datan, och sen
  filter(artist_name %in% c("Robyn", "Esperanza Spalding"))          # filtrera för specifika artister

dat %>%                                                              # Ta datan, och sen
  filter(artist_name %in% c("Robyn", "Esperanza Spalding"),          # filtrera för specifika artister
         key_name == "D#")                                           # och för tonart

dat %>%                                                              # Ta datan, och sen
  filter(artist_name %in% c("Robyn", "Esperanza Spalding")) %>%      # filtrera för artister, och sen
  filter(key_name == "D#")                                           # filtrera för tonart

dat %>%                                                              # Ta datan, och sen
  filter(artist_name %in% c("Robyn", "Esperanza Spalding")) %>%      # filtrera för artister, och sen
  filter(key_name == "D#")  %>%                                      # filtrera för tonart, och sen
  print(n = 5)                                                       # skriv ut de fem första raderna

dat %>%                                # Ta datan, och sen
  select(artist_name, album_name)      # välj kolumnerna artist_name och album_name

dat %>%                                                    # Ta datan och sen
  filter(album_release_year == 2015,                       # filtrera för rader där år är 2015, och 
         tempo > 180) %>%                                  # tempot över 160, och sen
  select(artist_name, album_release_year, track_name)      # selektera på artist, år och spår

dat <- dat %>%                                             # Ta datan, och sen
  mutate(beats_per_second = tempo / 60)                    # Beräkna en ny kolumn som tempo delat på 60

dat %>% select(tempo, beats_per_second)                    # Ta datan och sen välj två kolumner

dat %>% 
  mutate(`Val to dan` = valence / danceability) %>%        # Namnet Val to dan skrivs inom backticks
  select(artist_name, `Val to dan`)

dat %>%                                          # Ta datan, och sen
  group_by(album_release_year) %>%               # gruppera efter år, och sen
  summarise(Medeltempo = mean(tempo))            # beräkna medelvärde av tempo

dat %>%                                          # Ta datan, och sen
  group_by(album_release_year) %>%               # gruppera efter år, och sen
  summarise(Medeltempo = mean(tempo),            # beräkna medelvärde av tempo
            Medelvalence = mean(valence),        # beräkna medelvärde av valence
            antal_spår = n()) %>%                # beräkna antalet spår, och sen
  arrange(-Medelvalence)                         # ordna efter medelvalence i sjunkande ordning

dat_small <- dat %>%                                      # Ta data, och sen
  filter(artist_name == "Robyn", album_type == "album")   # filtrera på artist och albumtyp

plot(x = dat_small$tempo, y = dat_small$danceability)   # Plotta en graf med tempo och dansbarhet på axlarna

ggplot(dat_small, aes(x = tempo, y = danceability)) +  # Ta datan, koppla tempo och dansbarhet till x och y
  geom_point()                                         # och illustrera varje observation med punkt

ggplot(dat_small, aes(x = tempo, y = danceability, color = mode_name)) +   # Ta datan, koppla tempo, dansbarhet och tonart till axlarna respektive färg
  geom_point() +                                                           # Illustrera med punkter
  facet_wrap(~ album_name)                                                 # Skapa småfönster efter album

dat_mean_over_time <- dat %>%                         # Ta datan, och sen
  group_by(album_release_year, explicit) %>%          # gruppera efter år och explicitet, och sen
  summarise(Mean_danceability = mean(danceability))   # summera genom att ta medelvärdet av dansbarhet

ggplot(dat_mean_over_time, aes(x = album_release_year, y = Mean_danceability, color = explicit)) + 
                                                      # Koppla kolumner till egenskaper
  geom_line() +                                       # Illustrera med linjer
  geom_point()                                        # Illustrera med punkter

dat %>%                                                                  # Ta datan, och sen
  group_by(artist_name) %>%                                              # gruppera efter artist, och sen
  summarise(Mean_valence = mean(valence)) %>%                            # ta medelvärdet av valence, och sen
  arrange(-Mean_valence) %>%                                             # ordna efter medelvalens (minustecken för sjunkande ordning), och sen
  slice(1:20) %>%                                                        # ta ut de tjugo första raderna
  ggplot(aes(x = Mean_valence, y = artist_name, fill = Mean_valence)) +  # starta en ggplot där x-axeln ges av valens och y-axeln av artist, och sen
  geom_col(color = "black")                                              # skapa en geometri av kolumner

dat_small <- dat %>%                                            # Ta datan, och sen
  filter(artist_name == "Beach House", album_type == "album")   # filtrera på artist och albumtyp

ggplot(dat_small, aes(x = danceability, y = album_name)) +      # Ta data och koppla dansbarhet och album till axlarna
  geom_boxplot()                                                # Illustrera med lådagram


ggplot(dat_small, aes(danceability, album_name)) +
  geom_boxplot(fill = "lightblue") +                                         # Fyll lådagrammen med en färg
  theme(panel.background = element_rect(fill = "red3"),                      # Sätt grafenfönstrets bakgrund
        text = element_text(size = 15, color = "white", family = "serif"),   # Sätt textens storlek och snitt
        axis.text = element_text(color = "white"),                           # Sätt axel-textens färg
        plot.background = element_rect(fill = "grey30", color = "black"),    # Sätt grafens bakgrund
        panel.grid.major.y = element_blank())                                # Sätt rutnätet till blankt

# install.packages("plotly")                     # Installera plotly (ej nödvändigt om redan installerat)
library(plotly)                                  # Ladda plotly

dat_small <- dat %>%                                                 # Ta datan, och sen
  filter(artist_name == "David Bowie", album_type == "album") %>%    # filtrera på artist och albumtyp, och sen
  mutate(Decade = floor(album_release_year / 10) * 10)               # skapa en variable för årtionde.

g <- ggplot(dat_small, aes(danceability, valence, color = album_name, text = track_name)) +
  geom_point() +
  facet_wrap(~ Decade) +            # Skapa småfönster per årtionde
  theme(legend.position = "none")   # Ta bort legenden (kopplingen mellan färg och album)
g

ggplotly(g)

# Läs in data från fil
dat_temp <- read_csv("https://raw.githubusercontent.com/adamflr/ST0060-2022/main/Data/Temperatur%2C%20Stockholm.csv")

ggplot(dat_temp, aes(x = Year, y = 1, fill = Value)) +
  geom_col() 

