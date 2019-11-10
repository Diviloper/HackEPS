import 'dart:io' as io;

import 'package:PokemonWebSpider/pokemon.dart';

Future<void> buildWeb(List<Pokemon> pokemons) async {
  List<String> pokemonCards =
      await Future.wait(pokemons.map(pokemonToCard).toList());
  Map<String, String> cards = {
    for (int i = 0; i < 6; ++i) 'pokemon_$i': pokemonCards[i]
  };
  String web = await renderHTML('lib/web/html/base.html', cards);
  io.File('lib/web/index.html').writeAsStringSync(web);
}

Future<String> pokemonToCard(Pokemon pokemon) async {
  final data = {
    'pokemon_name': pokemon.name,
    'sprite_link': pokemon.spriteLink,
    'pokedex_number': pokemon.pokedexNumber.toString(),
    'pokemon_type_0': pokemon.types[0],
    'pokemon_type_1': pokemon.types[1],
    'pokedex_link': pokemon.pageLink
  };
  return await renderHTML('lib/web/html/pokeCard.html', data);
}

Future<String> renderHTML(
  String path,
  Map<String, String> templateVariables,
) async {
  final template = await _loadHTMLTemplate(path);
  return template.replaceAllMapped(RegExp("{{([a-zA-Z0-9_]+)}}"), (match) {
    final key = match.group(1);
    return templateVariables[key] ?? "null";
  });
}

Future<String> _loadHTMLTemplate(String path) async =>
    io.File(path).readAsStringSync();
