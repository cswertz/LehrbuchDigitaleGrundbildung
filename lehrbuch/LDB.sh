#! /bin/bash
# Autor: Christian Swertz
# Lizenz: CC-BY
# Dieses Script erzeugt aus den Dateien für das Lehrbuch Digitale Grundbildung automatisch eine pdf - Version und eine epub-Version.
# Erforderliche Pakete: git, pandoc, texlive

# Dateien aktualisieren
# git pull origin master

# HTML - Start (Header) einfügen, dabei vorhandene Datei überschreiben
cat LDB_HtmlStart.html > LDB.html

# HTML - Code aus HTML - Dateien in allen Verzeichnissen an vorhandene Datei anhängen
find . -mindepth 2 -type f -name '*.html' | sort | xargs -i cat {} >> LDB.html

# HTML - Ende anhängen
cat LDB_HtmlEnde.html >> LDB.html

# Grafikdateien aus allen Verzeichnissen in aktuelles Verzeichnis kopieren
find . -mindepth 2 -name '*.jpg' -exec cp '{}' "./" ';'

# pdf und epub - Datei erzeugen
prince LDB.html
# pandoc LDB.html -s -o LDB.pdf
# pandoc LDB.html -s -o LDB.epub
# wkhtmltopdf LDB.html LDB.pdf

# Grafikdateien löschen
rm *.jpg

# Neue Dateien dem Repository hinzugügen
# git add LDB.pdf
# git add LDB.epub
# git commit -m "Neue Version erzeugt"

# Neue Dateien hochladen
# git push origin master


