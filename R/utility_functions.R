
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
