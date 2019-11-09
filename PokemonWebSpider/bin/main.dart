import 'package:PokemonWebSpider/pokemon.dart';
import 'package:PokemonWebSpider/pokemonScraper.dart' as pokemon_scraper;

void main(List<String> arguments) async {
  List<Pokemon> pokemons = await pokemon_scraper.getPokemons();
  print(pokemons);
}