import 'package:equatable/equatable.dart';
import 'package:html/dom.dart';

class PokException implements Exception {
}

class Pokemon with EquatableMixin {
  int pokedexNumber;
  String name;
  List<String> types;
  String spriteLink;
  String pageLink;
  List<String> evolutionLineLinks;

  Pokemon.fromPage(String host, String link, Document document) {
    try {
      this.pageLink = '$host$link';
      final headers = document.getElementsByTagName('th');
      final numberHeader =
          headers.firstWhere((header) => header.innerHtml == 'National №');
      this.pokedexNumber =
          int.parse(numberHeader.parent.querySelector('td > strong').innerHtml);
      this.name = document.getElementsByTagName('h1').first.innerHtml;
      final typeHeader =
          headers.firstWhere((header) => header.innerHtml == 'Type');
      this.types = typeHeader.parent
          .querySelectorAll('td > a')
          .map((a) => a.innerHtml)
          .toList();
      this.spriteLink = document
          .getElementsByTagName('a')
          .firstWhere((a) =>
              a.attributes.containsKey('data-title') &&
              a.attributes['data-title'].endsWith('official artwork'))
          .attributes['href'];
      final evoList = document.getElementsByClassName('infocard-list-evo');
      this.evolutionLineLinks = evoList.isEmpty
          ? []
          : evoList.first
              .getElementsByClassName('ent-name')
              .map((element) => '$host${element.attributes['href']}')
              .toList();
    } catch (_) {
      throw PokException();
    }
  }

  @override
  List get props => [name];

  static bool isPokemonPage(Document document) {
    return document
        .getElementsByTagName('h2')
        .any((element) => element.innerHtml == 'Pokédex data');
  }

  bool sameLine(Pokemon other) {
    return evolutionLineLinks.contains(other.pageLink);
  }

  @override
  String toString() {
    return '$name: $pokedexNumber - ${types.toString()}';
  }
}
