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

  Esta carpeta contiene el script con el análisis realizado en R (*arma_tfm.R*), además de la función utilizada para generar automáticamente las predicciones para todos los valores de la serie de test (*forecast_arma.R*).
  
- [**NN**](https://github.com/spatialstatisticsupna/TFM_HarkaitzGoyena/blob/main/R/NN)

  Esta carpeta contiene scripts para entrenar y predecir con los distintos modelos de redes neuronales, además de funciones para seleccionar y generar los intervalos de predicción para éstas. Los scripts *nn_tfm_osh.R* y *nn_tfm_mf.R* corresponden al entrenamiento y predicción con modelos de redes neuronales de una capa oculta únicamente con las fecuencias significativas y añadiendo información de los 7 periodos anteriores a las frecuencias significativas, respectivamente. Los scripts *MLPml_73_mf.R* y *MLPml_2137_mf.R* corresponden a las redes multicapa entrenadas añadiendo información de los 7 periodos anteriores a las frecuencias significativas para las localizaciones 73 y 2137, respectivamente. El fichero *nn_funct.R* contiene las funciones para seleccionar el valor de &sigma; para el método DPC junto a la generación de los intervalos de predicciçon en test para dicho &sigma;.
  
  Además, esta carpeta contiene el script [graphs.R](https://github.com/spatialstatisticsupna/TFM_HarkaitzGoyena/blob/main/R/graphs.r), que contiene las órdenes utilizadas para generar las gráficas correspondientes a la representación de los datos.
