import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_of_the_day/src/blocs/pokemon_cubit.dart';

class PokeScreen extends StatelessWidget {
  const PokeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PokemonCubit, PokemonState>(
        bloc: BlocProvider.of<PokemonCubit>(context),
        builder: (BuildContext context, state) {
          if (state is PokemonLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PokemonLoadingError) {
            // TODO: preparar uma exibição de erro
          }

          if (state is PokemonLoaded) {
            return Container();
          }

          return Container();
        },
      ),
    );
  }
}
