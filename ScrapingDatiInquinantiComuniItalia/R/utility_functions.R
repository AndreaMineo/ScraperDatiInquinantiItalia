conversione_denominazione_comune <- function(x){
  x <- stringr::str_replace_all(x,'è','e')
  x <- stringr::str_replace_all(x,'é','e')
  x <- stringr::str_replace_all(x,'à','a')
  x <- stringr::str_replace_all(x,'ù','u')
  x <- stringr::str_replace_all(x,'ò','o')
  x <- stringr::str_replace_all(x,'ì','i')
  x <- stringr::str_replace_all(x,"'","")
  x <- stringr::str_replace_all(x," ","+")
  return(tolower(x))
}

formattazione_valori_inquinanti <- function(x){
  x <- stringr::str_replace_all(x," ","")
  x <- stringr::str_replace_all(x,"\n","")
  x <- stringr::str_replace_all(x,"PM10","")
  x <- stringr::str_replace_all(x,"PM2.5","")
  x <- stringr::str_replace_all(x,"CO","")
  x <- stringr::str_replace_all(x,"SO2","")
  x <- stringr::str_replace_all(x,"O3","")
  x <- stringr::str_replace_all(x,"NO2","")

  return(as.numeric(x))

}



estrai_valori_da_pagina_html <- function(x,url){
  page <- rvest::read_html(paste(url,x,sep = ''))
  node <- rvest::html_nodes(page,".col-xs-1-6")
  return(rvest::html_text(node))
}
