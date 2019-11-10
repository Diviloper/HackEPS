# Pokemon Web Spider
El scraper està fet en Dart i es pot executar usant el codi font i la màquina virtual de Dart o amb l'executable.

Amb cada execució el scraper genera una nova pàgina HTML amb un equip diferent (els 6 primers pokemons que troba que compleixin les restriccions). El [fitxer resultant](./lib/web/index.html) es troba a la carbeta [lib/web](./lib/web)

Per a utilitzar el codi font cal tenir Dart instal·lat i executar la següent comanda des del directori PokemonWebSpider:
```bash
dart bin/main.dart
```

Per utilitzar l'executable també s'ha d'executar des del directori PokemonWebSpider:
```bash
./bin/scraper.exe
```
Amb l'executable no cal tenir Dart instal·lat, però només funciona per a Windows.
