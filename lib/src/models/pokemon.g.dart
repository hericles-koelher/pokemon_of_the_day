// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pokemon _$PokemonFromJson(Map<String, dynamic> json) => Pokemon(
      number: json['number'] as int,
      name: json['name'] as String,
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
      description: json['description'] as String,
      spriteUrl: json['spriteUrl'] as String,
    );

Map<String, dynamic> _$PokemonToJson(Pokemon instance) => <String, dynamic>{
      'number': instance.number,
      'name': instance.name,
      'types': instance.types,
      'description': instance.description,
      'spriteUrl': instance.spriteUrl,
    };
