part of 'game_bloc.dart';

sealed class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

//evento de comenzar el juego
class GameStart extends GameEvent {}

//evento de seleccionar una letra
class GameSelectChar extends GameEvent {
  final String palabra;
  final List<String> selectedChar;
  final String char;
  final int tries;
  final String pista;

  const GameSelectChar(
    this.char,
    this.selectedChar,
    this.palabra,
    this.tries,
    this.pista,
  );

  @override
  List<Object> get props => [char];
}
