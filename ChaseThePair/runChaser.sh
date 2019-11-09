#!/bin/sh
set -e

echo '----------------------------------------'
echo '---------- Compilant buscador ----------'
echo '----------------------------------------'
g++ chaser.cpp -o chaser -std=c++17 -fopenmp

echo '----------------------------------------'
echo '------------ Creant entrada ------------'
echo '----------------------------------------'
echo 'Introdueix la mida dels sets: '
read SIZE
OUTPUT=$(printf ${SIZE}'\ny' | ./setsGenerator-linux-amd64)
CHASED=$(echo $OUTPUT| cut -d' ' -f 15)
python3 ./input.py

echo '----------------------------------------'
echo '---------- Executant buscador ----------'
echo '----------------------------------------'
printf ${SIZE}'\n'${CHASED} | ./chaser