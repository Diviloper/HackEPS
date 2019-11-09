# Chase The Pair Challenge by HackEPS2019

## Descripció
Script fet en C++ ([chaser.cpp](./chaser.cpp)) amb un script extra en Python ([input.py](./input.py)) per a transformar la sortida del Generador de sets a una més fàcil de llegir per el programa.

També s'ha fet un script de Bash ([runChaser.sh](./runChaser.sh)) per a fer l'execució molt més senzilla, al que només se li ha d'introduir la mida dels sets.

El script en C++ executa el problema dues vegades, primer de forma normal i després repartint la feina en tants threads com sigui possible.

El script de Bash necessita g++ i python3

Arquitectura: Linux AMD64

## Informació
- Nom: Víctor Diví
- Cost: Lineal
- Temps emprat: 0,035s
- Mida sets: 10.000.000
