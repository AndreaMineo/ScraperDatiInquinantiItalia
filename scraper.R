library(rvest)
library(readr)
library(stringr)
library(sf)


current_date = format(Sys.Date(), format = "%Y/%m/%d")
url = 'https://www.3bmeteo.com/meteo/'

datiComuniItalia <- read.csv('datiComuniItalia.csv')

dati <- data.frame(data=as.Date(character()),regione=character(),provincia=character(),comune=character(),PM10=double(),PM2.5=double(),CO=double(),SO2=double(),O3=double(),NO2=double())


conversion <- function(x){
  x <- str_replace_all(x,'è','e')
  x <- str_replace_all(x,'é','e')
  x <- str_replace_all(x,'à','a')
  x <- str_replace_all(x,'ù','u')
  x <- str_replace_all(x,'ò','o')
  x <- str_replace_all(x,'ì','i')
  x <- str_replace_all(x,"'","")
  x <- str_replace_all(x," ","+")
  return(tolower(x))
}

format_value <- function(x){
  x <- str_replace_all(x," ","")
  x <- str_replace_all(x,"\n","")
  x <- str_replace_all(x,"PM10","")
  x <- str_replace_all(x,"PM2.5","")
  x <- str_replace_all(x,"CO","")
  x <- str_replace_all(x,"SO2","")
  x <- str_replace_all(x,"O3","")
  x <- str_replace_all(x,"NO2","")
  
  
  return(as.numeric(x))
  
}



get_values <- function(x){
  tryCatch({page <- read_html(paste(url,x,sep = ''));
            values <- page %>% html_nodes(".col-xs-1-6") %>% html_text()},
            error = function(e){values <- c("0","0","0","0","0","0")})
  return(values)
}



retrieve_data <- function(regione='all',provincia='all'){
  
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
  
  
  for(i in 1:nrow(df)){
   c = df[i,]$comune
   p = df[i,]$provincia
   r = df[i,]$regione
  
   x <- conversion(c)
   values <- get_values(x)
   values <- lapply(values,format_value)
   dati[nrow(dati)+1,] <- c(c(current_date,r,p,c),values)
  
   print(paste("retrieved data: ",as.character(i),"/",as.character(nrow(df))))
  }
  
  return(dati)
}

### Per ottenere i dati dei comuni di una specifica provincia:
### dati <- retrieve_data(regione=regione,provincia = provincia)

### Per ottenere i dati dei comuni di una specifica regione:
### dati <- retrieve_data(regione=regione)

### Per ottenere i dati di tutti i comuni italiani:
### dati <- retrieve_data()

 
