part of 'pokemon_cubit.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object> get props => [];
}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonLoaded extends PokemonState {
  final Pokemon pokemon;
  final DateTime date;

  bool get canBeUpdated =>
      !date.isAtSameMomentAs(DateUtils.dateOnly(DateTime.now()));

  const PokemonLoaded(this.pokemon, this.date) : super();

  @override
  List<Object> get props => [date];
}

class PokemonLoadingError extends PokemonState {
  final String message;

  const PokemonLoadingError(this.message);
}
