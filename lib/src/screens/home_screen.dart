import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_of_the_day/src/blocs/pokemon_cubit.dart';
import 'package:pokemon_of_the_day/src/screens/poke_screen.dart';
import 'package:pokemon_of_the_day/src/widgets/poke_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Who is your pokemon today?",
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
                // TODO: usar uma hero animation aqui.
                Image.asset("images/pikachu_silhouette.png"),
                PokeButton(
                  onPressed: () {
                    debugPrint("Button Pressed");

                    final pokemonCubit = BlocProvider.of<PokemonCubit>(context);

                    pokemonCubit.getPokemonOfTheDay();

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PokeScreen()),
                    );
                  },
                  child: Text(
                    "Discover",
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
