# ScraperDatiInquinantiComuniItalia

Pacchetto R per l'acquisizione automatica dei dati sulla concentrazione di inquinanti nell'aria per ciascun comune italiano.
Nello specifico le statistiche acquisite riguardano la concentrazione dei seguenti agenti inquinanti:

1) PM10
2) PM2.5
3) CO
4) SO2
5) O3
6) NO2

I dati sono acqusiti dal sito web https://www.3bmeteo.com/meteo che mette a disposizione i dati per ciascun comune italiano per la data odierna(non sono disponibili serie storiche).
Le denominazioni dei comuni,con la provincia e la regione di appartenenza, sono stati ricavati a partire dai dati ufficiali rilasciati dall'istat(aggiornati al 2022).

Per acqusire i dati basta invocare la funzione:

 ### ScrapingDatiInquinantiComuniItaliani(regione='all',provincia='all')
 
dove i parametri regione e provincia sono di tipo string(valore di default 'all').La funzione restituisce un dataframe contenente,per ciascun comune dell'insieme definito dai parametri passati alla funzione,le seguenti statistiche:

1) data (nel formato yyyy/m/d)
2) regione di appartenenza
3) provincia di appartenenza
4) valore concentrazione PM10(µg/m³)
5) valore concentrazione PM2.5(µg/m³)
6) valore concentrazione CO(µg/m³)
7) valore concentrazione SO2(µg/m³)
8) valore concentrazione O3(µg/m³)
9) valore concentrazione NO2(µg/m³)


 
Per ottenere i dati dei comuni di una specifica provincia invocare la funzione specificando la provincia e la regione di appartenenza della stessa:
 
  #### ScrapingDatiInquinantiComuniItaliani(regione=regione,provincia=provincia)
  
Per ottenere i dati dei comuni di una specifica regione invocare la funzione specificando la regione di interesse:

 #### ScrapingDatiInquinantiComuniItaliani(regione=regione)
 
Per ottenere i dati di ciascun comune italiano invocare la funzione senza parametri:

 #### ScrapingDatiInquinantiComuniItaliani()
