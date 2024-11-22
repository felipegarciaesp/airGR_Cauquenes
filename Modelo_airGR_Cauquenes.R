rm(list=ls())
graphics.off()

# =====================================================================
# Modelo airGR para Cuenca Cauquenes / Felipe Garcia
# =====================================================================

# Instalacion de paquetes:
#install.packages("airGR")
#install.packages("zoo")
#install.packages("openxlsx")
#install.packages("hydroGOF")
#install.packages("hydroTSM")

# Carga de paquetes:
library(zoo)
library(airGR)
library (openxlsx)
library(hydroGOF)
library(hydroTSM)
library(readr)
library(dplyr)
library(tibble)

# Paquete tibble es para ocupar column_to_rownames, que nos permite dejar una 
# columna como indice del dataframe y eliminarlo como columna del dataframe.

# Seteamos el directorio de trabajo donde trabajaremos
setwd('C:/Users/Usuario/Codigos_R/tarea_etp_mensual')

# Se identifica nombre de la carpeta a utilizar:
carpeta <- "camels_cl_7336001"
ruta_archivos <- paste0(getwd(),"/",carpeta)

# Se identifican nombres de archivos:
pp_mon <- "precip_cr2met_mon.csv"
tmax_mon <- "tmax_cr2met_mon.csv"
tmin_mon <- "tmin_cr2met_mon.csv"

# Se identifican rutas de estos archivos:
ruta_pp_mon <- paste0(ruta_archivos,"/",pp_mon)
ruta_tmax_mon <- paste0(ruta_archivos,"/",tmax_mon)
ruta_tmin_mon <- paste0(ruta_archivos,"/",tmin_mon)

# Se cargan los archivos requeridos (pp, tmax y tmin):
PPload <- read_csv(ruta_pp_mon)
tmax_load <- read_csv(ruta_tmax_mon)
tmin_load <- read_csv(ruta_tmin_mon)

# Dejamos los dataframe solo con fecha y la data de interes:
PPload <- PPload %>% select('date','7336001') %>% rename('Pp (mm)' = '7336001')
tmax_load <- tmax_load %>% select('date','7336001') %>% rename('tmax (deg)' = '7336001')
tmin_load <- tmin_load %>% select('date','7336001') %>% rename('tmin (deg)' = '7336001')

# Calculamos la temperatura promedio y lo almacenamos en un nuevo dataframe:
# 1ero, combinamos los df por la columna 'date':
temp_combined <- left_join(tmax_load, tmin_load, by='date')

# 2do, calculamos la temperatura promedio usando mutate y rowMeans:
temp_avg <- temp_combined %>% 
  mutate(temperature_avg = rowMeans(select(., 'tmax (deg)', 'tmin (deg)'), na.rm = TRUE)) %>% 
  select(date, temperature_avg)








