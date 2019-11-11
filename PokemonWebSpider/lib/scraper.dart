import 'package:PokemonWebSpider/pokemon.dart';
import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';

List<String> getPokedexLinks(Document document) {
  return document
      .querySelectorAll('a')
      .map((element) => element.attributes['href'])
      .where((link) => link.startsWith('/pokedex/'))
      .toList();
}

Future<Document> getDocument(Client client, String link) async =>
    parse((await client.get(link)).body);

Future<List<Pokemon>> getPokemons() async {
  final Client client = Client();
  final host = 'https://pokemondb.net';
  final home = await getDocument(client, host);
  List<String> links = getPokedexLinks(home)..shuffle();
  List<Pokemon> team = [];
  while (team.length < 6) {
    List<String> nextLinks = [];
    for (String link in links) {
      final document = await getDocument(client, '$host$link');
      if (Pokemon.isPokemonPage(document)) {
        try {
          final newPokemon = Pokemon.fromPage(host, link, document);
          if (canBeAdded(team, newPokemon)) {
            print('${newPokemon.name} scrapped');
            if (newPokemon.hasEvolutions()) {
              print('\tDiscarded because it has evolutions');
            } else {
              print('\tAdded to team');
              team.add(newPokemon);
              if (team.length == 6) break;
            }
          }
        } on PokException catch (_) {
          continue;
        }
      }
      nextLinks.addAll(getPokedexLinks(document));
    }
    links = nextLinks..shuffle();
  }
  return team;
}

bool canBeAdded(List<Pokemon> team, Pokemon newPokemon) =>
    newPokemon.types.length == 2 &&
    !team.any((pokemon) => pokemon.sameLine(newPokemon)) &&
    !team.any((pokemon) => pokemon.sameType(newPokemon));
