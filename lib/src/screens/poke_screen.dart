import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_of_the_day/src/blocs/pokemon_cubit.dart';
import 'package:pokemon_of_the_day/src/models/pokemon.dart';

class PokeScreen extends StatelessWidget {
  // TODO: ajustar melhor essas cores.
  static final Map<String, Color> mapColors = {
    "Fire": Colors.deepOrange,
    "Fighting": Colors.red,
    "Water": Colors.blue,
    "Ghost": Colors.deepPurple,
    "Poison": Colors.purple,
    "Flying": Colors.deepPurpleAccent,
    "Grass": Colors.green,
    "Bug": Colors.lightGreen,
    "Electric": Colors.yellow,
    "Ground": Colors.amber,
    "Normal": Colors.amberAccent,
    "Rock": Colors.brown,
    "Psychic": Colors.pink,
    "Steel": Colors.grey,
    "Ice": Colors.lightBlueAccent,
    "Dragon": Colors.deepPurple,
    "Dark": Colors.brown,
    "Fairy": Colors.pinkAccent,
  };

  const PokeScreen({Key? key}) : super(key: key);

  List<Widget> _widgetsFromLoadedState(BuildContext context, Pokemon pokemon) {
    const circularRadius = Radius.circular(20);

    return [
      Expanded(
        flex: 3,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 10,
          ),
          alignment: Alignment.bottomCenter,
          child: Image.memory(
            pokemon.spriteUint8List,
          ),
        ),
      ),
      Expanded(
        flex: 2,
        child: Container(
          width: double.maxFinite,
          child: _buildPokemonData(context, pokemon),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: circularRadius,
              topRight: circularRadius,
            ),
          ),
        ),
      ),
    ];
  }

  // TODO: adicionar tags para tipos.
  Widget _buildPokemonData(BuildContext context, Pokemon pokemon) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "#${pokemon.number}",
            style: textTheme.headline4,
          ),
          Text(
            pokemon.name,
            style: textTheme.headline6,
          ),
          Text(
            "Description: ${pokemon.description}",
            style: textTheme.bodyText1,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonCubit, PokemonState>(
      bloc: BlocProvider.of<PokemonCubit>(context),
      builder: (BuildContext context, state) {
        List<Widget> children = [
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ];

        if (state is PokemonLoading) {
          children.add(
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        if (state is PokemonLoadingError) {
          // TODO: preparar uma exibição de erro
        }

        if (state is PokemonLoaded) {
          children.addAll(_widgetsFromLoadedState(context, state.pokemon));
        }

        Color? backgroundColor = state is PokemonLoaded
            ? mapColors[state.pokemon.types.first]
            : null;

        return Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        );
      },
    );
  }
}
