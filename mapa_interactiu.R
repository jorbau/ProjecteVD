install.packages("viridis")
install.packages("viridisLite")
install.packages("tidyverse")
install.packages("sf")
install.packages("ggthemes")
install.packages("gganimate")
install.packages("readxl")
install.packages('plotly')

library(viridis)
library(viridisLite)
library(tidyverse)
library(sf)
library(ggthemes)
library(gganimate)
library(readxl)
library(plotly)

### Importar Shapefile
shp <- st_read(dsn = "/Users/onafolchaloy/Desktop/Visualització de dades/Projecte/Estados_Unidos_Estados/Estados_Unidos_Estados.shp")
gv <- read.csv("/Users/onafolchaloy/Desktop/Visualització de dades/Projecte/gun_violence.csv")
gv <- gv %>% filter(longitude < 0)

gun_filter <- select(gv, state, n_killed,date) 
colnames(gun_filter)[1] <- "STATE_NAME"
gun_filter$date<-as.Date(as.character(gun_filter$date),format = "%Y-%m-%d")
gun_filter$Year<-format(gun_filter$date,"%Y")
group_gun <- gun_filter %>% group_by(STATE_NAME,Year) %>% summarize(n_killed = sum(n_killed))
head(group_gun)
shp2<-full_join(shp,group_gun,by="STATE_NAME")
shp2<-shp2%>%filter(Year>2012)
head(shp2)
gun_filter2 <- gun_filter %>% filter(Year>2012) %>% group_by(Year) %>% summarize(morts_total = sum(n_killed))
shp2 <- full_join(shp2,gun_filter2,by="Year")
class(shp2$Year) = "numeric"

go2<-go%>%filter(Year>2012)
go2 <- go2 %>% group_by(STATE) %>% summarize(HFR = mean(HFR))
colnames(go2)[1] <- "STATE_NAME"
full<-full_join(shp2,go2,by=c("STATE_NAME"))
full<-drop_na(full)

gv2<-head(gv, 1000)
gv2$date<-as.Date(as.character(gv2$date),format = "%Y-%m-%d")
gv2$year <- gv2$date
gv2$date<-format(gv2$date,"%m-%Y")
gv2$year <- format(gv2$year,"%Y")
graph2<-ggplot(NULL) + 
  geom_sf(data=shp2, aes(fill=n_killed), color="black") + 
  scale_fill_distiller(palette ="Blues", type="div", direction = 1, name="Morts")+
  ggtitle("Incidents d'armes a Estats Units i ombre de morts per estatGun Violence vs Gun ownership") +
  theme_bw()+
  geom_point(data = gv2,aes(longitude,latitude),fill="orange", colour="black",pch=21 ,size=1.5)+
  theme_fivethirtyeight()+
  theme(text=element_text(family="Calibri", color="royalblue3"))
ggplotly(graph2)
