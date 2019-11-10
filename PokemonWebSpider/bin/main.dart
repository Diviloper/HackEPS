import 'package:PokemonWebSpider/pokemon.dart';
import 'package:PokemonWebSpider/scraper.dart' as scraper;
import 'package:PokemonWebSpider/builder.dart' as builder;

void main(List<String> arguments) async {
  print('Scraping pokemons');
  List<Pokemon> pokemons = await scraper.getPokemons();
  print('Pokemons scraped');
  print('Creating HTML');
  await builder.buildWeb(pokemons);
  print('HTML created');
}