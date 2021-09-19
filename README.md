# TFM_HarkaitzGoyena
Este repositoriio contiene el código R utilizado en la experimentación para el Trabajo de Fin de Máster _"Predicciones a corto plazo en series
temporales de alta frecuencia"_ realizado por Harkaitz Goyena Baroja y dirigido por Aritz Adin y Guzmán Santafé. Además de las funciones necesarias para generar las gráficas de dicho trabajo.


## Índice

- [Datos](#Datos)
- [Código R](#CódigoR)
- [References](#References)


# Datos

Esta carpeta contiene los ficheros con las observaciones de la velocidad residual del viento para las dos localizaciones de Arabia Saudí analizadas. Los cuales se han obtenido de (https://repository.kaust.edu.sa/handle/10754/667127)

- [**Wind_res73.rds**]
  
- [**Wind_res2137.rds**]

Ambos contienen las observaciones de los residuales de la velocidad del viento entre 2013 y 2016.


- [**Uttar_Pradesh_nb.graph**](https://github.com/spatialstatisticsupna/Confounding_article/blob/master/data/Uttar_Pradesh_nb.graph)
  
  An inla.graph object with the spatial neighborhood structure of the 70 districts of Uttar Pradesh.


- [**carto_up.shp**](https://github.com/spatialstatisticsupna/Confounding_article/blob/master/data/carto_up/)

  Shapefile containing the cartography of the 70 districts of Uttar Pradesh.


# Código R
R code to fit with INLA (http://www.r-inla.org/) the spatio-temporal models considered in the data analysis section of the present paper, and code to reproduce all the figures and tables. All the R files are written by the authors of the paper using R version 4.0.3 (2020-10-10).

- [**DataAnalysis_INLA.R**](https://github.com/spatialstatisticsupna/Confounding_article/blob/master/R/DataAnalysis_INLA.R)

  This R script contains the necessary functions to replicate with INLA the fit of the spatio-temporal models considered in the data analysis section of the paper. The code can be used with any other data sets with similar structure.
  
- [**Figures_and_Tables.R**](https://github.com/spatialstatisticsupna/Confounding_article/blob/master/R/Figures_and_Tables.R)
 
 
  This R script contains the necessary functions to reproduce all the figures and tables of the data analysis section of the present paper. The fitted models with INLA and PQL can be download from [DataAnalysis_INLA.Rdata](https://emi-sstcdapp.unavarra.es/Confounding_article/data/DataAnalysis_INLA.Rdata) and [DataAnalysis_PQL.Rdata](https://emi-sstcdapp.unavarra.es/Confounding_article/data/DataAnalysis_PQL.Rdata), respectively.

### Dealing with large datasets
When the number of small areas (denoted as S) and/or time periods (denoted as T) is large, fitting restricted regression models with INLA could be computationally very demanding due to the large and dense design matrices of the spatial, temporal and spatio-temporal random effects. The [**following code**](https://github.com/spatialstatisticsupna/Confounding_article/blob/master/R/DataAnalysis_INLA_fast.R) should be used in those cases where the posterior distributions of the fixed effects for the restricted regression models are estimated as a linear combination of the log-risks and the random effects of the models without accounting for confounding using the `INLA::inla.make.lincombs()` function.


Note that if we write the spatial model without accounting for confounding as

log(r)=X&beta; + &xi;

and the spatial restricted regression model as

log(r)=X&beta;<sup>*</sup> + W<sup>-1/2</sup>LL&prime;W<sup>-1/2</sup>&xi;

the vector of fixed effects &beta;<sup>*</sup> can be computed using the following expression:

&beta;<sup>*</sup> = (X<sup>t</sup>X)<sup>-1</sup>X<sup>t</sup>[log(r)-W<sup>-1/2</sup>LL&prime;W<sup>-1/2</sup>&xi;]

A similar approach is used to estimate the restricted regression spatio-temporal model described in Adin et al. (2021).


# Acknowledgements
This work has been supported by the Spanish Ministry of Economy, Industry, and Competitiveness (project MTM2017-82553-R, AEI/FEDER, UE), and partially funded by la Caixa Foundation (ID 1000010434), Caja Navarra Foundation and UNED Pamplona, under agreement LCF/PR/PR15/51100007.

# References
[Adin, A., Goicoa, T., Hodges, J.S., Schnell, P., and Ugarte, M.D. (2021). Alleviating confounding in spatio-temporal areal models with an application on crimes against women in India. _Statistical Modelling (online first)_. DOI: 10.1177/1471082X211015452](https://journals.sagepub.com/doi/full/10.1177/1471082X211015452)
