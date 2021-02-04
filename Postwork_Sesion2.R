u1920 <- "https://www.football-data.co.uk/mmz4281/1920/D1.csv"
u1819 <- "https://www.football-data.co.uk/mmz4281/1819/D1.csv"
u1718 <- "https://www.football-data.co.uk/mmz4281/1718/D1.csv"


download.file(url = u1920, destfile = "SP1-1920.csv", mode = "wb")
download.file(url = u1819, destfile = "SP1-1819.csv", mode = "wb")
download.file(url = u1718, destfile = "SP1-1718.csv", mode = "wb")

dir()


lista <- lapply(c("SP1-1819.csv","SP1-1920.csv","u1920.csv"),read.csv)  

library(dplyr)


str(lista[1])
head(lista[1])
summary(lista[1])
View(lista[[1]])


lista <- lapply(lista,select,Date,HomeTeam:FTR)


lista <- lapply(lista,mutate,Date = as.Date(Date,format="%d/%m/%Y"))
head(lista[[1]]); head(lista[[2]]); head(lista[[3]])


data <- do.call(rbind, lista)


head(data)
