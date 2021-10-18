#! /bin/bash
# Autor: Christian Swertz
# Lizenz: CC-BY
# Dieses Script erzeugt aus den Dateien für das Lehrbuch Digitale Grundbildung automatisch eine pdf - Version und eine epub-Version.
# erforderliche Pakete: git, pandoc, texlive, prince
# start per cronjob 
# setzt für git - Zugriff gespeichertes Passwort voraus
# für git - Zugriff mit "LDB.sh server" aufrufen

if [ "$1" == server ]; then
  
  # Dateien aktualisieren, Abbruch wenn es nichts neues gibt
  if git pull origin master | grep up-to-date; 
    then exit 1
  fi

fi

# HTML - Start (Header) einfügen, dabei vorhandene Datei überschreiben
cat LDB_HtmlStart.html > LDB.html

# HTML - Code aus HTML - Dateien in allen Verzeichnissen an vorhandene Datei anhängen
find . -mindepth 2 -type f -name '*.html' | sort | xargs -i cat {} >> LDB.html

# HTML - Ende anhängen
cat LDB_HtmlEnde.html >> LDB.html

# Grafikdateien aus allen Verzeichnissen in aktuelles Verzeichnis kopieren
find . -mindepth 2 -name '*.jpg' -exec cp '{}' "./" ';'
find . -mindepth 2 -name '*.png' -exec cp '{}' "./" ';'
find . -mindepth 2 -name '*.gif' -exec cp '{}' "./" ';'

# pdf und epub - Datei erzeugen

prince LDB.html -o LDB.pdf

# Grafikdateien löschen
rm *.jpg *.png *.gif

if [ "$1" == server ]; then

  # Neue Dateien dem Repository hinzugügen
  git add LDB.pdf
  # git add LDB.epub
  now=$(date "+%d.%m.%Y %H:%M:%S")
  git commit -m "Neue pdf Version erzeugt am $now"

  # Neue Dateien hochladen
  git push origin master
  
fi
