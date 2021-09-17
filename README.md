# TFM_HarkaitzGoyena
This repository contains the R code to fit with INLA the spatio-temporal models considered in the data analysis section of the paper _"Alleviating confounding in spatio-temporal areal models with an application on crimes against women in India"_ [(Adin et al., 2021)](https://journals.sagepub.com/doi/full/10.1177/1471082X211015452). It also contains the necessary functions to reproduce all the figures and tables of the article.


## Table of contents

- [Data](#Data)
- [R code](#R-code)
- [References](#References)


# Data
Dowry deaths and socio-demographic covariates in 70 districts of Uttar Pradesh, India, during the period 2001-2014. The data is publically available online without any form of restriction or copyright.

- [**DowryDeaths_UttarPradesh.txt**](https://github.com/spatialstatisticsupna/Confounding_article/blob/master/data/DowryDeaths_UttarPradesh.txt)
  
  This .txt file contains a data set with the following variables:
	- **_dist_**: Districts.
	- **_year_**: Year (from 2001 to 2014).
	- **_state_**: Uttar Pradesh.
	- **_obs_**: Number of dowry deaths.
	- **_pop_linear_**: Female population between 15 and 49 years (linear interpolation).
	- **_x1_**: Sex ratio. Number of women per 1,000 men. Source: Office of the Registrar General and Census Commissioner, India (http://censusindia.gov.in).
	- **_x2_**: Population density (people/km2). Source: Office of the Registrar General and Census Commissioner, India (http://censusindia.gov.in).
	- **_x3_**: Female literacy rate. Office of the Registrar General and Census Commissioner, India (http://censusindia.gov.in).
	- **_x4_**: Per capita income referenced to year 2004. Source: Directorate of Economics and Statistics Government of Uttar Pradesh  (http://updes.up.nic.in).
	- **_x5_**: Murder rate. Number of murders per 100,000 inhabitants. Source: Open Government Data Platform India (https://data.gov.in).
	- **_x6_**: Burglary rate. Number of burglaries per 100,000 inhabitants. Source: Open Government Data Platform India (https://data.gov.in).


- [**Uttar_Pradesh_nb.graph**](https://github.com/spatialstatisticsupna/Confounding_article/blob/master/data/Uttar_Pradesh_nb.graph)
  
  An inla.graph object with the spatial neighborhood structure of the 70 districts of Uttar Pradesh.


- [**carto_up.shp**](https://github.com/spatialstatisticsupna/Confounding_article/blob/master/data/carto_up/)

  Shapefile containing the cartography of the 70 districts of Uttar Pradesh.


# R code
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
