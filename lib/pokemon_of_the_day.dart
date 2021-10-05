import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_of_the_day/src/blocs/pokemon_cubit.dart';
import 'package:pokemon_of_the_day/src/screens/home_screen.dart';

class PokemonOfTheDay extends StatelessWidget {
  const PokemonOfTheDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PokemonCubit>(
      create: (_) => PokemonCubit(),
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
