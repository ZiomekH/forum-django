#!/bin/bash

sudo killall pgbouncer

sleep 3

dropdb -U postgres dfor
dropuser -U postgres django

#tworzenie
createuser -U postgres -D -R -S -w django
createdb -U postgres -E utf8 -O django dfor -T template0

sudo service pgbouncer start

sleep 3

../forum/manage.py syncdb

psql -U django -f slownik.sql dfor
psql -U django -f baza.sql dfor
