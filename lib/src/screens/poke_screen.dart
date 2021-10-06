import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_of_the_day/src/blocs/pokemon_cubit.dart';
import 'package:pokemon_of_the_day/src/models/pokemon.dart';
import 'package:pokemon_of_the_day/src/widgets/poke_tag.dart';

class PokeScreen extends StatelessWidget {
  static final Map<String, Color> mapColors = {
    "Fire": const Color(0xFFEE8130),
    "Fighting": const Color(0xFFC22E28),
    "Water": const Color(0xFF6390F0),
    "Ghost": const Color(0xFF735797),
    "Poison": const Color(0xFFA33EA1),
    "Flying": const Color(0xFFA98FF3),
    "Grass": const Color(0xFF7AC74C),
    "Bug": const Color(0xFFA6B91A),
    "Electric": const Color(0xFFF7D02C),
    "Ground": const Color(0xFFE2BF65),
    "Normal": const Color(0xFFA8A77A),
    "Rock": const Color(0xFFB6A136),
    "Psychic": const Color(0xFFF95587),
    "Steel": const Color(0xFFB7B7CE),
    "Ice": const Color(0xFF96D9D6),
    "Dragon": const Color(0xFF6F35FC),
    "Dark": const Color(0xFF705746),
    "Fairy": const Color(0xFFD685AD),
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

  Widget _buildPokemonData(BuildContext context, Pokemon pokemon) {
    final textTheme = Theme.of(context).textTheme;

    List<PokeTag> types = pokemon.types.map((type) {
      return PokeTag(
        type: type,
        color: mapColors[type]!,
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "#${pokemon.number}",
            style: textTheme.headline4,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  pokemon.name,
                  style: textTheme.headline5,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: types,
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Text(
              pokemon.description,
              style: textTheme.headline6,
              textAlign: TextAlign.center,
            ),
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
            icon: Icon(
              Icons.arrow_back,
              color: state is PokemonLoaded ? Colors.white : Colors.grey[900],
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
