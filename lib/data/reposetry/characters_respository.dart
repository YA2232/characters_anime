import 'package:bloc_app/data/api/api_services.dart';
import 'package:bloc_app/data/models/characters.dart';

class CharactersRepository {
  ApiServices? apiServices;
  CharactersRepository({this.apiServices});

  Future<List<Character>> getAllCharacters() async {
    final characters = await apiServices?.getAllCharacters();
    return characters!
        .map((character) => Character.fromJson(character))
        .toList();
  }
}
