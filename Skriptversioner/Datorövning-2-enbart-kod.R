# install.packages("tidyverse")        # Installera tidyverse (behövs ej om redan gjort)
library(tidyverse)                     # Ger ett felmeddelande om paketet inte installerats

dat <- read_csv("https://raw.githubusercontent.com/adamflr/ST0060-2022/main/Data/Spotify_data.csv")
dat                                              # Skriv ut objektet dat

mean(dat$tempo, na.rm = T)                       # Beräkna medelvärdet av kolumnen tempo i datan dat

dat %>%                                                    # Ta datan, och sen
  filter(artist_name == "Tame Impala", tempo > 170) %>%    # ta ut rader där artisten är Tame Impala och tempot är större än 170, och sen
  select(artist_name, track_name, tempo)                   # ta ut kolumnerna artist_name, track_name och tempo

dat %>%                                                    # Ta datan, och sen
  group_by(artist_name) %>%                                # gruppera efter artist, och sen
  summarise(Antal_spår = n(),                              # beräkna antal spår,
            Medeltempo = mean(tempo),                      # medeltempo, och
            Maxdansbarhet = max(danceability))             # maximal dansbarhet

dat_small <- dat %>% filter(artist_name == "The Weeknd")                            # Skapa en mindre datamängd genom att filtrera på en artist

ggplot(dat_small, aes(tempo, danceability, size = valence, color = mode_name)) +    # Koppla grafegenskaper och variabler
  geom_point()                                                                      # Illustrera med punkter

library(readxl)                                                           # Ladda readxl

gapminder <- read_excel("C:/Users/User_name/Downloads/Gapminder.xlsx")    # Läs in från en lokal excelfil
gapminder                                                                 # Skriv ut objektet gapminder

getwd()                                # Ange working directory

gapminder <- read_excel("Data/Gapminder.xlsx")             # Läs in från en lokal excelfil (relativt wd)
gapminder                                                  # Skriv ut objektet gapminder

# install.packages("gapminder")        # Installera paketet gapminder (behövs ej om redan gjort)
library(gapminder)                     # Ladda gapminder
gapminder                              # Skriv ut objektet gapminder

ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, color = continent)) +    # Koppla grafens egenskaper till kolumner
  geom_point() +                                                               # Illustrera med punkter
  facet_wrap(~ year)                                                           # Skapa småfönster efter år

g <- ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, color = continent, text = country)) +
  geom_point() +
  facet_wrap(~ year)

# install.packages("plotly")
library(plotly)                        # Ladda paketet plotly
ggplotly(g)                            # Ta fram en interaktiv version av grafen g

gdpPercap <- gapminder$gdpPercap       # Skapa en vektor gdpPercap genom att ta ut kolumnen från gapminder
mean(gdpPercap)                        # Beräkna medelvärdet av gdpPercap
median(gdpPercap)                      # Beräkna medianen av gdpPercap

gapminder %>%                                    # Ta datan, och sen
  summarise(Mean = mean(gdpPercap),              # summera med medelvärdet av gdpPercap och
            Median = median(gdpPercap))          # med medianen av gdpPercap

gapminder %>%                                    # Ta datan, och sen
  group_by(year) %>%                             # gruppera efter år, och sen
  summarise(Mean = mean(gdpPercap),              # summera med medelvärdet av gdpPercap och
            Median = median(gdpPercap))          # med medianen av gdpPercap

dat_gdp_2007 <- gapminder %>%                    # Ta datan, och sen
  filter(year == 2007) %>%                       # filtrera för 2007, och sen
  group_by(continent) %>%                        # gruppera efter kontinent, och sen
  summarise(Mean = mean(gdpPercap))              # summera med medelvärdet av gdpPercap

ggplot(dat_gdp_2007, aes(continent, Mean)) +     # Skapa en ggplot med continent på x-axeln och Mean på y-axeln
  geom_col()                                     # Illustrera med kolumner (columns)

ggplot(dat_gdp_2007, aes(continent, Mean)) +
  geom_col() +
  geom_point(aes(continent, gdpPercap), data = gapminder %>% filter(year == 2007))

ggplot(dat_gdp_2007, aes(continent, Mean)) +
  geom_col() +
  geom_text(aes(continent, gdpPercap, label = country), data = gapminder %>% filter(year == 2007), size = 2)

gdpPercap <- gapminder$gdpPercap                 # Skapa en vektor gdpPercap genom att ta ut kolumnen från gapminder

var(gdpPercap)                                   # Beräkna variansen av gdpPercap
sd(gdpPercap)                                    # Beräkna standardavvikelsen av gdpPercap
IQR(gdpPercap)                                   # Beräkna kvartilavståndet av gdpPercap

gapminder %>%                                    # Ta datan, och sen
  summarise(Varians = var(gdpPercap),            # summera med varians,
            Standardavvikelse = sd(gdpPercap),   # standardavvikelse,
            Kvartilavstånd = IQR(gdpPercap))     # och kvartilavstånd

gapminder %>%                                    # Ta datan, och sen
  group_by(year) %>%                             # gruppera efter år, och sen
  summarise(Varians = var(gdpPercap),            # summera med varians,
            Standardavvikelse = sd(gdpPercap),   # standardavvikelse,
            Kvartilavstånd = IQR(gdpPercap))     # och kvartilavstånd

dat_sum <- gapminder %>%                         # Ta datan, och sen
  group_by(year, continent) %>%                  # grupper efter år och kontinent, och sen
  summarise(Mean = mean(gdpPercap),              # summera med medelvärde
            SE = sd(gdpPercap) / sqrt(n()))      # och medelfel (standardavvikelsen delat på roten ur n)
dat_sum

ggplot(dat_sum, aes(year, Mean, color = continent)) +      # Skapa en ggplot från datan dat_sum med year som x-axel, Mean som y-axel och färg efter kontinent
  geom_line() +                                            # Illustrera med linjer
  geom_errorbar(aes(ymin = Mean - SE, ymax = Mean + SE))   # Illustrera med felstaplar

dat_sum <- gapminder %>%                         # Ta datan, och sen
  filter(year == 2007) %>%                       # filtrera på år, och sen
  group_by(continent) %>%                        # gruppera efter kontinent, och sen
  summarise(Mean = mean(lifeExp),                # summera med medelvärde,
            SD = sd(lifeExp))                    # och standardavvikelse
dat_sum

ggplot(dat_sum, aes(continent, Mean, fill = continent)) +          # Skapa en ggplot med continent och Mean på axlarna och ifylld färg given av kontinent
  geom_col()+                                                      # Illustrera med kolumner
  geom_errorbar(aes(ymin = Mean - SD, ymax = Mean + SD)) +         # Illustrera med felstaplar
  labs(title = "Average life expectancy by continent, 2007",       # Ange titel och förklarande text
       caption = "Errorbars given by mean +/- standard deviation.
       Source: Gapminder")

ggplot(gapminder, aes(year, lifeExp, fill = continent, group = year)) +        # Skapa en ggplot med år och lifeExp på axlarna, kontinent som ifylld färg, och gruppera efter år
  geom_boxplot() +                                                             # Illustrera med lådagram
  facet_wrap(~ continent)                                                      # Småfönster efter kontinent

dat_sum <- gapminder %>%                         # Ta datan, och sen
  filter(year == 2007) %>%                       # filtrera på år, och sen
  group_by(continent) %>%                        # gruppera efter kontinent, och sen
  summarise(Mean = mean(lifeExp),                # summera med medelvärde,
            SD = sd(lifeExp))                    # och standardavvikelse
dat_sum

dat_sum %>% 
  mutate(mean_plus_minus_sd = paste(Mean, "±", SD))        # Skapa en ny kolumn genom att slå ihop Mean och SD

dat_sum <- dat_sum %>% 
  mutate(mean_plus_minus_sd = paste(round(Mean, 1), "±", round(SD, 1)))        # Skapa en ny kolumn med avrundade värden

getwd()                                                    # Se nuvarande working directory
write_csv(dat_sum, "Exporterad data från R.csv")           # Skriv datan till en csv-fil.

dat <- data.frame(Rad = c(1,2,3,4,5), x = c(6,3,2,3,5))    # Skapa en datamängd med kolumner Rad och x
dat

dat <- dat %>% 
  mutate(Medelvärde = mean(x))                   # Beräkna medelvärdet av x i en ny kolumn
dat

dat <- dat %>% 
  mutate(Differenser = x - Medelvärde)           # Beräkna differenser till medelvärdet
dat

dat <- dat %>% 
  mutate(Kvadrater = Differenser^2)              # Beräkna kvadrerade differenser
dat

dat_sum <- dat %>% 
  summarise(Kvadratsumma = sum(Kvadrater))       # Summera kvadraterna
dat_sum

dat_sum %>% mutate(Varians = Kvadratsumma / 4)   # Dela summan med fyra (antalet observationer minus 1)

var(dat$x)                                       # Dollartecken för att ta ut kolumnen x i objektet dat

dat_dice <- data.frame(Utfall = c(6,3,2,3,5)) %>%               # Skapa data med kolumnen Utfall, och sen
  mutate(Kast = 1:n())                                          # skapa en kolumn med antal kast från 1 löpande
dat_dice

dat_dice <- dat_dice %>%                                        # Ta datan, och sen
  mutate(`Kumulativ summa` = cumsum(Utfall),                    # skapa en kolumn som ger den kumulativa summan och
         `Kumulativt medelvärde` = `Kumulativ summa` / Kast)    # dela den kumulativa summan med antalet kast
dat_dice

library(plotly)

dat_ex <- data.frame(Var1 = c(1,2,3), Var2 = c(3,1,2), Var3 = c(2,3,1), Type = c("A", "B", "C"))
dat_ex

plot_ly(dat_ex, x = ~Var1, y = ~Var2, z = ~Var3, color = ~Type) %>% 
  add_markers()

