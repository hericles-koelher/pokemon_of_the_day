import 'package:json_annotation/json_annotation.dart';

part 'pokemon.g.dart';

@JsonSerializable()
class Pokemon {
  final int number;
  final String name;
  final List<String> types;
  final String description;
  final String spriteUrl;

  Pokemon({
    required this.number,
    required this.name,
    required this.types,
    required this.description,
    required this.spriteUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonToJson(this);
}
