# TFM_HarkaitzGoyena
Este repositorio contiene el código R utilizado en la experimentación para el Trabajo de Fin de Máster _"Predicciones a corto plazo en series
temporales de alta frecuencia"_ realizado por Harkaitz Goyena Baroja y dirigido por Aritz Adin y Guzmán Santafé. Además de las funciones necesarias para generar las gráficas de dicho trabajo.


## Índice

- [Datos](#Datos)
- [Código R](#CódigoR)

# Datos

Esta carpeta contiene los ficheros con las observaciones de la velocidad residual del viento para las dos localizaciones de Arabia Saudí analizadas. Los cuales se han obtenido del fichero *wind_residual.nc* de https://repository.kaust.edu.sa/handle/10754/667127.

- [**Wind_res73.rds**](https://github.com/spatialstatisticsupna/TFM_HarkaitzGoyena/blob/main/Datos/Wind_res73.rds)
  
- [**Wind_res2137.rds**](https://github.com/spatialstatisticsupna/TFM_HarkaitzGoyena/blob/main/Datos/Wind_res2137.rds)

Ambos contienen las observaciones de los residuales de la velocidad del viento entre 2013 y 2016.

# Código R
El código de R correspondiente al análisis, se divide en dos carpetas principales.

- [**ARMA**](https://github.com/spatialstatisticsupna/TFM_HarkaitzGoyena/blob/main/R/ARMA)

  Esta carpeta contiene el script con el análisis realizado en R, además de la función utilizada para generar automáticamente las predicciones para todos los valores de la serie de test.
  
- [**NN**](https://github.com/spatialstatisticsupna/TFM_HarkaitzGoyena/blob/main/R/NN)

  Esta carpeta contiene scripts para entrenar y predecir con los distintos modelos de redes neuronales, además de funciones para seleccionar y generar los intervalos de predicción para éstas.
  
  Además, esta carpeta contiene el script [graphs.R](https://github.com/spatialstatisticsupna/TFM_HarkaitzGoyena/blob/main/R/graphs.r), que contiene las órdenes utilizadas para generar las gráficas correspondientes a la representación de los datos.
