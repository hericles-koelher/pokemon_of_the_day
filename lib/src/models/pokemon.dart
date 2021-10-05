import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
import 'package:pokemon_of_the_day/src/models/uint8list_converter.dart';

part 'pokemon.g.dart';

@JsonSerializable()
class Pokemon {
  final int number;
  final String name;
  final List<String> types;
  final String description;
  @Uint8ListConverter()
  final Uint8List spriteUint8List;

  Pokemon({
    required this.number,
    required this.name,
    required this.types,
    required this.description,
    required this.spriteUint8List,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonToJson(this);
}
