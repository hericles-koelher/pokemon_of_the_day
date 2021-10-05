import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pokemon_of_the_day/src/config.dart';
import 'package:pokemon_of_the_day/src/models/pokemon.dart';

class PokemonRepository {
  final Dio _dio = Dio();

  Future<int> getNumberTotalPokemon() async {
    final response = await _dio.get(kPokemonCountApiUrl);

    if (response.statusCode != 200) {
      throw HttpException(
          response.statusMessage ?? "Bad status code: ${response.statusCode}");
    }

    return response.data["total"];
  }

  Future<Pokemon> getPokemon(int pokedexNumber) async {
    // API bugadinha hein...

    // final response = await _dio
    //     .get(kPokemonApiUrl, queryParameters: {"slug": pokedexNumber});

    final response = await _dio.get(kPokemonApiUrl + pokedexNumber.toString());

    var pokemonData = (response.data as List).first;

    return Pokemon(
      number: int.parse(pokemonData["number"]),
      name: pokemonData["name"],
      types: pokemonData["types"].cast<String>(),
      description: pokemonData["description"],
      spriteUrl: pokemonData["sprite"],
    );
  }
}
