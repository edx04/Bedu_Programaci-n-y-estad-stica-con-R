u1920 <- "https://www.football-data.co.uk/mmz4281/1920/D1.csv"
u1819 <- "https://www.football-data.co.uk/mmz4281/1819/D1.csv"
u1718 <- "https://www.football-data.co.uk/mmz4281/1718/D1.csv"


download.file(url = u1920, destfile = "SP1-1920.csv", mode = "wb")
download.file(url = u1819, destfile = "SP1-1819.csv", mode = "wb")
download.file(url = u1718, destfile = "SP1-1718.csv", mode = "wb")


dir()

lista <- lapply(c("SP1-1819.csv","SP1-1920.csv","u1920.csv"),read.csv)  

summary(lista)


lista <- lapply(lista,select,FTHG,FTAG)


data <- do.call(rbind, lista)


p_local <- prop.table(table(X=data$FTHG))

p_vist <- prop.table(table(X=data$FTAG))

p_con <- prop.table(table(local=data$FTHG,visita=data$FTAG))

dimnames(p_con)

p_con
library(dplyr)
library(ggplot2)



barplot(p_local, main = " Probabilidades marginales de goles que anota el equipo de casa",
     xlab = "Goles",
     ylab = "Frecuencia")

barplot(p_vist, main = " Probabilidades marginales de goles que anota el equipo visitante",
        xlab = "Goles",
        ylab = "Frecuencia")





ggplot(data=as.data.frame(p_con),aes(x = local, y = visita,fill = Freq)) + geom_tile()




