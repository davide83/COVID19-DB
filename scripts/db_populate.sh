#!/bin/bash

############## 
# REQUIREMENTS
# csvkit - sudo pip install csvkit

############## 
# Setup your workspace
#DB_PATH=databases/sqlite/dpc-covid19-ita_db.sqlite3 ### Passed as ENV
CSV_DIR=/tmp/dpccovid19itacsvs
mkdir -p $CSV_DIR

################ 
# Download the files into $CSV_DIR
curl https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-andamento-nazionale/dpc-covid19-ita-andamento-nazionale.csv \
      -o $CSV_DIR/dpc-covid19-ita-andamento-nazionale.csv
curl https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-regioni/dpc-covid19-ita-regioni.csv \
      -o $CSV_DIR/dpc-covid19-ita-regioni.csv
curl https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-province/dpc-covid19-ita-province.csv \
      -o $CSV_DIR/dpc-covid19-ita-province.csv
curl https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/note/dpc-covid19-ita-note-it.csv \
      -o $CSV_DIR/dpc-covid19-ita-note-it.csv      
curl https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/note/dpc-covid19-ita-note-en.csv \
      -o $CSV_DIR/dpc-covid19-ita-note-en.csv  

#####################
# Insert the data

## Insert the andamento_nazionale data
csvsql $CSV_DIR/dpc-covid19-ita-andamento-nazionale.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables andamento_nazionale
csvsql $CSV_DIR/dpc-covid19-ita-regioni.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables dati_regioni    
csvsql $CSV_DIR/dpc-covid19-ita-province.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables dati_province
csvsql $CSV_DIR/dpc-covid19-ita-note-it.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables note_it
csvsql $CSV_DIR/dpc-covid19-ita-note-en.csv  \
    --db sqlite:///$DB_PATH --insert --no-create \
    --tables note_en

#####################
# EXIT
exit 0