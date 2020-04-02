#!/bin/bash

############## 
# REQUIREMENTS
# sqlite3 - sudo apt-get install sqlite3

############## 
# Setup your workspace
#DB_PATH=databases/sqlite/dpc-covid19-ita_db.sqlite3 ### Passed as ENV

#################
# Build the database

# First remove the existing database file, if any
rm -f $DB_PATH

## Create the andamento_nazionale table
echo "CREATE TABLE andamento_nazionale (
  data DATE, 
  stato VARCHAR, 
  ricoverati_con_sintomi INTEGER, 
  terapia_intensiva INTEGER, 
  totale_ospedalizzati INTEGER, 
  isolamento_domiciliare INTEGER, 
  totale_positivi INTEGER,
  variazione_totale_positivi INTEGER, 
  nuovi_positivi INTEGER,
  dimessi_guariti INTEGER, 
  deceduti INTEGER, 
  totale_casi INTEGER, 
  tamponi INTEGER, 
  note_it VARCHAR, 
  note_en VARCHAR
);" | sqlite3 $DB_PATH

## Create the dati_regioni table
echo "CREATE TABLE dati_regioni (
  data DATE, 
  stato VARCHAR, 
  codice_regione VARCHAR, 
  denominazione_regione VARCHAR,
  lat FLOAT, 
  long FLOAT, 
  ricoverati_con_sintomi INTEGER,
  terapia_intensiva INTEGER,
  totale_ospedalizzati INTEGER,
  isolamento_domiciliare INTEGER,
  totale_positivi INTEGER,
  variazione_totale_positivi INTEGER,  
  nuovi_positivi INTEGER,
  dimessi_guariti INTEGER,
  deceduti INTEGER,
  totale_casi INTEGER,
  tamponi INTEGER,         
  note_it VARCHAR, 
  note_en VARCHAR
);" | sqlite3 $DB_PATH

## Create the dati_province table
echo "CREATE TABLE dati_province (
  data DATE, 
  stato VARCHAR, 
  codice_regione VARCHAR, 
  denominazione_regione VARCHAR, 
  codice_provincia VARCHAR, 
  denominazione_provincia VARCHAR, 
  sigla_provincia VARCHAR, 
  lat FLOAT, 
  long FLOAT, 
  totale_casi INTEGER,
  note_it VARCHAR, 
  note_en VARCHAR
);" | sqlite3 $DB_PATH

## Create the note_it table
echo "CREATE TABLE note_it (
  codice VARCHAR,
  data DATE,
  dataset VARCHAR,
  stato VARCHAR, 
  codice_regione VARCHAR,
  regione VARCHAR,   
  codice_provincia VARCHAR, 
  provincia VARCHAR,
  sigla_provincia VARCHAR,
  tipologia_avviso VARCHAR, 
  avviso VARCHAR,  
  note VARCHAR
);" | sqlite3 $DB_PATH

## Create the note_en table
echo "CREATE TABLE note_en (
  codice VARCHAR,
  data DATE,
  dataset VARCHAR,
  stato VARCHAR, 
  codice_regione VARCHAR, 
  regione VARCHAR, 
  codice_provincia VARCHAR, 
  provincia VARCHAR,
  sigla_provincia VARCHAR,
  tipologia_avviso VARCHAR, 
  avviso VARCHAR,  
  note VARCHAR
);" | sqlite3 $DB_PATH

#####################
# EXIT
exit 0