#Postwork 1


#Importa los datos de soccer de la temporada 2019/2020 de la primera división de la liga española a R,
# los datos los puedes encontrar en el siguiente enlace: https://www.football-data.co.uk/spainm.php



suppressWarnings(suppressMessages(library(dplyr)))


u1920 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"


download.file(url = u1920, destfile = "u1920.csv", mode = "wb")

data <- read.csv("u1920.csv")

head(data)


#Del data frame que resulta de importar los datos a R, extrae las columnas que contienen los números de goles anotados
#por los equipos que jugaron en casa (FTHG) y los goles anotados por los equipos que jugaron como visitante (FTAG)

data <- select(data,c(FTHG,FTAG))

#Consulta cómo funciona la función table en R al ejecutar en la consola ?table

?table

# La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x = 0, 1, 2, ...)

table(X=data$FTHG)

#La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y = 0, 1, 2, ...)

table(X=data$FTAG)

#La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante
#anote y goles (x = 0, 1, 2, ..., y = 0, 1, 2, ...)

table(x=data)
