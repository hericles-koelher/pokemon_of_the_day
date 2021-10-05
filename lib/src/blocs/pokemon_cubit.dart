import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pokemon_of_the_day/src/models/pokemon.dart';
import 'package:pokemon_of_the_day/src/repositories/pokemon_repository.dart';

part 'pokemon_state.dart';

class PokemonCubit extends HydratedCubit<PokemonState> {
  PokemonCubit() : super(PokemonInitial());

  void getPokemonOfTheDay() async {
    DateTime currentDate = DateUtils.dateOnly(DateTime.now());

    try {
      if (state is! PokemonLoaded || (state as PokemonLoaded).canBeUpdated) {
        emit(PokemonLoading());

        final PokemonRepository repository = PokemonRepository();

        int totalPokemon = await repository.getNumberTotalPokemon();

        var random = Random(currentDate.millisecond);

        int pokemonNumber = random.nextInt(totalPokemon) + 1;

        Pokemon pokemon = await repository.getPokemon(pokemonNumber);

        emit(PokemonLoaded(pokemon, currentDate));
      }
    } on DioError catch (e) {
      emit(PokemonLoadingError(e.message));
    }
  }

  @override
  PokemonState? fromJson(Map<String, dynamic> json) {
    if (json.containsKey("pokemon")) {
      return PokemonLoaded(
        Pokemon.fromJson(json["pokemon"]),
        DateTime.parse(json["date"]),
      );
    } else {
      return PokemonInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(PokemonState state) {
    if (state is PokemonLoaded) {
      return {
        "pokemon": state.pokemon.toJson(),
        "date": state.date.toString(),
      };
    } else {
      return null;
    }
  }
}
