import 'package:PokemonWebSpider/pokemon.dart';
import 'package:PokemonWebSpider/scraper.dart' as scraper;
import 'package:PokemonWebSpider/builder.dart' as builder;

void main(List<String> arguments) async {
  List<Pokemon> pokemons = await scraper.getPokemons();
  await builder.buildWeb(pokemons);
  print('Webpage created');
}