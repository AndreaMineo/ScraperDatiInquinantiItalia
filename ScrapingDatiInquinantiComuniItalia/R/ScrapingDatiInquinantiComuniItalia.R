#' Scraping Dati Inquinanti Comuni Italia
#'
#' Recupera i dati per la data corrente sulla concentrazione di 6 tra i principali agenti inquinanti(PM10,PM2.5,CO,SO2,O3,NO2) da sito web
#' 'https://www.3bmeteo.com/meteo/'
#'
#' @param regione String : regione di interesse (default "all")
#' @param provincia String: provincia di interesse (default "all")
#'
#' @return data.Frame : dataframe con le seguenti colonne (data,regione,provincia,comune,PM10,PM2.5,CO,SO2,O3,NO2)
#' @export
#'
#' @examples df <- ScrapingDatiInquinantiComuniItalia()
#' @examples df <- ScrapingDatiInquinantiComuniItalia(regione ="Lombardia")
#' @examples df <- ScrapingDatiInquinantiComuniItalia(regione ="Sicilia",provincia="Catania")
#'
ScrapingDatiInquinantiComuniItalia <- function(regione='all',provincia='all'){

  current_date = format(Sys.Date(), format = "%Y-%m-%d")
  url = 'https://www.3bmeteo.com/meteo/'

  dati <- data.frame(data=character(),regione=character(),provincia=character(),comune=character(),PM10=double(),PM2.5=double(),CO=double(),SO2=double(),O3=double(),NO2=double())

  lista_regioni <- unique(datiComuniItalia$regione)

  if(regione %in% lista_regioni){

    lista_province <- unique(datiComuniItalia[datiComuniItalia$regione==regione,]$provincia)

    if(provincia %in% lista_province){

      df <- datiComuniItalia[datiComuniItalia$provincia == provincia,]

    }else if(provincia == 'all'){

      df <- datiComuniItalia[datiComuniItalia$regione == regione,]

    }else{

      print("Valore provincia non valido")
      print("Selezionare uno tra i seguenti")
      print(c("all",lista_province))
      return()
    }
  }else if(regione=='all'){

    df <- datiComuniItalia
  }else{

    print("Valore regione non valido")
    print("Selezionare uno tra i seguenti")
    print(c("all",lista_regioni))
    return()
  }

  df <- df[order(df$regione,df$provincia,df$comune),]
  dati <- unlist(lapply(1:nrow(df),function(i){
    c = df[i,]$comune
    p = df[i,]$provincia
    r = df[i,]$regione
    x <- df[i,]$nome_comune_convertito

    values <- estrai_valori_da_pagina_html(x,url)
    values <- lapply(values,formattazione_valori_inquinanti)
    dati[nrow(dati)+1,] <- c(c(current_date,r,p,c),values)

    print(paste("retrieved data: ",as.character(i),"/",as.character(nrow(df))))
  }))

  return(dati)
}
