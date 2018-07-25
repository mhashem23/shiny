library(shiny)
library(dplyr)
library(ggplot2)
library(shinydashboard)
library(DT)

vgames <- read.csv(file = "~/Shiny_Project/Shiny_Project_PLZ/vgames.csv", stringsAsFactors = F)

### Clean

colSums(is.na(vgames))

vgames <- vgames[!is.na(vgames), ]
vgames <- vgames[!((vgames$Genre == "") | vgames$Year_of_Release %in% c(2020, 2017)), ]
vgames <- vgames[!(vgames$Year_of_Release == "N/A") | (vgames$Year_of_Release == 'NA'),]

######

xbox <- c("X360", "XB", "XOne")
nintendo <- c("Wii", "WiiU", "N64", "GC", "NES") 
playstation <- c("PS", "PS2", "PS3", "PS4")

woop = vgames %>%
  mutate(console_type = ifelse(Platform %in% xbox, "Xbox",
                        ifelse(Platform %in% nintendo, "Nintendo", 
                        ifelse(Platform %in% playstation, "Playstation",
                        "others")))) %>%
  group_by(console_type, Year_of_Release) %>%
  summarize(total = sum(Global_Sales))

###

vgames %>% group_by(Publisher, Year_of_Release) %>% 
  summarise(total = sum(Global_Sales)) %>% 
  arrange(desc(total))

toppubs = vgames %>%
  filter(Publisher %in% c("Electronic Arts", "Activision", "Ubisoft", "Namco Bandai Games", "Nintendo")) %>%
  group_by(Publisher, Year_of_Release) %>%
  summarize(total = sum(Global_Sales))


