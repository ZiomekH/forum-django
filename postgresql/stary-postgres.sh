#!/bin/bash

#usuwanie
dropdb -U postgres dfor
dropuser -U postgres django

#tworzenie
createuser -U postgres -D -R -S -w django
createdb -U postgres -E utf8 -O django dfor -T template0

./forum/manage.py syncdb

psql -U django -f baza.sql dfor