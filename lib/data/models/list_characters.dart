import 'package:bloc_app/data/models/characters.dart';

class ListCharacters {
  List<Character>? results;

  ListCharacters({this.results});

  factory ListCharacters.fromJson(Map<String, dynamic> json) {
    return ListCharacters(
      results: (json['results'] as List)
          .map((character) => Character.fromJson(character))
          .toList(),
    );
  }
}
