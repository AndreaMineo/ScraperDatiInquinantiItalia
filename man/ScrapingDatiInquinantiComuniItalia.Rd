% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ScrapingDatiInquinantiComuniItalia.R
\name{ScrapingDatiInquinantiComuniItalia}
\alias{ScrapingDatiInquinantiComuniItalia}
\title{Scraping Dati Inquinanti Comuni Italia}
\usage{
ScrapingDatiInquinantiComuniItalia(regione = "all", provincia = "all")
}
\arguments{
\item{regione}{String : regione di interesse (default "all")}

\item{provincia}{String: provincia di interesse (default "all")}
}
\value{
data.Frame : dataframe con le seguenti colonne (data,regione,provincia,comune,PM10,PM2.5,CO,SO2,O3,NO2)
}
\description{
Recupera i dati per la data corrente sulla concentrazione di 6 tra i principali agenti inquinanti(PM10,PM2.5,CO,SO2,O3,NO2) da sito web
'https://www.3bmeteo.com/meteo/'
}
\examples{
df <- ScrapingDatiInquinantiComuniItalia()
df <- ScrapingDatiInquinantiComuniItalia(regione ="Lombardia")
df <- ScrapingDatiInquinantiComuniItalia(regione ="Sicilia",provincia="Catania")

}
